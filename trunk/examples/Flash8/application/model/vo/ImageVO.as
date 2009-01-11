class application.model.vo.ImageVO {
	public var title:String;
	public var subtitle:String;
	public var description:String;
	public var clickUrl:String;
	public var location:String;
	
	public function toString():String {
		var str:String = "[ImageVO =";
		str += " title:" + title;
		str += " subtitle:" + subtitle;
		str += " description:" + description;
		str += " clickUrl:" + clickUrl;
		str += " location:" + location;
		str += "]";
		return str;
	}
}