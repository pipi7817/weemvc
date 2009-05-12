/**
 * WeeMVC - Copyright(c) 2008-2009
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
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
	
	import flash.display.MovieClip;
	
	public class ViewLocator extends WeemvcLocator implements IViewLocator {
		static private var m_instance:ViewLocator = null;
		protected var m_main:MovieClip;
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		public function ViewLocator() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG, ViewLocator);
			}
		}
		
		static public function getInstance():IViewLocator {
			if (m_instance == null) {
				m_instance = new ViewLocator();
			}
			return m_instance;
		}
		
		/**
		 * @param	main<MovieClip>：	文档类入口
		 */
		public function initialize(main:MovieClip):void {
			m_main = main;
		}
		
		/**
		 * 取回视图
		 * @param	viewName<Class>：	视图类
		 * @return<IView>：				当前的视图实例
		 */
		public function retrieveView(viewName:Class):IView {
			if (!hasExists(viewName)) {
				throw new WeemvcError(WeemvcError.VIEW_NOT_FOUND, ViewLocator, viewName);
			}
			return m_weeMap[viewName];
		}
		
		/**
		 * 添加视图
		 * @param	viewName<Class>：		视图类
		 * @param	stageInstance<String>：	当前的视图构造函数的参数（当前在舞台上对应的实例名）
		 */
		public function addView(viewName:Class, stageInstance:String = null):void {
			if (hasExists(viewName)) {
				throw new WeemvcError(WeemvcError.ADD_VIEW_MSG, ViewLocator, viewName);
			}
			var container:MovieClip = getContainer(m_main, stageInstance);
			var viewInstance:IView = new viewName(container);
			var oberver:IObserver;
			if (viewInstance.notifications.length > 0) {
				for (var i:uint = 0; i < viewInstance.notifications.length; i++) {
					oberver = new Observer(viewInstance.onDataChanged, viewInstance);
					m_notifier.addObserver(viewInstance.notifications[i], oberver);
				}
			}
			add(viewName, viewInstance);
		}
		
		/**
		 * 移除视图
		 * @param	viewName<Class>：	视图类
		 */
		public function removeView(viewName:Class):void {
			var viewInstance:IView = retrieveView(viewName);
			if (viewInstance) {
				var notifications:Array = viewInstance.notifications;
				//移除该视图里面所有的通知
				for ( var i:Number = 0; i < notifications.length; i++ ) {
					m_notifier.removeObserver(notifications[i], viewInstance);
				}
			}
			remove(viewName);
		}
		
		/**
		 * 判断此视图是否已经存在
		 * @param	viewName<Class>：	视图类
		 * @return<Boolean>：			是否存在
		 */
		public function hasView(viewName:Class):Boolean {
			return hasExists(viewName);
		}
		
		//递归获得舞台上相应的 MC
		protected function getContainer(main:MovieClip, param:String):MovieClip {
			var container:MovieClip = main;
			if (param == null) {
				return container;
			}
			var reg:RegExp = /[\w]+/ig;
			var temp:Array = param.match(reg);
			if(temp && temp.length > 0){
				for (var i:uint = 0; i < temp.length; i++) {
					if (container[temp[i]] == null) {
						throw new WeemvcError(WeemvcError.MC_NOT_FOUND, ViewLocator, getFullPath(container) + " 容器内的 " +  temp[i]);
					}else {
						container = container[temp[i]];
					}
				}
			}
			return container;
		}
		
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