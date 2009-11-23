/**
 * WeeMVC - Copyright(c) 2008-2009
 * 观察者接口
 * @author	weemve.org
 * 2009-5-11 19:19
 */
package org.weemvc.as3.core {
	
	public interface IObserver {
		
		function set callBack(method:Function):void;
		function get callBack():Function;
		function set context(obj:Object):void;
		function get context():Object;
		function notifyObserver(notification:Object, data:Object = null):void;
		function compareContext(object:Object):Boolean;
	}
}