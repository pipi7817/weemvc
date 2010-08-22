/**
 * 大图
 * ibio-develop
 * 2009-5-12 11:47
 */
package application.view.components {
	import com.ibio8.components.container.BaseLoader;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class ImageBox extends BaseLoader {
		protected var m_onProgress:Function;
		protected var m_width:uint;
		protected var m_height:uint;
		protected var m_index:uint;
		
		public function ImageBox(onProgress:Function, width:uint, height:uint) {
			m_onProgress = onProgress;
			m_width = width;
			m_height = height;
		}
		
		public function set index(value:uint):void {
			m_index = index;
		}
		
		public function get index():uint {
			return m_index;
		}
		
		override protected function onLoadedHandler(e:Event):void {
			super.onLoadedHandler(e);
			//
			m_loader.width = m_width;
			m_loader.height = m_height;
			this.addChild(m_loader);
		}
		
		override protected function onProgressHandler(e:ProgressEvent):void {
			var loaded:uint = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			if (m_onProgress != null) {
				m_onProgress(loaded);
			}
		}
	}
}