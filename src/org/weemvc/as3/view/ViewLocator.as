/**
 * WeeMVC - Copyright(c) 2008-2009
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
 * @version	1.0.22 + 7
 * @author	weemve.org
 * 2009-1-5 14:06
 */
package org.weemvc.as3.view {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.WeemvcError;
	
	import flash.display.MovieClip;
	
	public class ViewLocator extends WeemvcLocator {
		static private var m_instance:ViewLocator = null;
		
		public function ViewLocator() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG, ViewLocator);
			}
		}
		
		static public function getInstance():ViewLocator{
			if(m_instance == null){
				m_instance = new ViewLocator();
			}
			return m_instance;
		}
		
		/**
		 * 这里是构造所有的view的地方
		 * 注意不要直接在本类（ViewLocator）里使用main以及main里的实例
		 * 应该使用每个view的句柄
		 * @param	main	文档类入口
		 */
		public function initialize(main:MovieClip):void {
			for each(var obj:Object in m_weeMap) {
				var viewName:Class = obj.view;
				var container:MovieClip = getContainer(main, obj.param);
				obj.instance = new viewName(container);
				obj.instance.viewName = viewName;
			}
		}
		
		/**
		 * 取回某个view
		 * @param	viewName<Class>:	注册的名字
		 * @return	view instance:		当前的view
		 */
		public function retrieveView(viewName:Class):* {
			if (!hasExists(viewName)) {
				throw new WeemvcError(WeemvcError.VIEW_NOT_FOUND, ViewLocator, viewName);
			}
			return m_weeMap[viewName].instance;
		}
		
		/**
		 * 添加view
		 * @param	viewName<Class>：		此view的Class
		 * @param	stageInstance<String>：	此view构造函数的参数，当前在舞台上对应的实例名
		 */
		public function addView(viewName:Class, stageInstance:String = null):void {
			if (hasExists(viewName)) {
				throw new WeemvcError(WeemvcError.ADD_VIEW_MSG, ViewLocator, viewName);
			}
			add(viewName, {view:viewName, instance:null, param:stageInstance});
		}
		
		public function removeView(viewName:Class):void {
			remove(viewName);
		}
		
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
				for(var i:uint = 0; i < temp.length; i++){
					container = container[temp[i]];
				}
			}
			return container;
		}
	}
}