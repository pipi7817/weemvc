/**
 * 配置程序
 * ibio-develop
 * 2009-5-12 10:48
 */
package {
	import org.weemvc.as3.control.Controller;
	import application.action.StartupCommand;
	import application.action.LoadDataCommand;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Main extends MovieClip {
		public static const LOADING_IMAGE:String = "loadingImage";
		
		public function Main() {
			//注册Command
			Controller.getInstance().addCommand(StartupCommand);
			//程序入口
			Controller.getInstance().executeCommand(StartupCommand, this);
			var params:Object = stage.loaderInfo.parameters;
			//显示列表
			Controller.getInstance().executeCommand(LoadDataCommand, params[LoadDataCommand.PLAY_LIST]);
		}
	}
}