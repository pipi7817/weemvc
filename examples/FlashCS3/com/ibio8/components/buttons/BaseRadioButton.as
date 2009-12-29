/**
 * 单选按钮的基类
 * ibio-develop
 * 2008-11-20 14:20
 */
package com.ibio8.components.buttons {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class BaseRadioButton extends MovieClip {
		protected var m_btn:MovieClip;
		//是否选中
		protected var m_selected:Boolean = false;
		//是否禁用
		protected var m_enabled:Boolean = true;
		
		/**
		 * 构造函数
		 * @param	button<MovieClip>:		库里当前的按钮 MC 或者是舞台上还未添加到显示列表的 MC
		 * @param	useInherit<Boolean>:	是继承库里的 MC 还是将舞台上的 MC 作为资源加载进来，默认为false
		 */
		public function BaseRadioButton(button:MovieClip, useInherit:Boolean = false) {
			m_btn = button;
			if (!useInherit) {
				this.addChild(m_btn);
			}
			m_btn.stop();
			m_btn.buttonMode = true;
			m_btn.mouseChildren = false;
			m_btn.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			m_btn.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			m_btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			m_btn.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			//这里用 REMOVED_FROM_STAGE 表示：一旦包含此对象的子树
			//从显示列表移除，则发出此事件
			m_btn.addEventListener(Event.REMOVED_FROM_STAGE, onBtnRemovedHandler);
		}
		
		/**
		 * 如果是直接 new BaseRadioButton，则可通过 getter 返回当前的 button MC
		 */
		public function get self():MovieClip {
			return m_btn;
		}
		
		//是否为选中状态
		public function set selected(value:Boolean):void {
			m_selected = value;
			mcRollOut();
		}
		
		public function get selected():Boolean {
			return m_selected;
		}
		
		//是否禁用此按钮
		public override function set enabled(value:Boolean):void {
			if (m_enabled == value) {
				return;
			}
			m_enabled = value;
			//激活
			if (m_enabled) {
				mcRollOut();
			}else {
				m_btn.mouseEnabled = false;
				m_btn.gotoAndStop(4);
			}
		}
		
		public override function get enabled():Boolean {
			return m_enabled;
		}
		
		protected function onRollOverHandler(e:MouseEvent):void {
			if(!m_selected){
				m_btn.gotoAndStop(2);
			}
		}
		
		protected function onRollOutHandler(e:MouseEvent):void {
			mcRollOut();
		}
		
		protected function onMouseDownHandler(e:MouseEvent):void {
			if(!m_selected){
				m_btn.gotoAndStop(3);
			}
		}
		
		protected function onMouseUpHandler(e:MouseEvent):void {
			if(!m_selected){
				m_btn.gotoAndStop(2);
			}
		}
		
		protected function mcRollOut():void {
			if (m_enabled) {
				//已经选中的
				if(m_selected){
					m_btn.gotoAndStop(3);
					m_btn.mouseEnabled = false;
				}else{
					m_btn.gotoAndStop(1);
					m_btn.mouseEnabled = true;
				}
			}
		}
		
		protected function onBtnRemovedHandler(e:Event):void {
			m_btn.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			m_btn.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			m_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			m_btn.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			m_btn.removeEventListener(Event.REMOVED_FROM_STAGE, onBtnRemovedHandler);
		}
	}
}