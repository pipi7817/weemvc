/**
 * 文档类基类
 * ibio-develop
 * 2009-2-13 18:00
 */
package com.ibio8.utils {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class BaseDocument extends MovieClip {
		
		public function BaseDocument() {
			//初始化舞台
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	}
}