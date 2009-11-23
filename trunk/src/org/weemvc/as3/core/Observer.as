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
			m_callBack = notifyMethod;
			m_context = notifyContext;
		}
		
		/**
		 * 回调函数
		 */
		public function set callBack(method:Function):void {
			m_callBack = method;
		}
		
		public function get callBack():Function {
			return m_callBack;
		}
		
		/**
		 * 回调函数域
		 */
		public function set context(obj:Object):void {
			m_context = obj;
		}
		
		public function get context():Object {
			return m_context;
		}
		
		/**
		 * 执行此通知
		 * @param	notification<Class/String>：命令类或者每个 view 对应的相应的 notifications 列表
		 * @param	data<Object>：				传递的参数
		 */
		public function notifyObserver(notification:Object, data:Object = null):void {
			m_callBack.call(m_context, notification, data);
		}
		
		/**
		 * 比较函数域是否为当前传递进来的一致
		 * @param	object<Objcet>：一个函数域
		 * @return<Boolean>：		是否一致
		 */
		public function compareContext(object:Object):Boolean {
			return (m_context === object);
		}
	}
}