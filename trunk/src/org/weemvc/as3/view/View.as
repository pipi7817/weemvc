/**
 * WeeMVC - Copyright(c) 2008-2009
 * 视图基类
 * @author	weemve.org
 * 2008-12-14 16:42
 */
package org.weemvc.as3.view {
	import org.weemvc.as3.core.Notifier;
	import org.weemvc.as3.core.INotifier;
	
	import flash.display.MovieClip;
	
	public class View extends MovieClip implements IView {
		//此视图需要监听的消息列表
		protected var m_notifications:Array = new Array();
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		public function sendNotification(notification:*, data:Object = null):void {
			m_notifier.sendNotification(notification, data);
		}
		
		public function set notifications(list:Array):void {
			m_notifications = list;
		}
		
		public function get notifications():Array {
			return m_notifications;
		}
		
		//model 更新之后返回的数据，会 call 此函数
		public function onDataChanged(notification:String, data:Object = null):void {
			//在子类覆盖此类
		}
	}
}