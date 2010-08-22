/**
 * WeeMVC - Copyright(c) 2008
 * 错误处理
 * @version	1.0.23 + 8
 * @author	weemve.org
 * 2009-1-11 23:47
 */
import org.weemvc.as2.Version;
 
class org.weemvc.as2.WeemvcError extends Error {
	public static var SINGLETON_CONTROLLER_MSG:String = "单件模式的 Controller 已经创建！";
	public static var SINGLETON_MODEL_MSG:String = "单件模式的 ModelLocator 已经创建！";
	public static var SINGLETON_VIEW_MSG:String = "单件模式的 ViewLocator 已经创建！";
	/** WeeMVC 错误 **/
	public static var SINGLETON_NOTIFIER_MSG:String = "单件模式的 Notifier 已经创建！";
	/** WeeMVC 错误 **/
	public static var SINGLETON_PAPERLOGGER_MSG:String = "单件模式的 PaperLogger 已经创建！";
	
	public static var ADD_COMMAND_MSG:String = "已经添加过此 Command：";
	public static var ADD_MODEL_MSG:String = "已经添加过此 Model：";
	public static var ADD_VIEW_MSG:String = "已经添加过此 View：";
		
	public static var COMMAND_NOT_FOUND : String = "没有找到此 Command：";
	public static var MODEL_NOT_FOUND : String = "没有找到此 Model：";
	public static var VIEW_NOT_FOUND : String = "没有找到此 View：";
	
	/** WeeMVC 警告 **/
	public static var MC_NOT_FOUND:String = "没有找到此 MovieClip：";
	/** WeeMVC 警告 **/
	public static var NOTIFICATION_NOT_FOUND:String = "没有找到此 Notification：";
	
	/**
	 * 错误信息类构造函数。
	 * 
	 * @param	errorMsg		错误信息
	 * @param	currentClass	发生此错误所在的类
	 * @param	... rest		其他的任何信息
	 */
	public function WeemvcError(errorMsg:String, className:String, rest:Array){
		super(formatMessage("WeeMVC Error# ", errorMsg, className, rest));
	}
	
	/**
	 * 格式化信息。
	 * 
	 * @param	type			信息类型。错误（Error）/警告（Warning）
	 * @param	info			信息
	 * @param	currentClass	所在的类
	 * @param	... rest		其他的任何信息
	 * @return					格式化之后的字符串
	 */
	public static function formatMessage(type:String, info:String, className:String, rest:Array):String {
		var message:String = "WeeMVC 当前版本：" + Version.VERSION + "  最后更新：" + Version.LAST_UPDATE + "\n";
		if (className) {
			message += type + "在 [" + className + "] 中，" + info + rest.toString();
		}else {
			message += type + info + rest.toString();
		}
		return message;
	}
}