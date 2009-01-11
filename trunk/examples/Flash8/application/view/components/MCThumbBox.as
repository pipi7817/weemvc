import utils.Delegate;

class application.view.components.MCThumbBox extends MovieClip {
	//是否选中
	private var m_isSelected:Boolean = false;
	private var txt_title:TextField;
	private var txt_subtitle:TextField;
	
	public function MCThumbBox() {
		this.stop();
		this.onRollOver = Delegate.create(this, mcRollOver);
		this.onRollOut = this.onReleaseOutside = Delegate.create(this, mcRollOut);
		this.txt_title.text = "";
		this.txt_subtitle.text = "";
	}
	
	//是否为选中状态
	public function set isSelected(value:Boolean):Void {
		m_isSelected = value;
		mcRollOut();
	}
	
	public function get isSelected():Boolean {
		return m_isSelected;
	}
	
	public function setData(title:String, subtitle:String):Void {
		this.txt_title.text = title;
		this.txt_subtitle.text = subtitle;
	}
	
	private function mcRollOver():Void {
		if(!m_isSelected){
			this.gotoAndStop(2);
		}
	}
	
	private function mcRollOut():Void {
		//已经选中的
		if( m_isSelected ){
			this.gotoAndStop(3);
			this.enabled = false;
		}else{
			this.gotoAndStop(1);
			this.enabled = true;
		}
	}
}