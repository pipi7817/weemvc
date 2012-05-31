/**
 * 大图播放区域
 * ibio-develop
 * 2010-8-21 17:01
 */
import utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import org.weemvc.as2.view.View;
import application.model.vo.ImageVO;
import application.model.DataProxy;
import application.view.StageManager;
	
class application.view.BigImagePlayer extends View {
	private var m_player:MovieClip;
	private var m_playList:Array;
	private var m_posList:Array = new Array();
	private var m_tweenX:Tween;
	private var m_tweenY:Tween;
	private var m_currentIndex:Number;
	private var m_imageList:Array = new Array();
	private var m_timer:Number;
	
	public function BigImagePlayer(target:MovieClip) {
		m_player = target;
		m_player.txt_title.text = "";
		m_player.txt_description.text = "";
		m_player.btn.onRelease = Delegate.create(this, onBtnClick);
		setWeeList([DataProxy.PLAYLIST, DataProxy.CURRENT_INDEX]);
	}
	
	public function onDataChanged(wee:String, data):Void {
		switch(wee) {
			case DataProxy.PLAYLIST:
				m_playList = data;
				buildImages();
				m_player.mc_body.setMask(m_player.mc_mask);
				break;
			case DataProxy.CURRENT_INDEX:
				changeImage(data);
				break;
		}
	}
	
	public function changeImage(index:Number):Void {
		m_currentIndex = index;
		clearInterval(m_timer);
		sendWee(StageManager.HIDE_PERCENT, null);
		m_player.txt_title.text = "";
		m_player.txt_description.text = "";
		if (m_imageList[m_currentIndex].loadPercent < 100) {
			m_timer = setInterval(Delegate.create(this, onTimer), 100);
		}else {
			showImage();
		}
	}
	
	public function toString():String {
		return "BigImagePlayer";
	}
	
	private function showImage():Void {
		var imageData:ImageVO = m_playList[m_currentIndex];
		m_player.txt_title.text = imageData.title;
		m_player.txt_description.text = imageData.description;
		var newX:Number = m_posList[m_currentIndex].x;
		var newY:Number = m_posList[m_currentIndex].y;
		try {
			m_tweenX.stop();
			m_tweenY.stop();
		}catch (e:Error) {
			trace("BigImagePlayer::showImage:" + e.message);
		}
		m_tweenX = new Tween(m_player.mc_body, "_x", Strong.easeOut, m_player.mc_body._x, -newX, 1.5, true);
		m_tweenY = new Tween(m_player.mc_body, "_y", Strong.easeOut, m_player.mc_body._y, -newY, 1.5, true);
	}
	
	private function buildImages():Void {
		for (var i = 0; i < m_playList.length; i++) {
			var imageData:ImageVO = m_playList[i];
			var imageBox:MovieClip = m_player.mc_body.attachMovie("MCImageBox", "mc_ImageBox" + i, i);
			imageBox.setSize(m_player.mc_mask._width, m_player.mc_mask._height);
			imageBox._x = 0;
			imageBox._y = i * m_player.mc_mask._height;
			imageBox.load(imageData.location);
			m_imageList.push(imageBox);
			m_posList.push({x:imageBox._x, y:imageBox._y});
		}
	}
	
	private function onTimer():Void {
		if (m_imageList[m_currentIndex].loadPercent < 100) {
			sendWee(StageManager.SHOW_PERCENT, m_imageList[m_currentIndex].loadPercent);
		}else {
			clearInterval(m_timer);
			showImage();
			sendWee(StageManager.HIDE_PERCENT, null);
		}
	}
	
	private function onBtnClick():Void {
		var imageData:ImageVO = m_playList[m_currentIndex];
		getURL(imageData.clickUrl, "_blank");
		//trace(imageData.clickUrl);
	}
}