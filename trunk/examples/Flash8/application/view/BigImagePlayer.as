import utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import org.weemvc.as2.view.BaseView;
import application.model.vo.ImageVO;
		
class application.view.BigImagePlayer extends BaseView {
	public static var NAME:String = "bigImagePlayer";
	private var m_player:MovieClip;
	private var m_playList:Array;
	private var m_posList:Array = new Array();
	private var m_tweenX:Tween;
	private var m_tweenY:Tween;
	private var m_currIndex:Number;
	private var m_imageList:Array = new Array();
	
	public function BigImagePlayer(target:MovieClip) {
		m_player = target;
		m_player.txt_title.text = "";
		m_player.txt_description.text = "";
		m_player.buttonMode = true;
		m_player.btn.onRelease = Delegate.create(this, onBtnClick);
	}
	
	public function init(playList:Array):Void {
		m_playList = playList;
		buildImages();
		trace("已经流到这里！");
		m_player.mc_body.setMask(m_player.mc_mask);
	}
	
	public function get currImgLoadPercent():Number {
		return m_imageList[m_currIndex].loadPercent;
	}
	
	public function showImage(index:Number):Void {
		//trace(index);
		m_currIndex = index;
		var imageData:ImageVO = m_playList[m_currIndex];
		m_player.txt_title.text = imageData.title;
		m_player.txt_description.text = imageData.description;
		var newX:Number = m_posList[m_currIndex].x;
		var newY:Number = m_posList[m_currIndex].y;
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
			var imageBox:MovieClip = m_player.mc_body.attachMovie("mc_ImageBox", "mc_ImageBox" + i, i);
			imageBox.setSize(m_player.mc_mask._width, m_player.mc_mask._height);
			imageBox._x = 0;
			imageBox._y = i * m_player.mc_mask._height;
			imageBox.load(imageData.location);
			m_imageList.push(imageBox);
			m_posList.push({x:imageBox._x, y:imageBox._y});
		}
	}
	
	private function onBtnClick():Void {
		var imageData:ImageVO = m_playList[m_currIndex];
		getURL(imageData.clickUrl, "_blank");
		//trace(imageData.clickUrl);
	}
}