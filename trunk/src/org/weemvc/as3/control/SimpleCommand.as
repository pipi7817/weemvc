/**
 * WeeMVC - Copyright(c) 2008-2009
 * 简单命令基类
 * @version	1.0.22 + 5
 * @author	weemve.org
 * 2009-1-11 1:28
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.model.ModelLocator;
	import org.weemvc.as3.view.ViewLocator;
	
	public class SimpleCommand implements ICommand {
		
		public function execute(data:Object = null, viewName:Class = null):void{
			//到子类将覆盖此函数
		}
		
		protected function get modelLocator():ModelLocator {
			return ModelLocator.getInstance();
		}
		
		protected function get viewLocator():ViewLocator {
			return ViewLocator.getInstance();
		}
		
		protected function get controller():Controller {
			return Controller.getInstance();
		}
	}
}