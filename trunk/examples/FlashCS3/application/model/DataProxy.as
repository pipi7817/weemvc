/**
 * 数据集合
 * ibio-develop
 * 2009-5-12 11:40
 */
package application.model {
	import org.weemvc.as3.model.Model;
	import application.model.PlayListBuilder;
	import application.events.PlayListBuilderEvent;
	
	public class DataProxy extends Model {
		public static const PLAYLIST:String = "DataProxy.playlist";
		public static const CURRENT_INDEX:String = "DataProxy.currentIndex";
		protected var m_playList:Array;
		public var m_currentIndex:int;
		
		public function loadPlayList(playListData:String):void {
			var plBuilder:PlayListBuilder = new PlayListBuilder();
			plBuilder.addEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoadedHandler);
			plBuilder.load(playListData);
		}
		
		public function set playlist(value:Array):void {
			if (m_playList != value) {
				sendWee(PLAYLIST, value);
			}
			m_playList = value;
		}
		
		public function set currentIndex(value:int):void {
			if (m_currentIndex != value) {
				sendWee(CURRENT_INDEX, value);
			}
			m_currentIndex = value;
		}
		
		protected function onPlayListLoadedHandler(e:PlayListBuilderEvent):void {
			e.currentTarget.removeEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoadedHandler);
			//将加载完成的数据发送出去，所有的 view 都能得到此通知
			playlist = e.playList;
		}
	}
}