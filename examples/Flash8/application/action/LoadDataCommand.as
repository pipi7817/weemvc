/**
 * 加载playList
 * ibio-develop
 * 2009-1-8 16:55
 */
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.model.DataProxy;
	
class application.action.LoadDataCommand extends SimpleCommand implements ICommand {
	
	public function execute(data):Void {
		var model:DataProxy = modelLocator.getModel(DataProxy);
		//开始加载数据
		if (data) {
			model.loadPlayList(data);
		}else {
			model.loadPlayList("stuff/playList.json");
		}
	}
	
	public function toString():String {
		return "LoadDataCommand";
	}
}