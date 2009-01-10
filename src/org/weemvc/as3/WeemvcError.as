/**
 * WeeMVC - Copyright(c) 2008-2009
 * 错误处理
 * @version	1.0.22 + 5
 * @author	weemve.org
 * 2009-1-9 14:31
 */
package org.weemvc.as3 {
	
	public class WeemvcError extends Error {
		public static const SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
		public static const SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
		public static const SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
		
		public static const ADD_COMMAND_MSG:String = "已经添加过此名称的 Command！";
		public static const ADD_MODEL_MSG:String = "已经添加过此名称的 Model！";
		public static const ADD_VIEW_MSG:String = "已经添加过此名称的 View！";
		
		public static const COMMAND_NOT_FOUND : String = "没有找到相关 Command！";
		public static const MODEL_NOT_FOUND : String = "没有找到相关 Model";
		public static const VIEW_NOT_FOUND : String = "没有找到相关 View！";
		
		public function WeemvcError(errorCode:String, className:String = null, ... rest){
			super(formatMessage(errorCode, className, rest));
		}
		
		protected function formatMessage(errorCode:String, className:String, ... rest):String {
			var message:String;
			if (className != null) {
				message = "WeeMVC# " + errorCode + " at [" + className + "] " + rest.toString();
			}else {
				message = "WeeMVC# " + errorCode + rest.toString();
			}
			return message;
		}
	}
}