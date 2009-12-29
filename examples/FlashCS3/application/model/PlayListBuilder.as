package application.model {
	
	import application.events.PlayListBuilderEvent;
	import application.model.vo.ImageVO;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class PlayListBuilder extends EventDispatcher {
		
		protected var m_loader:URLLoader;
		
		public function PlayListBuilder() {
			m_loader = new URLLoader();
			m_loader.addEventListener(Event.COMPLETE, onListLoadedHandler);
			m_loader.addEventListener(IOErrorEvent.IO_ERROR, onListErrorHandler);
			m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onListErrorHandler);
		}
		
		public function load(data:String):void {
			//判断是JSON还是URL
			if ((data.indexOf('"') != -1) &&
				(data.indexOf(':') != -1) &&
				((data.indexOf('[') != -1) || (data.indexOf('{') != -1)) &&
				((data.indexOf('}') != -1) || (data.indexOf('}') != -1))) {
				//JSON
				paseJSON(data);
			}else {
				try {
					//m_loader.load(new URLRequest(data + "?r=" + Math.random()));
					m_loader.load(new URLRequest(data));
				}catch (e:Error) {
					trace("加载播放列表失败::" + e.message);
				}
			}
		}
		
		private function onListLoadedHandler(e:Event):void {
			m_loader.removeEventListener(Event.COMPLETE, onListLoadedHandler);
			m_loader.removeEventListener(IOErrorEvent.IO_ERROR, onListErrorHandler);
			m_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onListErrorHandler);
			paseJSON(e.target.data);
		}
		
		protected function paseJSON(data:String):void {
			try {
				var result:Array = JSON.decode(data) as Array;
			}catch (e:Error) {
				trace("playList JSON 解析失败！::");
				return;
			}
			var playList:Array = new Array();
			//build playList
			for (var i:int = 0; i < result.length; i++) {		
				var vo:ImageVO = new ImageVO();
				vo.title 		= result[i].title;
				vo.subtitle		= result[i].subtitle;
				vo.description 	= result[i].description;
				vo.clickUrl 	= result[i].clickUrl;
				vo.location 	= result[i].location;
				//trace(vo.toString());
				playList.push(vo);
			}
			//dispatch
			this.dispatchEvent(new PlayListBuilderEvent(PlayListBuilderEvent.PLAYLIST_LOAD, playList));
		}
		
		protected function onListErrorHandler(e:Event):void{
			m_loader.removeEventListener(Event.COMPLETE, onListLoadedHandler);
			m_loader.removeEventListener(IOErrorEvent.IO_ERROR, onListErrorHandler);
			m_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onListErrorHandler);
			//
			trace("加载playList出错！::", e.clone());
			dispatchEvent(new PlayListBuilderEvent(PlayListBuilderEvent.LOAD_ERROR));
		}
	}
}