/**
 * WeeMVC - Copyright(c) 2008-2009
 * 控制器--分发视图过来的操作
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 21:36
 */
import org.weemvc.as2.WeemvcError;
import org.weemvc.as2.control.ICommand;
	
class org.weemvc.as2.control.Controller {
	static private var m_instance:Controller = null;
	private var m_commandMap:Array = new Array();
		
	public function Controller() {
		if (m_instance != null) {
			throw new WeemvcError(WeemvcError.SINGLETON_CONTROLLER_MSG, "Controller");
		}
	}
	
	static public function getInstance():Controller{
		if(m_instance == null){
			m_instance = new Controller();
		}
		return m_instance;
	}
	
	public function addCommand(commandName:String, commandClass:Object):Void {
		if (hasCommand(commandName)) {
			throw new WeemvcError(WeemvcError.ADD_COMMAND_MSG, "Controller", [commandName]);
		}
		m_commandMap[commandName] = commandClass;
	}
	
	public function hasCommand(commandName:String):Boolean {
		return m_commandMap[commandName] != undefined;
	}
	
	public function removeCommand(commandName:String):Void {
		if (hasCommand(commandName)){
			delete m_commandMap[commandName];
		}
	}
	
	public function executeCommand(commandName:String, data:Object, viewName:Object):Void{
		if (!hasCommand(commandName)) {
			throw new WeemvcError(WeemvcError.COMMAND_NOT_FOUND, "Controller", [commandName]);
		}
		var commandClass:Object = m_commandMap[commandName];
		var commandInstance:ICommand = new commandClass();
		commandInstance.execute(data, viewName);
	}
}