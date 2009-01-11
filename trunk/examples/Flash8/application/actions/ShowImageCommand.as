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
	private var m_timer:Number;
		
	public function execute(data:Object, viewName:Object):Void {
		//trace(new viewName);
		var index:Number = Number(data);
		modelLocator.retrieveModel(DataProxy.NAME).currentIndex = index;
		//
		viewLocator.retrieveView(BigImagePlayer.NAME).showImage(index);
		if (viewLocator.retrieveView(BigImagePlayer.NAME).currImgLoadPercent != 100) {
			m_timer = setInterval(Delegate.create(this, onTimer), 100);
		}
	}
	
	private function onTimer():Void {
		var percent:Number = viewLocator.retrieveView(BigImagePlayer.NAME).currImgLoadPercent;
		viewLocator.retrieveView(StageInitialize.NAME).showLoading(percent);
		if (percent == 100) {
			clearInterval(m_timer);
			viewLocator.retrieveView(StageInitialize.NAME).hideLoading();
		}
	}
}