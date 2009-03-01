/**
 * WeeMVC - Copyright(c) 2008-2009
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
 * @version	1.0.22 + 7
 * @author	weemve.org
 * 2009-1-5 14:06
 */
package org.weemvc.as3.view {
	import org.weemvc.as3.WeemvcError;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	public class ViewLocator {
		static private var m_instance:ViewLocator = null;
		protected var m_viewMap:Dictionary = new Dictionary();
		
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
			for each(var obj:Object in m_viewMap) {
				var viewName:Class = obj.view;
				var container:MovieClip = (obj.param != null) ? main[obj.param] : main;
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
			if (!hasView(viewName)) {
				throw new WeemvcError(WeemvcError.VIEW_NOT_FOUND, ViewLocator, viewName);
			}
			return m_viewMap[viewName].instance;
		}
		
		/**
		 * 添加view
		 * @param	viewName<Class>：		此view的Class
		 * @param	stageInstance<String>：	此view构造函数的参数，当前在舞台上对应的实例名
		 */
		public function addView(viewName:Class, stageInstance:String = null):void {
			if (hasView(viewName)) {
				throw new WeemvcError(WeemvcError.ADD_VIEW_MSG, ViewLocator, viewName);
			}
			m_viewMap[viewName] = {view:viewName, instance:null, param:stageInstance};
		}
		
		public function hasView(viewName:Class):Boolean {
			return m_viewMap[viewName] != undefined;
		}
		
		public function removeView(viewName:Class):void {
			if (hasView(viewName)){
				delete m_viewMap[viewName];
			}
		}
	}
}