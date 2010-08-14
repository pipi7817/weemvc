/**
 * WeeMVC - Copyright(c) 2008
 * 视图基类
 * @author	weemve.org
 * 2008-12-14 16:42
 */
package org.weemvc.as3.view {
	/**
	 * 视图类接口。
	 * 
	 * <p>
	 * WeeMVC 的视图。
	 * </p>
	 * 
	 * @see org.weemvc.as3.model.View	View
	 */
	public interface IView {
		/**
		 * @copy	org.weemvc.as3.core.INotifier#sendNotification()
		 */
		function sendNotification(notification:Object, data:Object = null):void;
		/**
		 * 设置当前视图需要监听的 notification 列表。
		 * 
		 * <p>当系统发出此列表中包含的事件（名称）时，当前视图中的 onDataChanged
		 * 能够立即监听到此事件，且形参 notification 就是当前事件的名称。
		 * </p>
		 * <p><b>注意：这里个列表中的每个元素为 String 类型，即和 onDataChanged
		 * 中形参 notification 的数据类型一致</b></p>
		 * 
		 * @param	list	当前视图需要监听的notification（String）列表
		 */
		function set notifications(list:Array):void;
		/**
		 * 返回当前监听的 notification 列表。
		 */
		function get notifications():Array;
		/**
		 * 当发送的 WeeMVC 事件包含在<code>notifications</code>里时，这个函数将被执行。
		 * 
		 * @param	notification	当前发生的事件的名称，一定是<code>notifications</code>里的某个元素
		 * @param	data			此事件一起传递的参数
		 */
		function onDataChanged(notification:String, data:Object = null):void;
	}
}