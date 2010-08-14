/**
 * WeeMVC - Copyright(c) 2008
 * 发送通知
 * @author	weemve.org
 * 2009-5-11 18:32
 */
package org.weemvc.as3.core {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.WeemvcError;
	import org.weemvc.as3.PaperLogger;
	/**
	 * WeeMVC 事件类。
	 * 
	 * <p>
	 * WeeMVC 的事件通知都是采用观察者模式实现的。
	 * </p>
	 * 
	 * @see org.weemvc.as3.core.INotifier	INotifier
	 */
	public class Notifier extends WeemvcLocator implements INotifier {
		/** @private **/
		static private var m_instance:Notifier = null;
		
		/**
		 * 通知类构造函数。
		 * 
		 * @throws org.weemvc.as3.WeemvcError 单件的<code>Notifier</code>被实例化多次
		 */
		public function Notifier() {
			if (m_instance) {
				throw new WeemvcError(WeemvcError.SINGLETON_NOTIFIER_MSG, Notifier);
			}else {
				m_instance = this;
			}
		}
		
		/**
		 * 返回通知类的实例，若没有创建则创建，若已创建，则返回该实例。
		 * 
		 * @return	当前的通知类实例。
		 */
		static public function getInstance():INotifier {
			if (!m_instance) {
				m_instance = new Notifier();
			}
			return m_instance;
		}
		
		/**
		 * @copy	org.weemvc.as3.core.INotifier#addObserver()
		 */
		public function addObserver(notification:Object, observer:IObserver):void {
			var observers:Array = retrieve(notification);
			//若已经存在，则追加；否则新建
			if (observers) {
				observers.push(observer);
			} else {
				observers = [observer];
			}
			add(notification, observers);
		}
		
		/**
		 * @copy	org.weemvc.as3.core.INotifier#removeObserver()
		 */
		public function removeObserver(notification:Object, notifyContext:Object):void {
			var observers:Array = retrieve(notification);
			var observer:IObserver;
			for (var i:int = 0; i < observers.length; i++) {
				observer = observers[i] as IObserver;
				//如果函数作用域和传递进来的一致，则删除
				//一个 observer 只可能对应一个作用域，所以要 break
				if (observer.compareContext(notifyContext)) {
					observers.splice(i, 1);
					break;
				}
			}
			if (observers.length <= 0) {
				remove(notification);
			}
		}
		
		/**
		 * <p><b>注意：如果此命令类不存在，WeeMVC 会发出<code>WeemvcError.NOTIFICATION_NOT_FOUND</code>警告。</b></p>
		 * @copy	org.weemvc.as3.core.INotifier#sendNotification()
		 */
		public function sendNotification(notification:Object, data:Object = null):void {
			if (hasExists(notification)) {
				//取回当前通知的 list
				var observers:Array = retrieve(notification);
				var observer:IObserver;
				//
				for (var i:uint = 0; i < observers.length; i++) {
					observer = observers[i] as IObserver;
					observer.notifyObserver(notification, data);
				}
			}else {
				PaperLogger.getInstance().log(WeemvcError.NOTIFICATION_NOT_FOUND, Notifier, notification);
			}
		}
	}
}