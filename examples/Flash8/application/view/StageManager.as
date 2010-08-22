/**
 * 舞台管理
 * ibio-develop
 * 2010-8-21 2:49
 */
import org.weemvc.as2.view.View;
import application.model.DataProxy;

class application.view.StageManager extends View {
	public static var NAME:String = "stageManager";
	public static var SHOW_PERCENT:String = "showPercent";
	public static var HIDE_PERCENT:String = "hidePercent";
	private var m_root:MovieClip;
	
	public function StageManager(stage:MovieClip) {
		m_root = stage;
		m_root.txt_initialize.x = (Stage.width - m_root.txt_initialize._width) / 2;
		m_root.txt_initialize.y = (Stage.height - m_root.txt_initialize._height) / 2;
		hideLoading();
		setNotifications([DataProxy.ON_DATA_LOADED, SHOW_PERCENT, HIDE_PERCENT]);
	}
	
	public function onDataChanged(notification:String, data):Void {
		if (notification == DataProxy.ON_DATA_LOADED) {
			m_root.txt_initialize._visible = false;
		}else if(notification == SHOW_PERCENT) {
			showLoading(data);
		}else if (notification == HIDE_PERCENT) {
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
}