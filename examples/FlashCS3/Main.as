/**
 * 配置程序
 * ibio-develop
 * 2009-5-12 10:48
 */
package {
	import com.ibio8.utils.BaseDocument;
	import org.weemvc.as3.control.Controller;
	import application.actions.StartupCommand;
	import application.actions.LoadDataCommand;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;	
	
	public class Main extends BaseDocument {
		public static const PLAY_LIST_LOADED:String = "playListLoaded";
		public static const LOADING_IMAGE:String = "loadingImage";
		
		public function Main() {
			//注册Command
			Controller.getInstance().addCommand(StartupCommand);
			//程序入口
			Controller.getInstance().executeCommand(StartupCommand, this);
			var params:Object = stage.loaderInfo.parameters;
			//显示列表
			if (params[LoadDataCommand.PLAY_LIST] != null) {
				Controller.getInstance().executeCommand(LoadDataCommand, {playList:params[LoadDataCommand.PLAY_LIST]});
			}else {
				Controller.getInstance().executeCommand(LoadDataCommand, {playList:"stuff/playList.json"});
			}
		}
	}
}