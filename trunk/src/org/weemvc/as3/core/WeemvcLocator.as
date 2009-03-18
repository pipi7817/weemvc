/**
 * WeeMVC - Copyright(c) 2008-2009
 * Weemvc核心
 * Controller、ModelLocator、ViewLocator都继承此类
 * @version	1.17
 * @author	weemve.org
 * 2008-12-14 16:39
 */
package org.weemvc.as3.core {
	import flash.utils.Dictionary;
	
	public class WeemvcLocator {
		protected var m_weeMap:Dictionary = new Dictionary();
		
		protected function add(className:Class, value:*):void {
			m_weeMap[className] = value;
		}
		
		protected function remove(className:Class):void {
			if (hasExists(className)){
				delete m_weeMap[className];
			}
		}
		
		protected function retrieve(className:Class):* {
			return m_weeMap[className];
		}
		
		protected function hasExists(className:Class):Boolean {
			return (m_weeMap[className] != undefined);
		}
	}
}