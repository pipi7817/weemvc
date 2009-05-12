/**
 * WeeMVC - Copyright(c) 2008-2009
 * 发送通知
 * @author	weemve.org
 * 2009-5-11 18:32
 */
package org.weemvc.as3.core {
	import org.weemvc.as3.WeemvcError;
	
	public class Notifier extends WeemvcLocator implements INotifier {
		static private var m_instance:Notifier = null;
		
		public function Notifier() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_NOTIFIER_MSG, Notifier);
			}
		}
		
		static public function getInstance():INotifier {
			if (m_instance == null) {
				m_instance = new Notifier();
			}
			return m_instance;
		}
		
		/**
		 * 添加观察者对象
		 * @param	notification<Class/String>：通知
		 * @param	observer<IObserver>：		观察者
		 */
		public function addObserver(notification:*, observer:IObserver):void {
			var observers:Array = retrieve(notification);
			//
			if (observers) {
				observers.push(observer);
			} else {
				observers = [observer];
			}
			add(notification, observers);
		}
		
		/**
		 * 移除观察者对象
		 * @param	notification<Class/String>：通知
		 * @param	notifyContext<Object>：		此观察者函数域
		 */
		public function removeObserver(notification:*, notifyContext:Object):void {
			var observers:Array = retrieve(notification) as Array;
			var observer:IObserver;
			for (var i:int = 0; i < observers.length; i++) {
				observer = observers[i] as IObserver;
				//如果函数作用域和传递进来的一致，则删除
				if (observer.compareContext(notifyContext)) {
					observers.splice(i, 1);
					break;
				}
			}
			if (observers.length == 0) {
				remove(notification);
			}
		}
		
		/**
		 * 发送 weemvc 事件通知
		 * @param	notification<Class/String>：命令类或者每个 view 对应的相应的
		 * 										notifications 列表里的某一通知
		 * @param	data<Object>：				传递的参数
		 */
		public function sendNotification(notification:*, data:Object = null):void {
			if (hasExists(notification)) {
				//取回当前通知的 list
				var observers:Array = retrieve(notification) as Array;
				var observer:IObserver;
				for (var i:uint = 0; i < observers.length; i++) {
					observer = observers[i] as IObserver;
					observer.notifyObserver(notification, data);
				}
			}
		}
	}
}