/**
 * WeeMVC - Copyright(c) 2008-2009
 * 单例模式的数据集合
 * @version	1.0.22 + 7
 * @author	weemve.org
 * 2009-1-8 22:59
 */
package org.weemvc.as3.model {
	import org.weemvc.as3.WeemvcError;
	
	import flash.utils.Dictionary;
	
	public class ModelLocator {
		static private var m_instance:ModelLocator = null;
		protected var m_modelMap:Dictionary = new Dictionary();
		
		public function ModelLocator() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG, ModelLocator);
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
		 * @param	modelName<Class>:		注册的名字
		 * @return	model instance:			当前的model
		 */
		public function retrieveModel(modelName:Class):* {
			if (!hasModel(modelName)) {
				throw new WeemvcError(WeemvcError.MODEL_NOT_FOUND, ModelLocator, modelName);
			}
			return m_modelMap[modelName];
		}
		
		/**
		 * 添加model
		 * @param	modelName<Class>：	此model的Class
		 * @param	data<Object>：		此model构造函数的参数
		 */
		public function addModel(modelName:Class, data:Object = null):void {
			if (hasModel(modelName)) {
				throw new WeemvcError(WeemvcError.ADD_MODEL_MSG, ModelLocator, modelName);
			}
			if (data != null) {
				m_modelMap[modelName] = new modelName(data);
			}else {
				m_modelMap[modelName] = new modelName();
			}
		}
		
		public function hasModel(modelName:Class):Boolean {
			return m_modelMap[modelName] != undefined;
		}
		
		public function removeModel(modelName:Class):void {
			if (hasModel(modelName)){
				delete m_modelMap[modelName];
			}
		}
	}
}