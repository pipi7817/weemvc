/**
 * WeeMVC - Copyright(c) 2008-2009
 * 命令规范
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 21:37
 */
interface org.weemvc.as2.control.ICommand {
	
	function execute(data:Object, viewName:Object):Void;
}