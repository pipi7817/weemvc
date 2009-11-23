/**
 * WeeMVC - Copyright(c) 2008-2009
 * 发送事件接口
 * @author	weemve.org
 * 2009-5-11 18:30
 */
package org.weemvc.as3.core {
	
	public interface INotifier {
		
		function addObserver(notification:Object, observer:IObserver):void;
		function removeObserver(notification:Object, notifyContext:Object):void;
		function sendNotification(notification:Object, data:Object = null):void;
	}
}