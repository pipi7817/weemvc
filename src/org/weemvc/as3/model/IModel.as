/**
 * WeeMVC - Copyright(c) 2008-2009
 * 模型接口
 * @author	weemve.org
 * 2009-5-11 20:46
 */
package org.weemvc.as3.model {
	
	public interface IModel {
		
		function sendNotification(notification:Object, data:Object = null):void;
	}
}