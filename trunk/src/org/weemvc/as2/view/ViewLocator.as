/**
 * WeeMVC - Copyright(c) 2008
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
 * @author	weemve.org
 * 2009-1-11 23:47
 */
import org.weemvc.as2.core.WeemvcLocator;
import org.weemvc.as2.core.Notifier;
import org.weemvc.as2.core.INotifier;
import org.weemvc.as2.core.Observer;
import org.weemvc.as2.core.IObserver;
import org.weemvc.as2.view.IViewLocator;
import org.weemvc.as2.view.IView;
import org.weemvc.as2.WeemvcError;
import org.weemvc.as2.PaperLogger;

class org.weemvc.as2.view.ViewLocator extends WeemvcLocator implements IViewLocator {
	/** @private **/
	static private var m_instance:IViewLocator = null;
	/** @private **/
	private var m_main:MovieClip;
	/** @private **/
	private var m_notifier:INotifier;
	
	public function ViewLocator() {
		if (m_instance) {
			throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG, "ViewLocator");
		}else {
			m_instance = this;
			m_weeMap = {};
			m_notifier = Notifier.getInstance();
		}
	}
	
	static public function getInstance():IViewLocator{
		if(!m_instance){
			m_instance = new ViewLocator();
		}
		return m_instance;
	}
	
	/**
	 * 这里是构造所有的view的地方
	 * 注意不要直接在本类（ViewLocator）里使用main以及main里的实例
	 * 应该使用每个view的句柄
	 * @param	stage	文档类入口
	 */
	public function initialize(main:MovieClip):Void {
		m_main = main;
	}
	
	/**
	 * <p><b>注意：如果此视图类不存在，WeeMVC 会发出<code>WeemvcError.VIEW_NOT_FOUND</code>警告。</b></p>
	 * @copy	org.weemvc.as2.view.IViewLocator#getView()
	 */
	public function getView(viewName:String) {
		if (!hasExists(viewName)) {
			PaperLogger.getInstance().log(WeemvcError.VIEW_NOT_FOUND, "ViewLocator", [viewName]);
		}
		return retrieve(viewName);
	}
	
	/**
	 * <p><b>注意：如果要添加视图类已经添加，WeeMVC 会发出<code>WeemvcError.ADD_VIEW_MSG</code>警告。</b></p>
	 * @copy	org.weemvc.as2.view.IViewLocator#addView()
	 */
	public function addView(viewName:String, viewClass:Object, stageInstance:String):Void {
		if (!hasExists(viewName)) {
			var container:MovieClip = getContainer(m_main, stageInstance);
			var viewInstance:IView = new viewClass(container);
			var oberver:IObserver;
			if (viewInstance.getNotifications().length > 0) {
				for (var i:Number = 0; i < viewInstance.getNotifications().length; i++) {
					oberver = new Observer(viewInstance.onDataChanged, viewInstance);
					/**
					 * 如果当前的 notification 是字符串，则添加到通知列表
					 * 此操作意在过滤掉其他 view 对命令 notification 的侦听
					 */
					if (typeof(viewInstance.getNotifications()[i]) == "string") {
						m_notifier.addObserver(viewInstance.getNotifications()[i], oberver);
					}
				}
			}
			add(viewName, viewInstance);
		}else {
			PaperLogger.getInstance().log(WeemvcError.ADD_VIEW_MSG, "ViewLocator", [viewName]);
		}
	}
	
	public function hasView(viewName:String):Boolean {
		return hasExists(viewName);
	}
	
	public function removeView(viewName:String):Void {
		if (hasExists(viewName)) {
			var viewInstance:IView = getView(viewName);
			if (viewInstance) {
				var notifications:Array = viewInstance.getNotifications();
				//移除该视图里面所有的通知
				for ( var i:Number = 0; i < notifications.length; i++ ) {
					m_notifier.removeObserver(notifications[i], viewInstance);
				}
			}
			remove(viewName);
		}else {
			PaperLogger.getInstance().log(WeemvcError.VIEW_NOT_FOUND, "ViewLocator", [viewName]);
		}
	}
	
	/** @private **/
	//递归获得舞台上相应的 MC
	private function getContainer(main:MovieClip, param:String):MovieClip {
		var container:MovieClip = main;
		if (!param) {
			return container;
		}
		var temp:Array = param.split(".");
		if(temp && temp.length > 0){
			for (var i:Number = 0; i < temp.length; i++) {
				if (!container[temp[i]]) {
					throw new WeemvcError(WeemvcError.MC_NOT_FOUND, "ViewLocator", [getFullPath(container) + " 容器内的 " +  temp[i]]);
				}else {
					container = container[temp[i]];
				}
			}
		}
		return container;
	}
	
	/** @private **/
	private function getFullPath(data:MovieClip):String {
		var path:String = data._name;
		while (m_main && (data._parent != m_main)) {
			data = MovieClip(data._parent);
			path = data._name + "." + path;
		}
		return path;
	}
}