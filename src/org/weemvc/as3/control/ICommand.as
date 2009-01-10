/**
 * WeeMVC - Copyright(c) 2008-2009
 * 命令规范
 * @version	1.0.22 + 5
 * @author	weemve.org
 * 2008-12-14 16:40
 */
package org.weemvc.as3.control {
	
	public interface ICommand {
		
		function execute(data:Object = null, viewName:Class = null):void;
	}
}