/**
 * 小图集合面板
 * ibio-develop
 * 2010-8-21 17:01
 */
import utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import org.weemvc.as2.view.View;
import application.model.vo.ImageVO;
import application.action.ShowImageCommand;
import application.model.DataProxy;

class application.view.ThumbList extends View {
	private var m_panel:MovieClip;
	private var m_playList:Array;
	private var m_arrowYList:Array = [0, 62.5, 125.0, 187.5];
	private var m_tweenY:Tween;
	
	public function ThumbList(target:MovieClip) {
		m_panel = target;
		setWeeList([DataProxy.PLAYLIST]);
	}
	
	public function onDataChanged(wee:String, data):Void {
		switch(wee) {
			case DataProxy.PLAYLIST:
				m_playList = data;
				buildThumbs();
				//默认是选中第1张
				m_panel["mc_thumb" + 0].isSelected = true;
				sendWee(ShowImageCommand, 0);
				break;
		}
	}
	
	public function toString():String {
		return "ThumbList";
	}
	
	private function buildThumbs():Void {
		for (var i = 0; i < m_playList.length; i++) {
			var imageData:ImageVO = m_playList[i];
			m_panel["mc_thumb" + i].setData(imageData.title, imageData.subtitle);
			m_panel["mc_thumb" + i].onRelease = Delegate.create(this, onThumbClick, {index:i});
		}
	}
	
	private function onThumbClick(obj:Object):Void {
		//清除之前的
		for (var i = 0; i < m_playList.length; i++) {
			m_panel["mc_thumb" + i].isSelected = false;
		}
		m_panel["mc_thumb" + obj.index].isSelected = true;
		//
		var newY:Number = m_arrowYList[obj.index];
		try {
			m_tweenY.stop();
		}catch (e:Error) {
			trace("ThumbList::onThumbClick_handler:" + e.message);
		}
		m_tweenY = new Tween(m_panel.mc_arrow, "_y", Strong.easeOut, m_panel.mc_arrow._y, newY, 1.5, true);
		//trace("当前点击：", e.currentTarget.index);
		sendWee(ShowImageCommand, obj.index);
	}
}