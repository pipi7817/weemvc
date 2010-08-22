/**
 * 大图基类
 * ibio-develop
 * 2010-8-22 0:35
 */
class application.view.components.MCBaseImageBox extends MovieClip {
	private var m_loader:MovieClipLoader;
	private var m_width:Number;
	private var m_height:Number;
	private var m_loaded:Number = 0;
	private var m_body:MovieClip;
	
	public function MCBaseImageBox() {
		m_loader = new MovieClipLoader();
		m_loader.addListener(this);
	}
	
	public function setSize(width:Number, height:Number):Void {
		m_width = width;
		m_height = height;
	}
	
	public function load(url:String):Void {
		//清除之前的宽高
		m_body = this.createEmptyMovieClip("mc", 1);
		m_loader.loadClip(url, m_body);
	}
	
	public function get loadPercent():Number {
		return m_loaded;
	}
	
	private function onLoadInit():Void{
		m_body._width = m_width;
		m_body._height = m_height;
	}
	
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number):Void {
		m_loaded = Math.round(bytesLoaded / bytesTotal * 100);
	}
}