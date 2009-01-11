/**
 * WeeMVC - Copyright(c) 2008-2009
 * 错误处理
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 23:47
 */
class org.weemvc.as2.WeemvcError {
	public static var SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
	public static var SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
	public static var SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
	
	public static var ADD_COMMAND_MSG:String = "已经添加过此名称的 Command！";
	public static var ADD_MODEL_MSG:String = "已经添加过此名称的 Model！";
	public static var ADD_VIEW_MSG:String = "已经添加过此名称的 View！";
		
	public static var COMMAND_NOT_FOUND : String = "没有找到相关 Command！";
	public static var MODEL_NOT_FOUND : String = "没有找到相关 Model";
	public static var VIEW_NOT_FOUND : String = "没有找到相关 View！";
	
	public function WeemvcError(errorCode:String, className:String, rest:Array){
		super(formatMessage(errorCode, className, rest));
	}
		
	private function formatMessage(errorCode:String, className:String, rest:Array):String {
		var message:String;
		if (className != undefined) {
			message = "WeeMVC# " + errorCode + " at [" + className + "] " + rest.toString();
		}else {
			message = "WeeMVC# " + errorCode + rest.toString();
		}
		return message;
	}
}