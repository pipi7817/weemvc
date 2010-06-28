/**
 * WeeMVC - Copyright(c) 2008-2009
 * 错误处理
 * @author	weemve.org
 * 2009-1-9 14:31
 */
package org.weemvc.as3 {
	import org.weemvc.as3.Version;
	
	import flash.utils.getQualifiedClassName;
	
	public class WeemvcError extends Error {
		public static const SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
		public static const SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
		public static const SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
		public static const SINGLETON_NOTIFIER_MSG:String = "单件模式的 Notifier 已经创建！";
		public static const SINGLETON_PAPERLOGGER_MSG:String = "单件模式的 PaperLogger 已经创建！";
		
		public static const ADD_COMMAND_MSG:String = "已经添加过此 Command：";
		public static const ADD_MODEL_MSG:String = "已经添加过此 Model：";
		public static const ADD_VIEW_MSG:String = "已经添加过此 View：";
		
		public static const REMOVE_COMMAND_MSG:String = "已经删除过此 Command：";
		public static const REMOVE_MODEL_MSG:String = "已经删除过此 Model：";
		public static const REMOVE_VIEW_MSG:String = "已经删除过此 View：";
		
		public static const COMMAND_NOT_FOUND:String = "没有找到此 Command：";
		public static const MODEL_NOT_FOUND:String = "没有找到此 Model：";
		public static const VIEW_NOT_FOUND:String = "没有找到此 View：";
		public static const MC_NOT_FOUND:String = "没有找到此 MovieClip：";
		public static const NOTIFICATION_NOT_FOUND:String = "没有找到此 Notification：";
		
		public function WeemvcError(errorMsg:String, currentClass:Class = null, ... rest){
			super(formatMessage("WeeMVC Error# ", errorMsg, currentClass, rest));
		}
		
		public static function formatMessage(type:String, errorMsg:String, currentClass:Class, ... rest):String {
			var message:String = "WeeMVC 当前版本：" + Version.VERSION + "  最后更新：" + Version.LAST_UPDATE + "\n";
			if (currentClass) {
				var className:String = getQualifiedClassName(currentClass);
				message += type + "在 [" + className + "] 中，" + errorMsg + rest.toString();
			}else {
				message += type + errorMsg + rest.toString();
			}
			return message;
		}
	}
}