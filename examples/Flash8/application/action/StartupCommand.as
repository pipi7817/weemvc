/**
 * 程序初始化命令
 * 注册所有的命令
 * ibio-develop
 * 2009-1-5 14:07
 */
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.action.*;
import application.model.*;
import application.view.*;
	
class application.action.StartupCommand extends SimpleCommand implements ICommand {
		
	public function execute(data):Void {
		viewLocator.initialize(data);
		addViews();
		addModels();
		addCommands();
	}
	
	public function toString():String {
		return "StartupCommand";
	}
	
	private function addViews():Void {
		viewLocator.addView(StageManager);
		viewLocator.addView(BigImagePlayer, "mc_bigImagePlayer");
		viewLocator.addView(ThumbList, "mc_thumbList");
	}
	
	private function addModels():Void {
		modelLocator.addModel(DataProxy, null);
	}
	
	private function addCommands():Void {
		controller.addCommand(LoadDataCommand);
		controller.addCommand(ShowImageCommand);
	}
}