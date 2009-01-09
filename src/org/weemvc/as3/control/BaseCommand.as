/**
 * 命令基类
 * 把model和view声明在此
 * @version	0.22
 * @author	weemve.org
 * 2009-1-8 22:08
 */

package org.weemvc.as3.control {
	import org.weemvc.as3.model.ModelLocator;
	import org.weemvc.as3.view.ViewLocator;
	
	public class BaseCommand implements ICommand{
		
		public function execute(data:Object):void {
			//到子类将覆盖此函数
		}
		
		protected function get modelLocator():ModelLocator {
			return ModelLocator.getInstance();
		}
		
		protected function get viewLocator():ViewLocator {
			return ViewLocator.getInstance();
		}
		
		protected function addCommand(command:Class):void {
			Controller.getInstance().addCommand(command);
		}
	}
}