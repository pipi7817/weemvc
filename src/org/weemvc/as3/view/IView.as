/**
 * WeeMVC - Copyright(c) 2008-2009
 * 视图基类
 * @author	weemve.org
 * 2008-12-14 16:42
 */
package org.weemvc.as3.view {
	
	public interface IView {
		
		function sendNotification(notification:*, data:Object = null):void;
		function set notifications(list:Array):void;
		function get notifications():Array;
		function onDataChanged(notification:String, data:Object = null):void;
	}
}