/**
 * WeeMVC - Copyright(c) 2008-2009
 * 观察者
 * @author	weemve.org
 * 2009-5-11 19:01
 */
package org.weemvc.as3.core {
	
	public class Observer implements IObserver {
		protected var m_callBack:Function;
		protected var m_context:Object;
		
		public function Observer(notifyMethod:Function, notifyContext:Object = null) {
			callBack = notifyMethod;
			context = notifyContext;
		}
		
		public function set callBack(method:Function):void {
			m_callBack = method;
		}
		
		public function get callBack():Function {
			return m_callBack;
		}
		
		public function set context(obj:Object):void {
			m_context = obj;
		}
		
		public function get context():Object {
			return m_context;
		}
		
		public function notifyObserver(notification:*, data:Object = null):void {
			callBack.call(context, notification, data);
		}
		
		public function compareContext(object:Object):Boolean {
			return (context === object);
		}
	}
}