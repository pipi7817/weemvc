/**
 * 舞台管理
 * ibio-develop
 * 2010-8-21 2:49
 */
import org.weemvc.as2.view.View;
import application.model.DataProxy;

class application.view.StageManager extends View {
	public static var SHOW_PERCENT:String = "showPercent";
	public static var HIDE_PERCENT:String = "hidePercent";
	private var m_root:MovieClip;
	
	public function StageManager(stage:MovieClip) {
		m_root = stage;
		m_root.txt_initialize.x = (Stage.width - m_root.txt_initialize._width) / 2;
		m_root.txt_initialize.y = (Stage.height - m_root.txt_initialize._height) / 2;
		hideLoading();
		setWeeList([DataProxy.PLAYLIST, SHOW_PERCENT, HIDE_PERCENT]);
	}
	
	public function onDataChanged(wee:String, data):Void {
		if (wee == DataProxy.PLAYLIST) {
			m_root.txt_initialize._visible = false;
		}else if(wee == SHOW_PERCENT) {
			showLoading(data);
		}else if (wee == HIDE_PERCENT) {
			hideLoading();
		}
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
	
	public function toString():String {
		return "StageManager";
	}
}