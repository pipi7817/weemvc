/**
 * 程序初始化命令
 * 注册所有的命令
 * ibio-develop
 * 2009-1-5 14:07
 */
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.actions.*;
import application.model.*;
import application.view.*;
	
class application.actions.StartupCommand extends SimpleCommand implements ICommand {
	public static var NAME:String = "startup";
		
	public function execute(data):Void {
		viewLocator.initialize(data);
		addViews();
		addModels();
		addCommands();
	}
	
	private function addViews():Void {
		viewLocator.addView(StageManager.NAME, StageManager);
		viewLocator.addView(BigImagePlayer.NAME, BigImagePlayer, "mc_bigImagePlayer");
		viewLocator.addView(ThumbList.NAME, ThumbList, "mc_thumbList");
	}
	
	private function addModels():Void {
		modelLocator.addModel(DataProxy.NAME, DataProxy);
	}
	
	private function addCommands():Void {
		controller.addCommand(LoadDataCommand.NAME, LoadDataCommand);
		controller.addCommand(ShowImageCommand.NAME, ShowImageCommand);
	}
}