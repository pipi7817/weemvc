package application.view.components {
	import com.ibio8.components.button.MCCheckButton;
	
	import flash.text.TextField;
	
	public class MCThumbBox extends MCCheckButton {
		public var index:uint;
		
		public function MCThumbBox() {
			super();
			this.txt_title.text = "";
			this.txt_subtitle.text = "";
		}
		
		public function setData(title:String, subtitle:String):void {
			this.txt_title.text = title;
			this.txt_subtitle.text = subtitle;
		}
	}
}