/**
 * WeeMVC - Copyright(c) 2008-2009
 * 控制器接口
 * @author	weemve.org
 * 2009-5-11 17:45
 */
package org.weemvc.as3.control {
	
	public interface IController {
		
		function addCommand(commandName:Class):void;
		function removeCommand(commandName:Class):void;
		function hasCommand(commandName:Class):Boolean;
		function executeCommand(commandName:Class, data:Object = null):void;
	}
}