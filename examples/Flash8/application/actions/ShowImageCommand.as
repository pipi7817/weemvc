/**
 * 切换图片
 * ibio-develop
 * 2009-1-7 23:32
 */
import utils.Delegate;
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.model.DataProxy;
import application.view.*;

class application.actions.ShowImageCommand extends SimpleCommand implements ICommand {
	public static var NAME:String = "showImage";
	
		
	public function execute(data):Void {
		var index:Number = data;
		//在 model 中记录当前显示的 index
		modelLocator.getModel(DataProxy.NAME).currentIndex = index;
		viewLocator.getView(BigImagePlayer.NAME).changeImage(index);
	}
}