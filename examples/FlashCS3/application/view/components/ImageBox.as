package application.view.components {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	public class ImageBox extends Sprite {
		protected var m_loader:Loader;
		protected var m_width:uint;
		protected var m_height:uint;
		protected var m_loaded:uint;
		
		public function ImageBox(width:uint, height:uint) {
			m_width = width;
			m_height = height;
			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded_handler);
			m_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress_handler);
			m_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError_handler);
		}
		
		public function load(url:String):void {
			m_loader.load(new URLRequest(url));
		}
		
		public function get loadPercent():uint {
			return m_loaded;
		}
		
		protected function onLoaded_handler(e:Event):void {
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded_handler);
			m_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress_handler);
			m_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError_handler);
			//
			m_loader.width = m_width;
			m_loader.height = m_height;
			this.addChild(m_loader);
		}
		
		protected function onProgress_handler(e:ProgressEvent):void {
			m_loaded = Math.round(e.bytesLoaded / e.bytesTotal * 100);
		}
		
		protected function onIOError_handler(e:IOErrorEvent):void {
			//trace("加载错误！");
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded_handler);
			m_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress_handler);
			m_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError_handler);
		}
	}
}