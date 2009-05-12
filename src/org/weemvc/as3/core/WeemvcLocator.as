/**
 * WeeMVC - Copyright(c) 2008-2009
 * Weemvc核心
 * Controller、ModelLocator、ViewLocator、Notifier 都继承此类
 * @author	weemve.org
 * 2008-12-14 16:39
 */
package org.weemvc.as3.core {
	import flash.utils.Dictionary;
	
	public class WeemvcLocator {
		protected var m_weeMap:Dictionary = new Dictionary();
		
		protected function add(key:*, value:*):void {
			m_weeMap[key] = value;
		}
		
		protected function remove(key:*):void {
			if (hasExists(key)){
				delete m_weeMap[key];
			}
		}
		
		protected function retrieve(key:*):* {
			return m_weeMap[key];
		}
		
		protected function hasExists(key:*):Boolean {
			return (m_weeMap[key] != undefined);
		}
	}
}