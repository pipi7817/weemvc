/**
 * 大图
 * ibio-develop
 * 2009-5-12 11:47
 */
package application.view.components {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	public class ImageBox extends Sprite {
		public var index:uint;
		protected var m_loader:Loader;
		protected var m_width:uint;
		protected var m_height:uint;
		protected var m_doLater:Function;
		
		public function ImageBox(width:uint, height:uint) {
			m_width = width;
			m_height = height;
			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedHandler);
			m_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			m_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
		
		public function load(url:String):void {
			m_loader.load(new URLRequest(url));
		}
		
		public function loadDoLater(doLater:Function):void {
			m_doLater = doLater;
		}
		
		protected function onLoadedHandler(e:Event):void {
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadedHandler);
			m_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			m_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			//
			m_loader.width = m_width;
			m_loader.height = m_height;
			this.addChild(m_loader);
		}
		
		protected function onProgressHandler(e:ProgressEvent):void {
			var loaded:uint = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			if (m_doLater != null) {
				m_doLater(loaded);
			}
		}
		
		protected function onIOErrorHandler(e:IOErrorEvent):void {
			//trace("加载错误！");
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadedHandler);
			m_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			m_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
	}
}