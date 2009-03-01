/**
 * WeeMVC - Copyright(c) 2008-2009
 * 控制器--分发视图过来的操作
 * @version	1.0.22 + 5
 * @author	weemve.org
 * 2008-12-14 16:39
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.WeemvcError;
	
	import flash.utils.Dictionary;
	
	public class Controller {
		static private var m_instance:Controller = null;
		protected var m_commandMap:Dictionary = new Dictionary();
		
		public function Controller() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_CONTROLLER_MSG, Controller);
			}
		}
		
		static public function getInstance():Controller{
			if(m_instance == null){
				m_instance = new Controller();
			}
			return m_instance;
		}
		
		public function addCommand(commandName:Class):void {
			if (hasCommand(commandName)) {
				throw new WeemvcError(WeemvcError.ADD_COMMAND_MSG, Controller, commandName);
			}
			m_commandMap[commandName] = commandName;
		}
		
		public function hasCommand(commandName:Class):Boolean {
			return m_commandMap[commandName] != undefined;
		}
		
		public function removeCommand(commandName:Class):void {
			if (hasCommand(commandName)){
				delete m_commandMap[commandName];
			}
		}
		
		public function executeCommand(commandName:Class, data:Object = null, viewName:Class = null):void{
			if (!hasCommand(commandName)) {
				throw new WeemvcError(WeemvcError.COMMAND_NOT_FOUND, Controller, commandName);
			}
			var commandClass:Class = m_commandMap[commandName];
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data, viewName);
		}
	}
}