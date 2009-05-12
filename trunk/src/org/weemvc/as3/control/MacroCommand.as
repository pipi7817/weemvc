/**
 * WeeMVC - Copyright(c) 2008-2009
 * 宏命令基类
 * @author	weemve.org
 * 2009-1-11 1:28
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.model.ModelLocator;
	import org.weemvc.as3.model.IModelLocator;
	import org.weemvc.as3.view.ViewLocator;
	import org.weemvc.as3.view.IViewLocator;
	
	public class MacroCommand implements ICommand {
		protected var m_subCommands:Array;
		
		public function MacroCommand() {
			m_subCommands = new Array();
			initialize();		
		}
		
		public function get modelLocator():IModelLocator {
			return ModelLocator.getInstance();
		}
		
		public function get viewLocator():IViewLocator {
			return ViewLocator.getInstance();
		}
		
		public function get controller():IController {
			return Controller.getInstance();
		}
		
		protected function initialize():void {
			//到子类将覆盖此函数
		}
		
		protected function addSubCommand(commandName:Class):void {
			m_subCommands.push(commandName);
		}
		
		public final function execute(data:Object = null):void {
			while (m_subCommands.length > 0) {
				var commandClass:Class = m_subCommands.shift();
				var commandInstance:ICommand = new commandClass();
				commandInstance.execute(data);
			}
		}
	}
}