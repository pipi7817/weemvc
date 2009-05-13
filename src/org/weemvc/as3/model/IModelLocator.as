/**
 * WeeMVC - Copyright(c) 2008-2009
 * 数据集合模型接口
 * @author	weemve.org
 * 2009-5-11 17:48
 */
package org.weemvc.as3.model {
	
	public interface IModelLocator {
		
		function getModel(modelName:Class):IModel;
		function addModel(modelName:Class, data:Object = null):void;
		function removeModel(modelName:Class):void;
		function hasModel(modelName:Class):Boolean;
	}
}