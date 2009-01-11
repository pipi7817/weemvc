/**
 * 加载playList
 * ibio-develop
 * 2009-1-8 16:55
 */
import utils.Delegate;
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.model.PlayListBuilder;
import application.model.DataProxy;
import application.view.*;
	
class application.actions.LoadDataCommand extends SimpleCommand implements ICommand {
	public static var NAME:String = "loadData";
	
	public function execute(data:Object, viewName:Object):Void {
		var plBuilder:PlayListBuilder = new PlayListBuilder();
		plBuilder.addEventListener(PlayListBuilder.LOAD_LIST, Delegate.create(this, onPlayListLoaded));
		//
		if ((data.playList != undefined) && (data.playList != "")) {
			plBuilder.load(data.playList);
		}
	}
	
	private function onPlayListLoaded(obj:Object):Void {
		var model:DataProxy = modelLocator.retrieveModel(DataProxy.NAME);
		model.playList = obj.playList;
		//将初始化字样清除
		viewLocator.retrieveView(StageInitialize.NAME).hideInitialize();
		viewLocator.retrieveView(BigImagePlayer.NAME).init(model.playList);
		viewLocator.retrieveView(ThumbList.NAME).init(model.playList);
	}
}