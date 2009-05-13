/**
 * WeeMVC - Copyright(c) 2008-2009
 * 视图的接口
 * 通过它,你可以找到你想要的视图
 * @author	weemve.org
 * 2009-5-11 17:50
 */
package org.weemvc.as3.view {
	import flash.display.MovieClip;
	
	public interface IViewLocator {
		
		function initialize(main:MovieClip):void;
		function getView(viewName:Class):IView;
		function addView(viewName:Class, stageInstance:String = null):void;
		function removeView(viewName:Class):void;
		function hasView(viewName:Class):Boolean;
	}
}