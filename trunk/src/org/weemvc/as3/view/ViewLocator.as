/**
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
 * @version	0.22
 * @author	weemve.org
 * 2009-1-5 14:06
 */

package org.weemvc.as3.view {
	import org.weemvc.as3.WeemvcError;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class ViewLocator {
		static private var m_instance:ViewLocator = null;
		protected var m_viewMap:Dictionary = new Dictionary();
		
		public function ViewLocator() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG);
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
		public function initialize(main:Sprite):void {
			for each(var obj:Object in m_viewMap) {
				var viewRef:Class = obj.view;
				var container:Sprite = (obj.param != null) ? main[obj.param] : main;
				obj.instance = new viewRef(container);
			}
		}
		
		/**
		 * 取回某个view
		 * @param	viewRef<Class>:		注册的名字
		 * @return	<view instance>		当前的view
		 */
		public function retrieveView(viewRef:Class):* {
			if (!hasView(viewRef)) {
				throw new WeemvcError(WeemvcError.VIEW_NOT_FOUND);
			}
			return m_viewMap[viewRef].instance;
		}
		
		/**
		 * 添加view
		 * @param	viewRef<Class>：	此view的Class
		 * @param	inlet<String>：		此view构造函数的参数，当前在舞台上对应的实例名
		 */
		public function addView(viewRef:Class, inlet:String = null):void {
			if (hasView(viewRef)) {
				throw new WeemvcError(WeemvcError.ADD_VIEW_MSG);
			}
			m_viewMap[viewRef] = {view:viewRef, instance:null, param:inlet};
		}
		
		public function hasView(viewRef:Class):Boolean {
			return m_viewMap[viewRef] != undefined;
		}
		
		public function removeView(viewRef:Class):void {
			if (hasView(viewRef)){
				delete m_viewMap[viewRef];
			}
		}
	}
}