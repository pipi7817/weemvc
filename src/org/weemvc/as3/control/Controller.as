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
	import org.weemvc.as3.PaperLogger;
	
	public class Controller extends WeemvcLocator implements IController {
		static private var m_instance:Controller = null;
		protected var m_notifier:INotifier = Notifier.getInstance();
		
		public function Controller() {
			if (m_instance) {
				throw new WeemvcError(WeemvcError.SINGLETON_CONTROLLER_MSG, Controller);
			}else {
				m_instance = this;
			}
		}
		
		static public function getInstance():IController {
			if (!m_instance) {
				m_instance = new Controller();
			}
			return m_instance;
		}
		
		/**
		 * 添加命令
		 * @param	commandName<Class>：命令类
		 */
		public function addCommand(commandName:Class):void {
			if (!hasExists(commandName)) {
				var oberver:IObserver = new Observer(executeCommand, this);
				m_notifier.addObserver(commandName, oberver);
				add(commandName, commandName);
			}else {
				PaperLogger.getInstance().log(WeemvcError.ADD_COMMAND_MSG, Controller, commandName);
			}
		}
		
		/**
		 * 移除命令
		 * @param	commandName<Class>：命令类
		 */
		public function removeCommand(commandName:Class):void {
			if (hasExists(commandName)) {
				m_notifier.removeObserver(commandName, this);
				remove(commandName);
			}else {
				PaperLogger.getInstance().log(WeemvcError.REMOVE_COMMAND_MSG, Controller, commandName);
			}
		}
		
		/**
		 * 判断此命令是否已经存在
		 * @param	commandName<Class>：命令类
		 * @return<Boolean>：			是否存在
		 */
		public function hasCommand(commandName:Class):Boolean {
			return hasExists(commandName);
		}
		
		/**
		 * 执行此命令
		 * @param	commandName<Class>：命令类
		 * @param	data<Objcet>：		实例化此命令类时所带的参数
		 */
		public function executeCommand(commandName:Class, data:Object = null):void {
			if (hasExists(commandName)) {
				var commandClass:Class = retrieve(commandName);
				var commandInstance:ICommand = new commandClass();
				commandInstance.execute(data);
			}else {
				PaperLogger.getInstance().log(WeemvcError.COMMAND_NOT_FOUND, Controller, commandName);
			}
		}
	}
}