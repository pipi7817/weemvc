/**
 * 单例模式的数据集合
 * @version	0.22
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
		 * @param	modelRef<Class>:		注册的名字
		 * @return	<model instance>		当前的model
		 */
		public function retrieveModel(modelRef:Class):* {
			if (!hasModel(modelRef)) {
				throw new WeemvcError(WeemvcError.MODEL_NOT_FOUND);
			}
			return m_modelMap[modelRef];
		}
		
		/**
		 * 添加model
		 * @param	modelRef<Class>：	此model的Class
		 * @param	data<Object>：		此model构造函数的参数
		 */
		public function addModel(modelRef:Class, data:Object = null):void {
			if (hasModel(modelRef)) {
				throw new WeemvcError(WeemvcError.ADD_MODEL_MSG);
			}
			if (data != null) {
				m_modelMap[modelRef] = new modelRef(data);
			}else {
				m_modelMap[modelRef] = new modelRef();
			}
		}
		
		public function hasModel(modelRef:Class):Boolean {
			return m_modelMap[modelRef] != undefined;
		}
		
		public function removeModel(modelRef:Class):void {
			if (hasModel(modelRef)){
				delete m_modelMap[modelRef];
			}
		}
	}
}