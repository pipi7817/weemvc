/**
 * 配置程序
 * ibio-develop
 * 2009-1-8 16:53
 */
package {
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
	
	public class Main extends MovieClip {
		
		public function Main() {
			//初始化舞台
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			//注册Command
			Controller.getInstance().addCommand(StartupCommand);
			//程序入口
			this.addEventListener(Event.ADDED_TO_STAGE, onStageLoaded_handler);
		}
		
		protected function onStageLoaded_handler(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onStageLoaded_handler);
			Controller.getInstance().executeCommand(StartupCommand, this);
			var params:Object = stage.loaderInfo.parameters;
			//显示列表
			if (params['playList'] != null) {
				Controller.getInstance().executeCommand(LoadDataCommand, {playList:params['playList']});
			}else {
				Controller.getInstance().executeCommand(LoadDataCommand, {playList:"stuff/playList.json"});
			}
		}
	}
}