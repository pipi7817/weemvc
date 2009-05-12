/**
 * WeeMVC - Copyright(c) 2008-2009
 * 单例模式的数据集合
 * @author	weemve.org
 * 2009-1-8 22:59
 */
package org.weemvc.as3.model {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.WeemvcError;
	
	public class ModelLocator extends WeemvcLocator implements IModelLocator {
		static private var m_instance:IModelLocator = null;
		
		public function ModelLocator() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG, ModelLocator);
			}
		}
		
		static public function getInstance():IModelLocator {
			if (m_instance == null) {
				m_instance = new ModelLocator();
			}
			return m_instance;
		}
		
		/**
		 * 取回某个model
		 * @param	modelName<Class>：	注册的名字
		 * @return<IModel>：			当前的 model 实例
		 */
		public function retrieveModel(modelName:Class):IModel {
			if (!hasExists(modelName)) {
				throw new WeemvcError(WeemvcError.MODEL_NOT_FOUND, ModelLocator, modelName);
			}
			return retrieve(modelName);
		}
		
		/**
		 * 添加model
		 * @param	modelName<Class>：	此model的Class
		 * @param	data<Object>：		此model构造函数的参数
		 */
		public function addModel(modelName:Class, data:Object = null):void {
			if (hasExists(modelName)) {
				throw new WeemvcError(WeemvcError.ADD_MODEL_MSG, ModelLocator, modelName);
			}
			if (data != null) {
				add(modelName, new modelName(data));
			}else {
				add(modelName, new modelName());
			}
		}
		
		public function removeModel(modelName:Class):void {
			remove(modelName);
		}
		
		public function hasModel(modelName:Class):Boolean {
			return hasExists(modelName);
		}
	}
}