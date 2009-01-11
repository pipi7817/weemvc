/**
 * 切换图片
 * ibio-develop
 * 2009-1-7 23:32
 */
package application.actions {
	import org.weemvc.as3.control.ICommand;
	import org.weemvc.as3.control.SimpleCommand;
	import application.model.DataProxy;
	import application.view.*;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ShowImageCommand extends SimpleCommand implements ICommand {
		
		public override function execute(data:Object = null, viewName:Class = null):void {
			//trace(viewName);
			var index:uint = data as uint;
			modelLocator.retrieveModel(DataProxy).currentIndex = index;
			//
			viewLocator.retrieveView(BigImagePlayer).showImage(index);
			if (viewLocator.retrieveView(BigImagePlayer).currImgLoadPercent != 100) {
				var timer:Timer = new Timer(100);
				//因为这这命令类本身会多次被调用，所以这里用了用引用有利于垃圾回收
				timer.addEventListener(TimerEvent.TIMER, onTimer_handler, false, 0, true);
				timer.start();
			}
		}
		
		protected function onTimer_handler(e:TimerEvent):void {
			var percent:uint = viewLocator.retrieveView(BigImagePlayer).currImgLoadPercent;
			viewLocator.retrieveView(StageInitialize).showLoading(percent);
			if (percent == 100) {
				e.currentTarget.removeEventListener(TimerEvent.TIMER, onTimer_handler);
				viewLocator.retrieveView(StageInitialize).hideLoading();
			}
		}
	}
}