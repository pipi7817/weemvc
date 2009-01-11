/**
 * 单选按钮
 * ibio-develop
 * 2008-11-20 14:20
 */

package com.ibio8.components.button {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class MCCheckButton extends MovieClip{
		//是否选中
		protected var m_isSelected:Boolean = false;
		//是否禁用
		protected var m_isEnabled:Boolean = true;
		
		public function MCCheckButton(){
			this.stop();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, onRollOver_handler);
			this.addEventListener(MouseEvent.MOUSE_OUT, onRollOut_handler);
		}
		
		//是否为选中状态
		public function set isSelected(value:Boolean):void {
			m_isSelected = value;
			mcRollOut();
		}
		
		public function get isSelected():Boolean {
			return m_isSelected;
		}
		
		//是否禁用此按钮
		public function set isEnabled(value:Boolean):void{
			m_isEnabled = value;
			//激活
			if (m_isEnabled) {
				this.mouseEnabled = true;
				this.gotoAndStop(1);
			}else {
				this.mouseEnabled = false;
				this.gotoAndStop(4);
			}
		}
		
		public function get isEnabled():Boolean {
			return m_isEnabled;
		}
		
		protected function onRollOver_handler(e:MouseEvent):void{
			if(!m_isSelected){
				this.gotoAndStop(2);
			}
		}
		
		protected function onRollOut_handler(e:MouseEvent):void{
			mcRollOut();
		}
		
		protected function mcRollOut():void {
			//已经选中的
			if(m_isSelected){
				this.gotoAndStop(3);
				this.enabled = false;
				this.mouseEnabled = false;
			}else{
				this.gotoAndStop(1);
				this.enabled = true;
				this.mouseEnabled = true;
			}
		}
	}
}