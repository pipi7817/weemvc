/**
 * 视图基类
 * @version	0.22
 * @author	weemve.org
 * 2008-12-14 16:42
 */
package org.weemvc.as3.view {
	
	import org.weemvc.as3.control.Controller;
	
	import flash.display.Sprite;
	
	public class BaseView extends Sprite{
		
		public function sendNotification(commandClass:Class, data:Object = null):void {
			Controller.getInstance().executeCommand(commandClass, data);
		}
	}
}