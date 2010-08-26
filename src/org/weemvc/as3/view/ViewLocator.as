﻿/**
 * WeeMVC - Copyright(c) 2008
 * 视图集合类
 * @author	weemve.org
 * 2009-1-5 14:06
 */
package org.weemvc.as3.view {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.core.Notifier;
	import org.weemvc.as3.core.INotifier;
	import org.weemvc.as3.core.Observer;
	import org.weemvc.as3.core.IObserver;
	import org.weemvc.as3.WeemvcError;
	import org.weemvc.as3.PaperLogger;
	
	import flash.display.MovieClip;
	/**
	 * 视图集合类。
	 * 
	 * <p>
	 * 保存所有的视图类。通过它,你可以找到你想要的视图。
	 * </p>
	 * 
	 * @see org.weemvc.as3.view.IViewLocator	IViewLocator
	 */
	public class ViewLocator extends WeemvcLocator implements IViewLocator {
		/** @private **/
		static private var m_instance:ViewLocator = null;
		/** @private **/
		protected var m_main:MovieClip;
		/** @private **/
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		/**
		 * 视图集合类构造函数。
		 * 
		 * @throws org.weemvc.as3.WeemvcError 单件的<code>ViewLocator</code>被实例化多次
		 */
		public function ViewLocator() {
			if (m_instance) {
				throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG, ViewLocator);
			}else {
				m_instance = this;
			}
		}
		
		/**
		 * 返回视图集合类的实例，若没有创建则创建，若已创建，则返回该实例。
		 * 
		 * @return	当前的视图集合类实例。
		 */
		static public function getInstance():IViewLocator {
			if (!m_instance) {
				m_instance = new ViewLocator();
			}
			return m_instance;
		}
		
		/**
		 * 初始化舞台，将舞台 MovieClip（root）实例传递给 WeeMVC。
		 * 
		 * @param	main	舞台（root）的引用
		 */
		public function initialize(main:MovieClip):void {
			m_main = main;
		}
		
		/**
		 * <p><b>注意：如果此视图类不存在，WeeMVC 会发出<code>WeemvcError.VIEW_NOT_FOUND</code>警告。</b></p>
		 * @copy	org.weemvc.as3.view.IViewLocator#getView()
		 */
		public function getView(viewName:Class):* {
			if (!hasExists(viewName)) {
				PaperLogger.getInstance().log(WeemvcError.VIEW_NOT_FOUND, ViewLocator, viewName);
			}
			return retrieve(viewName);
		}
		
		/**
		 * <p><b>注意：如果要添加视图类已经添加，WeeMVC 会发出<code>WeemvcError.ADD_VIEW_MSG</code>警告。</b></p>
		 * @copy	org.weemvc.as3.view.IViewLocator#addView()
		 */
		public function addView(viewName:Class, stageInstance:String = null):void {
			if (!hasExists(viewName)) {
				var container:MovieClip = getContainer(m_main, stageInstance);
				var viewInstance:IView = new viewName(container);
				var oberver:IObserver;
				if (viewInstance.notifications.length > 0) {
					for (var i:uint = 0; i < viewInstance.notifications.length; i++) {
						oberver = new Observer(viewInstance.onDataChanged, viewInstance);
						/**
						 * 如果当前的 notification 是字符串，则添加到通知列表
						 * 此操作意在过滤掉其他 view 对命令 notification 的侦听
						 */
						if (viewInstance.notifications[i] is String) {
							m_notifier.addObserver(viewInstance.notifications[i], oberver);
						}
					}
				}
				add(viewName, viewInstance);
			}else {
				PaperLogger.getInstance().log(WeemvcError.ADD_VIEW_MSG, ViewLocator, viewName);
			}
		}
		
		/**
		 * @copy	org.weemvc.as3.view.IViewLocator#hasView()
		 */
		public function hasView(viewName:Class):Boolean {
			return hasExists(viewName);
		}
		
		/**
		 * <p><b>注意：如果要添加视图类已经添加，WeeMVC 会发出<code>WeemvcError.VIEW_NOT_FOUND</code>警告。</b></p>
		 * @copy	org.weemvc.as3.view.IViewLocator#removeView()
		 */
		public function removeView(viewName:Class):void {
			if (hasExists(viewName)) {
				var viewInstance:IView = getView(viewName);
				if (viewInstance) {
					var notifications:Array = viewInstance.notifications;
					//移除该视图里面所有的通知
					for ( var i:Number = 0; i < notifications.length; i++ ) {
						m_notifier.removeObserver(notifications[i], viewInstance);
					}
				}
				remove(viewName);
			}else {
				PaperLogger.getInstance().log(WeemvcError.VIEW_NOT_FOUND, ViewLocator, viewName);
			}
		}
		
		/** @private **/
		//递归获得舞台上相应的 MC
		protected function getContainer(main:MovieClip, param:String):MovieClip {
			var container:MovieClip = main;
			if (!param) {
				return container;
			}
			var reg:RegExp = /[\w]+/ig;
			var temp:Array = param.match(reg);
			if(temp && temp.length > 0){
				for (var i:uint = 0; i < temp.length; i++) {
					if (!container[temp[i]]) {
						throw new WeemvcError(WeemvcError.MC_NOT_FOUND, ViewLocator, getFullPath(container) + " 容器内的 " +  temp[i]);
					}else {
						container = container[temp[i]];
					}
				}
			}
			return container;
		}
		
		/** @private **/
		protected function getFullPath(data:MovieClip):String {
			var path:String = data.name;
			while (data.stage && (data.parent != data.stage)) {
				data = data.parent as MovieClip;
				path = data.name + "." + path;
			}
			return path;
		}
	}
}