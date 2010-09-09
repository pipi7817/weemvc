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
		public var playList:Array;
		public var currentIndex:uint;
		
		public function loadPlayList(playListData:String):void {
			var plBuilder:PlayListBuilder = new PlayListBuilder();
			plBuilder.addEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoadedHandler);
			plBuilder.load(playListData);
		}
		
		protected function onPlayListLoadedHandler(e:PlayListBuilderEvent):void {
			e.currentTarget.removeEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoadedHandler);
			//将加载完成的数据发送出去，所有的 view 都能得到此通知
			sendWee(Main.PLAY_LIST_LOADED, e.playList);
		}
	}
}