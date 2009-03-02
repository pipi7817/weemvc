/**
 * WeeMVC - Copyright(c) 2008-2009
 * 错误处理
 * @version	1.0.23 + 8
 * @author	weemve.org
 * 2009-1-11 23:47
 */
class org.weemvc.as2.WeemvcError extends Error {
	public static var SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
	public static var SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
	public static var SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
	
	public static var ADD_COMMAND_MSG:String = "已经添加过此 Command：";
	public static var ADD_MODEL_MSG:String = "已经添加过此 Model：";
	public static var ADD_VIEW_MSG:String = "已经添加过此 View：";
		
	public static var COMMAND_NOT_FOUND : String = "没有找到此 Command：";
	public static var MODEL_NOT_FOUND : String = "没有找到此 Model：";
	public static var VIEW_NOT_FOUND : String = "没有找到此 View：";
	
	public function WeemvcError(errorMsg:String, className:String, rest:Array){
		super(formatMessage(errorMsg, className, rest));
	}
		
	private function formatMessage(errorMsg:String, className:String, rest:Array):String {
		var message:String;
		if (rest == undefined) {
			rest = new Array();
		}
		if (className != undefined) {
			message = "WeeMVC Error# " + "在 [" + className + "] 中，" + errorMsg + rest.toString();
		}else {
			message = "WeeMVC Error# " + errorMsg + rest.toString();
		}
		return message;
	}
}