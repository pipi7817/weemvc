/**
 * WeeMVC - Copyright(c) 2008-2009
 * 简单命令基类
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 21:38
 */
import org.weemvc.as2.view.ViewLocator;
import org.weemvc.as2.model.ModelLocator;
import org.weemvc.as2.control.Controller;
import org.weemvc.as2.control.ICommand;
	
class org.weemvc.as2.control.SimpleCommand implements ICommand {
	
	public function execute(data:Object, viewName:Object):Void {
		//到子类将覆盖此函数
	}
	
	public function get modelLocator():ModelLocator {
		return ModelLocator.getInstance();
	}
	
	public function get viewLocator():ViewLocator {
		return ViewLocator.getInstance();
	}
	
	public function get controller():Controller {
		return Controller.getInstance();
	}
}