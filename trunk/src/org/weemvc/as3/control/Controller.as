/**
 * WeeMVC - Copyright(c) 2008-2009
 * 控制器--分发视图过来的操作
 * @author	weemve.org
 * 2008-12-14 16:39
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.core.Notifier;
	import org.weemvc.as3.core.INotifier;
	import org.weemvc.as3.core.Observer;
	import org.weemvc.as3.core.IObserver;
	import org.weemvc.as3.WeemvcError;
	
	public class Controller extends WeemvcLocator implements IController {
		static private var m_instance:Controller = null;
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		public function Controller() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_CONTROLLER_MSG, Controller);
			}
		}
		
		static public function getInstance():IController {
			if (m_instance == null) {
				m_instance = new Controller();
			}
			return m_instance;
		}
		
		public function addCommand(commandName:Class):void {
			if (hasExists(commandName)) {
				throw new WeemvcError(WeemvcError.ADD_COMMAND_MSG, Controller, commandName);
			}
			var oberver:IObserver = new Observer(executeCommand, this);
			m_notifier.addObserver(commandName, oberver);
			add(commandName, commandName);
		}
		
		public function removeCommand(commandName:Class):void {
			m_notifier.removeObserver(commandName, this);
			remove(commandName);
		}
		
		public function hasCommand(commandName:Class):Boolean {
			return hasExists(commandName);
		}
		
		public function executeCommand(commandName:Class, data:Object = null):void {
			if (!hasExists(commandName)) {
				throw new WeemvcError(WeemvcError.COMMAND_NOT_FOUND, Controller, commandName);
			}
			var commandClass:Class = retrieve(commandName);
			var commandInstance:ICommand = new commandClass();
			commandInstance.execute(data);
		}
	}
}