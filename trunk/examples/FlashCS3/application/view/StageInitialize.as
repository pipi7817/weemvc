/**
 * 舞台管理面板
 * ibio-develop
 * 2009-5-12 11:41
 */
package application.view {
	import org.weemvc.as3.view.View;
	import flash.display.MovieClip;
	
	public class StageInitialize extends View {
		protected var m_root:MovieClip;
		
		public function StageInitialize(main:MovieClip) {
			m_root = main;
			m_root.txt_initialize.x = (m_root.stage.stageWidth - m_root.txt_initialize.width) / 2;
			m_root.txt_initialize.y = (m_root.stage.stageHeight - m_root.txt_initialize.height) / 2;
			hideLoading();
			notifications = [Main.PLAY_LIST_LOADED, Main.LOADING_IMAGE];
		}
		
		override public function onDataChanged(notification:String, data:Object = null):void {
			if (notification == Main.PLAY_LIST_LOADED) {
				hideInitialize();
			}else if (notification == Main.LOADING_IMAGE) {
				var p:uint = data as uint;
				if (p < 100) {
					showLoading(p);
				}else {
					hideLoading();
				}
			}
		}
		
		public function hideInitialize():void {
			m_root.txt_initialize.visible = false;
		}
		
		public function showLoading(percent:uint):void {
			if (!m_root.txt_loading.visible) {
				m_root.txt_loading.visible = true;
			}
			m_root.txt_loading.text = "loading... " + percent + "%";
		}
		
		public function hideLoading():void {
			m_root.txt_loading.visible = false;
		}
	}
}