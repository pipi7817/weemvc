/**
 * WeeMVC - Copyright(c) 2008-2009
 * 宏命令基类
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 21:38
 */
import org.weemvc.as2.model.ModelLocator;
import org.weemvc.as2.view.ViewLocator;
import org.weemvc.as2.control.ICommand;

class org.weemvc.as2.control.MacroCommand implements ICommand {
	private var m_subCommands:Array;
		
	public function MacroCommand() {
		m_subCommands = new Array();
		initialize();		
	}
	
	private function initialize():Void {
		//到子类将覆盖此函数
	}
	
	private function addSubCommand(commandName:Object):Void {
		m_subCommands.push(commandName);
	}
	
	public function execute(data:Object, viewName:Object):Void {
		while (m_subCommands.length > 0) {
			var commandClass:Object = m_subCommands.shift();
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data, viewName);
		}
	}
}