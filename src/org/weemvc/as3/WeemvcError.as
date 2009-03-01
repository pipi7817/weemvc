/**
 * WeeMVC - Copyright(c) 2008-2009
 * 错误处理
 * @version	1.0.23 + 5
 * @author	weemve.org
 * 2009-1-9 14:31
 */
package org.weemvc.as3 {
	import flash.utils.getQualifiedClassName;
	
	public class WeemvcError extends Error {
		public static const SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
		public static const SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
		public static const SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
		
		public static const ADD_COMMAND_MSG:String = "已经添加过此 Command：";
		public static const ADD_MODEL_MSG:String = "已经添加过此 Model：";
		public static const ADD_VIEW_MSG:String = "已经添加过此 View：";
		
		public static const COMMAND_NOT_FOUND : String = "没有找到此 Command：";
		public static const MODEL_NOT_FOUND : String = "没有找到此 Model：";
		public static const VIEW_NOT_FOUND : String = "没有找到此 View：";
		
		public function WeemvcError(errorMsg:String, currentClass:Class = null, ... rest){
			super(formatMessage(errorMsg, currentClass, rest));
		}
		
		protected function formatMessage(errorMsg:String, currentClass:Class, ... rest):String {
			var message:String;
			if (currentClass != null) {
				var className:String = getQualifiedClassName(currentClass);
				message = "WeeMVC# " + "在 [" + className + "] 中，" + errorMsg + rest.toString();
			}else {
				message = "WeeMVC# " + errorMsg + rest.toString();
			}
			return message;
		}
	}
}