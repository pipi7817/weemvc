/**
 * WeeMVC - Copyright(c) 2008
 * 控制器--分发视图过来的操作
 * @author	weemve.org
 * 2009-1-11 21:36
 */
import org.weemvc.as2.WeemvcError;
import org.weemvc.as2.PaperLogger;
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.IController;
import org.weemvc.as2.core.WeemvcLocator;
import org.weemvc.as2.core.Notifier;
import org.weemvc.as2.core.INotifier;
import org.weemvc.as2.core.Observer;
import org.weemvc.as2.core.IObserver;

class org.weemvc.as2.control.Controller extends WeemvcLocator implements IController {
	/** @private **/
	static private var m_instance:IController = null;
	/** @private **/
	private var m_notifier:INotifier;
		
	public function Controller() {
		if (m_instance) {
			throw new WeemvcError(WeemvcError.SINGLETON_CONTROLLER_MSG, "Controller", null);
		}else {
			m_instance = this;
			m_weeMap = {};
			m_notifier = Notifier.getInstance();
		}
	}
	
	static public function getInstance():IController{
		if (!m_instance) {
			m_instance = new Controller();
		}
		return m_instance;
	}
	
	public function addCommand(commandName:String, commandClass:Object):Void {
		if (!hasExists(commandName)) {
			var oberver:IObserver = new Observer(executeCommand, this);
			m_notifier.addObserver(commandName, oberver);
			add(commandName, commandClass);
		}else {
			PaperLogger.getInstance().log(WeemvcError.ADD_COMMAND_MSG, "Controller", [commandName]);
		}
	}
	
	public function hasCommand(commandName:String):Boolean {
		return hasExists(commandName);
	}
	
	public function removeCommand(commandName:String):Void {
		if (hasExists(commandName)) {
			m_notifier.removeObserver(commandName, this);
			remove(commandName);
		}else {
			PaperLogger.getInstance().log(WeemvcError.COMMAND_NOT_FOUND, "Controller", [commandName]);
		}
	}
	
	public function executeCommand(commandName:String, data):Void {
		if (hasExists(commandName)) {
			var commandClass:Object = retrieve(commandName);
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data);
		}else {
			PaperLogger.getInstance().log(WeemvcError.COMMAND_NOT_FOUND, "Controller", [commandName]);
		}
	}
}