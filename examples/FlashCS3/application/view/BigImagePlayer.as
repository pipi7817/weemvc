/**
 * 大图播放区域
 * ibio-develop
 * 2009-5-12 11:40
 */
package application.view {
	import org.weemvc.as3.view.View;
	import application.model.vo.ImageVO;
	import application.model.DataProxy;
	import application.view.components.ImageBox;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class BigImagePlayer extends View {
		protected var m_player:MovieClip;
		protected var m_playList:Array;
		protected var m_posList:Array = new Array();
		protected var m_tweenX:Tween;
		protected var m_tweenY:Tween;
		protected var m_currentIndex:uint;
		protected var m_imageList:Array = new Array();
		
		public function BigImagePlayer(target:MovieClip) {
			m_player = target;
			m_player.txt_title.text = "";
			m_player.txt_description.text = "";
			m_player.buttonMode = true;
			m_player.addEventListener(MouseEvent.CLICK, onClickHandler);
			setWeeList([DataProxy.PLAYLIST, DataProxy.CURRENT_INDEX]);
		}
		
		override public function onDataChanged(wee:String, data:Object = null):void {
			switch(wee) {
				case DataProxy.PLAYLIST:
					init(data as Array);
					break;
				case DataProxy.CURRENT_INDEX:
					showImage(data as uint);
					break;
			}
		}
		
		public function init(playList:Array):void {
			m_playList = playList;
			buildImages();
			m_player.mc_body.mask = m_player.mc_mask;
		}
		
		public function showImage(index:uint):void {
			//trace(index);
			m_currentIndex = index;
			var imageData:ImageVO = m_playList[m_currentIndex] as ImageVO;
			m_player.txt_title.text = imageData.title;
			m_player.txt_description.text = imageData.description;
			var newX:uint = m_posList[m_currentIndex].x;
			var newY:uint = m_posList[m_currentIndex].y;
			try {
				m_tweenX.stop();
				m_tweenY.stop();
			}catch (e:Error) {
				trace("BigImagePlayer::showImage:", e.message);
			}
			m_tweenX = new Tween(m_player.mc_body, "x", Strong.easeOut, m_player.mc_body.x, -newX, 1.5, true);
			m_tweenY = new Tween(m_player.mc_body, "y", Strong.easeOut, m_player.mc_body.y, -newY, 1.5, true);
		}
		
		protected function buildImages():void {
			for (var i = 0; i < m_playList.length; i++) {
				var imageData:ImageVO = m_playList[i] as ImageVO;
				var imageBox:ImageBox = new ImageBox(showImgLoadPercent, m_player.mc_mask.width, m_player.mc_mask.height);
				imageBox.index = i;
				imageBox.x = 0;
				imageBox.y = i * m_player.mc_mask.height;
				imageBox.load(imageData.location);
				m_player.mc_body.addChild(imageBox);
				m_imageList.push(imageBox);
				m_posList.push({x:imageBox.x, y:imageBox.y});
			}
		}
		
		protected function showImgLoadPercent(percent:uint):void {
			//如果是当前的大图
			if (m_imageList[m_currentIndex].index == m_currentIndex) {
				sendWee(Main.LOADING_IMAGE, percent);
			}
		}
		
		protected function onClickHandler(e:MouseEvent):void {
			var imageData:ImageVO = m_playList[m_currentIndex] as ImageVO;
			navigateToURL(new URLRequest(imageData.clickUrl), "_blank");
			//trace(imageData.clickUrl);
		}
	}
}