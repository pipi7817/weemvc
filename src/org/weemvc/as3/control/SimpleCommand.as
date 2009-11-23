/**
 * WeeMVC - Copyright(c) 2008-2009
 * 简单命令基类
 * @author	weemve.org
 * 2009-1-11 1:28
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.model.ModelLocator;
	import org.weemvc.as3.model.IModelLocator;
	import org.weemvc.as3.view.ViewLocator;
	import org.weemvc.as3.view.IViewLocator;
	import org.weemvc.as3.control.Controller;
	import org.weemvc.as3.control.IController;
	import org.weemvc.as3.core.Notifier;
	
	public class SimpleCommand implements ICommand {
		
		public function execute(data:Object = null):void{
			//到子类将覆盖此函数
		}
		
		public function get modelLocator():IModelLocator {
			return ModelLocator.getInstance();
		}
		
		public function get viewLocator():IViewLocator {
			return ViewLocator.getInstance();
		}
		
		public function get controller():IController {
			return Controller.getInstance();
		}
		
		public function sendNotification(notification:Object, data:Object = null):void {
			Notifier.getInstance().sendNotification(notification, data);
		}
	}
}