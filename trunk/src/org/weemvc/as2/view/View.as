/**
 * WeeMVC - Copyright(c) 2008
 * 视图基类
 * @author	weemve.org
 * 2009-1-11 23:47
 */
import org.weemvc.as2.core.Notifier;
import org.weemvc.as2.view.IView;

class org.weemvc.as2.view.View implements IView {
	/** @private **/
	//此视图需要监听的消息列表
	private var m_notifications:Array = [];
	
	public function sendNotification(notification:String, data):Void {
		Notifier.getInstance().sendNotification(notification, data);
	}
	
	public function setNotifications(list:Array):Void {
		m_notifications = list;
	}
	
	/**
	 * 返回当前监听的 notification 列表。
	 */
	public function getNotifications():Array {
		return m_notifications;
	}
	
	/**
	 * @copy	org.weemvc.as2.view.IView#onDataChanged()
	 */
	public function onDataChanged(notification:String, data):Void {
		//在子类覆盖此函数
	}
}