/**
 * BaseLoader
 * ibio-develop
 * 2009-9-17 11:07
 */
package com.ibio8.components.container {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;
	
	public class BaseLoader extends MovieClip {
		protected var m_loader:Loader;
		
		/**
		 * 加载资源
		 * @param	data	需要加载的地址或者二进制数据（String/ByteArray）
		 */
		public function load(data:Object):void {
			m_loader = new Loader();
			this.addChild(m_loader);
			m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedHandler);
			m_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			m_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			//
			if (data is ByteArray) {
				try {
					m_loader.loadBytes(data as ByteArray);
				}catch (e:Error) {
					trace("BaseLoader::load(loadBytes)->" + e.message);
				}
			}else {
				try {
					m_loader.load(new URLRequest(data as String));
				}catch (e:Error) {
					trace("BaseLoader::load->" + e.message);
				}
			}
		}
		
		public function unload():void {
			if (m_loader) {
				removeListener();
				try {
					m_loader.close();
				}catch (e:Error) {
					trace("BaseLoader::unload.close->" + e.message);
				}
				try {
					m_loader.unload();
				}catch (e:Error) {
					trace("BaseLoader::unload.unload->" + e.message);
				}
				if (m_loader.stage) {
					this.removeChild(m_loader);
				}
			}
		}
		
		protected function onLoadedHandler(e:Event):void {
			removeListener();
			/**
			 * 如果加载的内容是位图，则把平滑设为true
			 * 注意：这里没有直接判断 loader.content is Bitmap，反而加 try 的用途在于
			 * flashplayer 9 的安全策略要求操作位图数据需要检测跨域文件
			 */
			try {
				e.currentTarget.loader.content.smoothing = true;
			}catch (e:Error) {
				trace("BaseLoader::onLoadedHandler.smoothing->", e.message);
			}
		}
		
		protected function onProgressHandler(e:ProgressEvent):void {
			//m_onProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		protected function onIOErrorHandler(e:IOErrorEvent):void {
			removeListener();
		}
		
		protected function removeListener():void {
			m_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadedHandler);
			m_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			m_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
	}
}