/**
 * WeeMVC - Copyright(c) 2008-2009
 * 视图基类
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 23:47
 */
import org.weemvc.as2.control.Controller;

class org.weemvc.as2.view.BaseView extends MovieClip {
	public var viewName:Object;
		
	public function sendNotification(commandName:String, data:Object):Void {
		Controller.getInstance().executeCommand(commandName, data, viewName);
	}
}