import org.weemvc.as2.view.BaseView;

class application.view.StageInitialize extends BaseView {
	public static var NAME:String = "stageInit";
	private var m_root:MovieClip;
	
	public function StageInitialize(stage:MovieClip) {
		m_root = stage;
		m_root.txt_initialize.x = (Stage.width - m_root.txt_initialize._width) / 2;
		m_root.txt_initialize.y = (Stage.height - m_root.txt_initialize._height) / 2;
		hideLoading();
	}
	
	public function hideInitialize():Void {
		m_root.txt_initialize._visible = false;
	}
	
	public function showLoading(percent:Number):Void {
		if (!m_root.txt_loading._visible) {
			m_root.txt_loading._visible = true;
		}
		m_root.txt_loading.text = "loading... " + percent + "%";
	}
	
	public function hideLoading():Void {
		m_root.txt_loading._visible = false;
	}
}