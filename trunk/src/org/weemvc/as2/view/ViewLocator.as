/**
 * WeeMVC - Copyright(c) 2008-2009
 * 保存注册的视图类
 * 通过它,你可以找到你想要的视图
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 23:47
 */
import org.weemvc.as2.WeemvcError;

class org.weemvc.as2.view.ViewLocator {
	static private var m_instance:ViewLocator = null;
	private var m_viewMap:Array = new Array();
	
	public function ViewLocator() {
		if (m_instance != null) {
			throw new WeemvcError(WeemvcError.SINGLETON_VIEW_MSG, "ViewLocator");
		}
	}
	
	static public function getInstance():ViewLocator{
		if(m_instance == null){
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
	public function initialize(stage:MovieClip):Void {
		for (var key:String in m_viewMap) {
			var viewName:Object = m_viewMap[key].view;
			var container:MovieClip = (m_viewMap[key].param != undefined) ? stage[m_viewMap[key].param] : stage;
			m_viewMap[key].instance = new viewName(container);
			m_viewMap[key].instance.viewName = viewName;
		}
	}
	
	/**
	 * 取回某个view
	 * @param	viewName<String>:	注册的名字
	 * @return	view instance:		当前的view
	 */
	public function retrieveView(viewName:String) {
		if (!hasView(viewName)) {
			throw new WeemvcError(WeemvcError.VIEW_NOT_FOUND, "ViewLocator", [viewName]);
		}
		return m_viewMap[viewName].instance;
	}
	
	/**
	 * 添加view
	 * @param	viewName<String>：		此view的 NAME
	 * @param	viewClass<Object>：		此view的Class
	 * @param	stageInstance<String>：	此view构造函数的参数，当前在舞台上对应的实例名
	 */
	public function addView(viewName:String, viewClass:Object, stageInstance:String):Void {
		if (hasView(viewName)) {
			throw new WeemvcError(WeemvcError.ADD_VIEW_MSG, "ViewLocator", [viewName]);
		}
		m_viewMap[viewName] = {view:viewClass, instance:null, param:stageInstance};
	}
	
	public function hasView(viewName:String):Boolean {
		return m_viewMap[viewName] != undefined;
	}
	
	public function removeView(viewName:String):Void {
		if (hasView(viewName)){
			delete m_viewMap[viewName];
		}
	}
}