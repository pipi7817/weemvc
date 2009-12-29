/**
 * 数据集合
 * ibio-develop
 * 2009-5-12 11:40
 */
package application.model {
	import org.weemvc.as3.model.Model;
	import application.events.PlayListBuilderEvent;
	
	public class DataProxy extends Model {
		public var playList:Array;
		public var currentIndex:uint;
		protected var m_plBuilder:PlayListBuilder = new PlayListBuilder();
		
		public function DataProxy() {
			m_plBuilder.addEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoadedHandler);
		}
		
		public function loadPlayList(url:String):void {
			m_plBuilder.load(url);
		}
		
		protected function onPlayListLoadedHandler(e:PlayListBuilderEvent):void {
			//将加载完成的数据发送出去，所有的 view 都能得到此通知
			sendNotification(Main.PLAY_LIST_LOADED, e.playList);
		}
	}
}