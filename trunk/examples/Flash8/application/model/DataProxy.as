/**
 * 数据集合
 * ibio-develop
 * 2008-12-14 16:41
 */
import org.weemvc.as2.model.Model;
import application.model.PlayListBuilder;
import utils.Delegate;

class application.model.DataProxy extends Model {
	public static var NAME:String = "dataProxy";
	public static var ON_DATA_LOADED:String = "onDataLoaded";
	public var playList:Array;
	public var currentIndex:Number;
	
	public function loadPlayList(playListData:String):Void {
		var plBuilder:PlayListBuilder = new PlayListBuilder();
		plBuilder.addEventListener(PlayListBuilder.LOAD_LIST, Delegate.create(this, onPlayListLoaded));
		plBuilder.load(playListData);
	}
	
	private function onPlayListLoaded(obj:Object):Void {
		playList = obj.playList;
		sendNotification(ON_DATA_LOADED, playList);
	}
}