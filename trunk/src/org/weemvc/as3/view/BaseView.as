/**
 * WeeMVC - Copyright(c) 2008-2009
 * 视图基类
 * @version	1.0.22 + 5
 * @author	weemve.org
 * 2008-12-14 16:42
 */
package org.weemvc.as3.view {
	import org.weemvc.as3.control.Controller;
	
	import flash.display.MovieClip;
	
	public class BaseView extends MovieClip {
		public var viewName:Class;
		
		public function sendNotification(commandClass:Class, data:Object = null):void {
			Controller.getInstance().executeCommand(commandClass, data, viewName);
		}
	}
}