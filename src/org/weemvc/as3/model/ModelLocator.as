/**
 * WeeMVC - Copyright(c) 2008
 * 单例模式的模型集合
 * @author	weemve.org
 * 2009-1-8 22:59
 */
package org.weemvc.as3.model {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.WeemvcError;
	import org.weemvc.as3.PaperLogger;
	/**
	 * 模型集合类。
	 * 
	 * <p>
	 * WeeMVC 的所有模型的集合类。
	 * </p>
	 * 
	 * @see org.weemvc.as3.model.IModelLocator	IModelLocator
	 * @see org.weemvc.as3.model.IModel			IModel
	 */
	public class ModelLocator extends WeemvcLocator implements IModelLocator {
		/** @private **/
		static private var m_instance:IModelLocator = null;
		
		/**
		 * 模型集合类构造函数。
		 * 
		 * @throws org.weemvc.as3.WeemvcError 单件的<code>ModelLocator</code>被实例化多次
		 */
		public function ModelLocator() {
			if (m_instance) {
				throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG, ModelLocator);
			}else {
				m_instance = this;
			}
		}
		
		/**
		 * 返回模型集合类的实例，若没有创建则创建，若已创建，则返回该实例。
		 * 
		 * @return	当前的模型集合类实例。
		 */
		static public function getInstance():IModelLocator {
			if (!m_instance) {
				m_instance = new ModelLocator();
			}
			return m_instance;
		}
		
		/**
		 * <p><b>注意：如果此模型类不存在，WeeMVC 会发出<code>WeemvcError.MODEL_NOT_FOUND</code>警告。</b></p>
		 * @copy	org.weemvc.as3.model.IModelLocator#getModel()
		 */
		public function getModel(modelName:Class):* {
			if (!hasExists(modelName)) {
				PaperLogger.getInstance().log(WeemvcError.MODEL_NOT_FOUND, ModelLocator, modelName);
			}
			return retrieve(modelName);
		}
		
		/**
		 * <p><b>注意：如果要添加模型类已经添加，WeeMVC 会发出<code>WeemvcError.ADD_MODEL_MSG</code>警告。</b></p>
		 * @copy	org.weemvc.as3.model.IModelLocator#addModel()
		 */
		public function addModel(modelName:Class, data:Object = null):void {
			if (!hasExists(modelName)) {
				if (data) {
					add(modelName, new modelName(data));
				}else {
					add(modelName, new modelName());
				}
			}else {
				PaperLogger.getInstance().log(WeemvcError.ADD_MODEL_MSG, ModelLocator, modelName);
			}
		}
		
		/**
		 * <p><b>注意：如果此模型类不存在，WeeMVC 会发出<code>WeemvcError.MODEL_NOT_FOUND</code>警告。</b></p>
		 * @copy	org.weemvc.as3.model.IModelLocator#removeModel()
		 */
		public function removeModel(modelName:Class):void {
			if (hasExists(modelName)) {
				remove(modelName);
			}else {
				PaperLogger.getInstance().log(WeemvcError.MODEL_NOT_FOUND, ModelLocator, modelName);
			}
		}
		
		/**
		 * @copy	org.weemvc.as3.model.IModelLocator#hasModel()
		 */
		public function hasModel(modelName:Class):Boolean {
			return hasExists(modelName);
		}
	}
}