/**
 * WeeMVC - Copyright(c) 2008
 * 宏命令基类
 * @author	weemve.org
 * 2009-1-11 21:38
 */
import org.weemvc.as2.model.ModelLocator;
import org.weemvc.as2.view.ViewLocator;
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;

class org.weemvc.as2.control.MacroCommand extends SimpleCommand implements ICommand {
	private var m_subCommands:Array;
		
	public function MacroCommand() {
		m_subCommands = new Array();
		initialize();		
	}
	
	private function initialize():Void {
		//在子类覆盖此函数
	}
	
	private function addSubCommand(commandClass:Object):Void {
		m_subCommands.push(commandClass);
	}
	
	public function execute(data):Void {
		while (m_subCommands.length > 0) {
			var commandClass:Object = m_subCommands.shift();
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data, viewName);
		}
	}
}