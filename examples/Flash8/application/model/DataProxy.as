/**
 * 数据集合
 * ibio-develop
 * 2008-12-14 16:41
 */
import org.weemvc.as2.model.Model;
import application.model.PlayListBuilder;
import utils.Delegate;

class application.model.DataProxy extends Model {
	public static var PLAYLIST:String = "DataProxy.playlist";
	public static var CURRENT_INDEX:String = "DataProxy.currentIndex";
	private var m_playlist:Array;
	private var m_currentIndex:Number;
	
	public function loadPlayList(playListData:String):Void {
		var plBuilder:PlayListBuilder = new PlayListBuilder();
		plBuilder.addEventListener(PlayListBuilder.LOAD_LIST, Delegate.create(this, onPlayListLoaded));
		plBuilder.load(playListData);
	}
	
	public function toString():String {
		return "DataProxy";
	}
	
	public function set playlist(value:Array):Void {
		if (m_playlist != value) {
			sendWee(PLAYLIST, value);
		}
		m_playlist = value;
	}
	
	public function set currentIndex(value:Number):Void {
		if (m_currentIndex != value) {
			sendWee(CURRENT_INDEX, value);
		}
		m_currentIndex = value;
	}
	
	private function onPlayListLoaded(obj:Object):Void {
		playlist = obj.playList;
	}
}