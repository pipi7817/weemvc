/**
 * 命令规范
 * @version	0.22
 * @author	weemve.org
 * 2008-12-14 16:40
 */

package org.weemvc.as3.control {
	
	public interface ICommand {
		
		function execute(data:Object):void;
	}
}