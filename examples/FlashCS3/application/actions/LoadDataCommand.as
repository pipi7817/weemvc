/**
 * 加载 playList
 * ibio-develop
 * 2009-5-12 10:51
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.DataProxy;
	
	public class LoadDataCommand extends SimpleCommand implements ICommand {
		public static const PLAY_LIST:String = "playList";
		
		public override function execute(data:Object = null):void {
			var model:DataProxy = modelLocator.getModel(DataProxy) as DataProxy;
			if ((data.playList != undefined) && (data.playList != "")) {
				model.loadPlayList(data.playList);
			}
		}
	}
}