package application.view {
	import org.weemvc.as3.view.BaseView;
	import flash.display.MovieClip;
	
	public class StageInitialize extends BaseView {
		protected var m_root:MovieClip;
		
		public function StageInitialize(main:MovieClip) {
			m_root = main;
			m_root.txt_initialize.x = (m_root.stage.stageWidth - m_root.txt_initialize.width) / 2;
			m_root.txt_initialize.y = (m_root.stage.stageHeight - m_root.txt_initialize.height) / 2;
			hideLoading();
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