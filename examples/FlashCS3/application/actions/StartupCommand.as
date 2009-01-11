/**
 * 程序初始化命令
 * 注册所有的命令
 * ibio-develop
 * 2009-1-5 14:07
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.DataProxy;
	import application.view.*;
	
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		public override function execute(data:Object = null, viewName:Class = null):void {
			addViews();
			addModels();
			addCommands();
			//初始化view
			viewLocator.initialize(data as Main);
		}
		
		protected function addViews():void {
			viewLocator.addView(StageInitialize);
			viewLocator.addView(BigImagePlayer, "mc_bigImagePlayer");
			viewLocator.addView(ThumbList, "mc_thumbList");
		}
		
		protected function addModels():void {
			modelLocator.addModel(DataProxy);
		}
		
		protected function addCommands():void {
			controller.addCommand(LoadDataCommand);
			controller.addCommand(ShowImageCommand);
		}
	}
}