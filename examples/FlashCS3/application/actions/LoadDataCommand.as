/**
 * 加载playList
 * ibio-develop
 * 2009-1-8 16:55
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.PlayListBuilder;
	import application.events.PlayListBuilderEvent;
	import application.model.DataProxy;
	import application.view.*;
	
	public class LoadDataCommand extends SimpleCommand implements ICommand {
		
		public override function execute(data:Object = null, viewName:Class = null):void {
			var plBuilder:PlayListBuilder = new PlayListBuilder();
			plBuilder.addEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoaded_handler);
			//
			if ((data.playList != undefined) && (data.playList != "")) {
				plBuilder.load(data.playList);
			}
		}
		
		protected function onPlayListLoaded_handler(e:PlayListBuilderEvent):void {
			e.currentTarget.removeEventListener(PlayListBuilderEvent.PLAYLIST_LOAD, onPlayListLoaded_handler);
			var model:DataProxy = modelLocator.retrieveModel(DataProxy);
			model.playList = e.playList;
			//将初始化字样清除
			viewLocator.retrieveView(StageInitialize).hideInitialize();
			viewLocator.retrieveView(BigImagePlayer).init(model.playList);
			viewLocator.retrieveView(ThumbList).init(model.playList);
		}
	}
}