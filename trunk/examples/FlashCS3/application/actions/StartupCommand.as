/**
 * 程序初始化命令
 * 注册所有的命令、模型、视图
 * ibio-develop
 * 2009-5-12 11:35
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.DataProxy;
	import application.view.*;
	
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		public override function execute(data:Object = null):void {
			viewLocator.initialize(data as Main);
			addViews();
			addModels();
			addCommands();
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