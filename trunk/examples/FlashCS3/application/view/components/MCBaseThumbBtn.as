package application.view.components {
	import com.ibio8.components.buttons.BaseRadioButton;
	
	import flash.text.TextField;
	
	public class MCBaseThumbBtn extends BaseRadioButton {
		public var index:uint;
		
		public function MCBaseThumbBtn() {
			super(this);
			this.txt_title.text = "";
			this.txt_subtitle.text = "";
		}
		
		public function setData(title:String, subtitle:String):void {
			this.txt_title.text = title;
			this.txt_subtitle.text = subtitle;
		}
	}
}