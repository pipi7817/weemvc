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
				//这里取消弱引用是为了让此监听在当前生面周期内一直有效，这样才能完整的监听加载进度
				//timer.addEventListener(TimerEvent.TIMER, onTimer_handler, false, 0, true);
				timer.addEventListener(TimerEvent.TIMER, onTimer_handler);
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