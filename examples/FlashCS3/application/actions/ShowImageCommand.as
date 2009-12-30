/**
 * 切换图片
 * ibio-develop
 * 2009-1-7 23:32
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.DataProxy;
	import application.view.BigImagePlayer;
	
	public class ShowImageCommand extends SimpleCommand implements ICommand {
		
		public override function execute(data:Object = null):void {
			var index:uint = data as uint;
			var model:DataProxy = modelLocator.getModel(DataProxy);
			model.currentIndex = index;
			var bigImage:BigImagePlayer = viewLocator.getView(BigImagePlayer);
			//显示某张图片
			bigImage.showImage(index);
		}
	}
}