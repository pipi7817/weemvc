/**
 * 控制器--分发视图过来的操作
 * @version	0.22
 * @author	weemve.org
 * 2008-12-14 16:39
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.IframeworkError;
	
	import flash.utils.Dictionary;
	
	public class Controller {
		static private var m_instance:Controller = null;
		protected var m_commandMap:Dictionary = new Dictionary();
		
		public function Controller() {
			if (m_instance != null) {
				throw new IframeworkError(IframeworkError.SINGLETON_CONTROLLER_MSG);
			}
		}
		
		static public function getInstance():Controller{
			if(m_instance == null){
				m_instance = new Controller();
			}
			return m_instance;
		}
		
		public function addCommand(commandRef:Class):void {
			if (hasCommand(commandRef)) {
				throw new IframeworkError(IframeworkError.ADD_COMMAND_MSG);
			}
			m_commandMap[commandRef] = commandRef;
		}
		
		public function hasCommand(commandRef:Class):Boolean {
			return m_commandMap[commandRef] != undefined;
		}
		
		public function removeCommand(commandRef:Class):void {
			if (hasCommand(commandRef)){
				// remove the command
				delete m_commandMap[commandRef];
			}
		}
		
		public function executeCommand(commandRef:Class, data:Object = null):void{
			if (!hasCommand(commandRef)) {
				throw new IframeworkError(IframeworkError.COMMAND_NOT_FOUND);
			}
			var commandClass:Class = m_commandMap[commandRef];
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data);
		}
	}
}