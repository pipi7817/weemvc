/**
 * 舞台管理面板
 * ibio-develop
 * 2009-5-12 11:41
 */
package application.view {
	import application.model.DataProxy;
	
	import org.weemvc.as3.view.View;
	import flash.display.MovieClip;
	
	public class StageManager extends View {
		protected var m_root:MovieClip;
		
		public function StageManager(main:MovieClip) {
			m_root = main;
			m_root.txt_initialize.x = (m_root.stage.stageWidth - m_root.txt_initialize.width) / 2;
			m_root.txt_initialize.y = (m_root.stage.stageHeight - m_root.txt_initialize.height) / 2;
			hideLoading();
			setWeeList([DataProxy.PLAYLIST, Main.LOADING_IMAGE]);
		}
		
		override public function onDataChanged(wee:String, data:Object = null):void {
			switch(wee) {
				case DataProxy.PLAYLIST:
					hideInitialize();
					break;
				case Main.LOADING_IMAGE:
					var p:uint = data as uint;
					if (p < 100) {
						showLoading(p);
					}else {
						hideLoading();
					}
					break;
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