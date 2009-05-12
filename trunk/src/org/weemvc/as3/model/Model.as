/**
 * WeeMVC - Copyright(c) 2008-2009
 * 模型基类
 * @author	weemve.org
 * 2009-5-11 20:45
 */
package org.weemvc.as3.model {
	import org.weemvc.as3.core.Notifier;
	import org.weemvc.as3.core.INotifier;
	
	public class Model implements IModel {
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		public function sendNotification(notification:*, data:Object = null):void {
			m_notifier.sendNotification(notification, data);
		}
	}
}