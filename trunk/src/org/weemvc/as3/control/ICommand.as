/**
 * WeeMVC - Copyright(c) 2008-2009
 * 命令接口
 * @author	weemve.org
 * 2008-12-14 16:40
 */
package org.weemvc.as3.control {
	import org.weemvc.as3.model.ModelLocator;
	import org.weemvc.as3.model.IModelLocator;
	import org.weemvc.as3.view.ViewLocator;
	import org.weemvc.as3.view.IViewLocator;
	
	public interface ICommand {
		
		function execute(data:Object = null):void;
		function get modelLocator():IModelLocator;
		function get viewLocator():IViewLocator;
		function get controller():IController;
	}
}