﻿/**
 * WeeMVC - Copyright(c) 2008
 * 控制器接口
 * @author	weemve.org
 * 2009-5-11 17:45
 */

/**
 * 控制器类接口。
 * 
 * @see org.weemvc.as2.control.Controller	Controller
 */
interface org.weemvc.as2.control.IController {
	/**
	 * 添加命令类。
	 * 
	 * @param	commandName	要添加的命令类，都要实现<code>ICommand</code>接口
	 */
	function addCommand(commandName:String, commandClass:Object):Void;
	/**
	 * 移除命令类。
	 * 
	 * @param	commandName	要移除的命令类，都要实现<code>ICommand</code>接口
	 */
	function removeCommand(commandName:String):Void;
	/**
	 * 判断此命令类是否已经存在。
	 * 
	 * @param	commandName	要判断的命令类，都要实现<code>ICommand</code>接口
	 * @return 				是否存在
	 */
	function hasCommand(commandName:String):Boolean;
	/**
	 * 执行此命令类。
	 * 
	 * @param	commandName	要执行的命令类，都要实现<code>ICommand</code>接口
	 * @param	data		实例化此命令类时所带的参数
	 */
	public function executeCommand(commandName:String, data):Void;
}
