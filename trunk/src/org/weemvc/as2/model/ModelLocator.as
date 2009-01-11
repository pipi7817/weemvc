/**
 * WeeMVC - Copyright(c) 2008-2009
 * 单例模式的数据集合
 * @version	1.0.22 + 8
 * @author	weemve.org
 * 2009-1-11 21:40
 */
import org.weemvc.as2.WeemvcError;

class org.weemvc.as2.model.ModelLocator {
	static private var m_instance:ModelLocator = null;
	private var m_modelMap:Array = new Array();
	
	public function ModelLocator() {
		if (m_instance != null) {
			throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG);
		}
	}
	
	static public function getInstance():ModelLocator{
		if(m_instance == null){
			m_instance = new ModelLocator();
		}
		return m_instance;
	}
	
	/**
	 * 取回某个model
	 * @param	modelName<String>:		注册的名字
	 * @return	model instance:			当前的model
	 */
	public function retrieveModel(modelName:String) {
		if (!hasModel(modelName)) {
			throw new WeemvcError(WeemvcError.MODEL_NOT_FOUND);
		}
		return m_modelMap[modelName];
	}
	
	/**
	 * 添加model
	 * @param	modelName<String>：	此model的 NAME
	 * @param	modelClass<Object>：此model的Class
	 * @param	data<Object>：		此model构造函数的参数
	 */
	public function addModel(modelName:String, modelClass:Object, data:Object):Void {
		if (hasModel(modelName)) {
			throw new WeemvcError(WeemvcError.ADD_MODEL_MSG);
		}
		if (data != undefined) {
			m_modelMap[modelName] = new modelClass(data);
		}else {
			m_modelMap[modelName] = new modelClass();
		}
	}
	
	public function hasModel(modelName:String):Boolean {
		return m_modelMap[modelName] != undefined;
	}
	
	public function removeModel(modelName:String):Void {
		if (hasModel(modelName)){
			delete m_modelMap[modelName];
		}
	}
}