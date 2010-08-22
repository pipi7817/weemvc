/**
 * WeeMVC - Copyright(c) 2008
 * 单例模式的数据集合
 * @author	weemve.org
 * 2009-1-11 21:40
 */
import org.weemvc.as2.core.WeemvcLocator;
import org.weemvc.as2.model.IModelLocator;
import org.weemvc.as2.WeemvcError;
import org.weemvc.as2.PaperLogger;

class org.weemvc.as2.model.ModelLocator extends WeemvcLocator implements IModelLocator {
	/** @private **/
	static private var m_instance:IModelLocator = null;
	
	public function ModelLocator() {
		if (m_instance) {
			throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG, "ModelLocator");
		}else {
			m_instance = this;
			m_weeMap = {};
		}
	}
	
	static public function getInstance():IModelLocator {
		if (!m_instance) {
			m_instance = new ModelLocator();
		}
		return m_instance;
	}
	
	/**
	 * <p><b>注意：如果此模型类不存在，WeeMVC 会发出<code>WeemvcError.MODEL_NOT_FOUND</code>警告。</b></p>
	 * @copy	org.weemvc.as2.model.IModelLocator#getModel()
	 */
	public function getModel(modelName:String) {
		if (!hasModel(modelName)) {
			PaperLogger.getInstance().log(WeemvcError.MODEL_NOT_FOUND, "ModelLocator", [modelName]);
		}
		return retrieve(modelName);
	}
	
	/**
	 * <p><b>注意：如果要添加模型类已经添加，WeeMVC 会发出<code>WeemvcError.ADD_MODEL_MSG</code>警告。</b></p>
	 * @copy	org.weemvc.as2.model.IModelLocator#addModel()
	 */
	public function addModel(modelName:String, modelClass:Object, data):Void {
		if (!hasExists(modelName)) {
			if (data) {
				add(modelName, new modelClass(data));
			}else {
				add(modelName, new modelClass());
			}
		}else {
			PaperLogger.getInstance().log(WeemvcError.ADD_MODEL_MSG, "ModelLocator", [modelName]);
		}
	}
	
	public function hasModel(modelName:String):Boolean {
		return hasExists(modelName);
	}
	
	/**
	 * <p><b>注意：如果此模型类不存在，WeeMVC 会发出<code>WeemvcError.MODEL_NOT_FOUND</code>警告。</b></p>
	 * @copy	org.weemvc.as2.model.IModelLocator#removeModel()
	 */
	public function removeModel(modelName:String):Void {
		if (hasExists(modelName)) {
			remove(modelName);
		}else {
			PaperLogger.getInstance().log(WeemvcError.MODEL_NOT_FOUND, "ModelLocator", [modelName]);
		}
	}
}