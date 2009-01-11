/**
 * 数据加载
 * ibio-develop
 * 2009-1-11 21:01
 */
import utils.Delegate;
import utils.JSON;
import mx.events.EventDispatcher;
import application.model.vo.ImageVO;
	
class application.model.PlayListBuilder {
	public static var LOAD_LIST:String = "load_LIST";
	public var addEventListener:Function;
	private var dispatchEvent:Function;
	private var m_loader:LoadVars;
	
	public function PlayListBuilder() {
		EventDispatcher.initialize(this);
		m_loader = new LoadVars();
		m_loader.onData = Delegate.create(this, onListLoaded);
	}
	
	public function load(data:String):Void {
		//判断是JSON还是URL
		if ((data.indexOf('"') != -1) &&
			(data.indexOf(':') != -1) &&
			((data.indexOf('[') != -1) || (data.indexOf('{') != -1)) &&
			((data.indexOf('}') != -1) || (data.indexOf('}') != -1))) {
			//JSON
			paseJSON(data);
		}else {
			try {
				//m_loader.load(new URLRequest(data + "?r=" + Math.random()));
				m_loader.load(data);
			}catch (e:Error) {
				trace("加载播放列表失败::" + e.message);
			}
		}
	}
	
	private function onListLoaded(data:String):Void {
		paseJSON(data);
	}
	
	private function paseJSON(data:String):Void {
		try {
			var result:Object = JSON.parse(data);
		}catch (e:Error) {
			trace("playList JSON 解析失败！::" + e.message);
			return;
		}
		var playList:Array = new Array();
		//build playList
		for (var i:Number = 0; i < result.length; i++) {		
			var vo:ImageVO = new ImageVO();
			vo.title 		= result[i].title;
			vo.subtitle		= result[i].subtitle;
			vo.description 	= result[i].description;
			vo.clickUrl 	= result[i].clickUrl;
			vo.location 	= result[i].location;
			//trace(vo.toString());
			playList.push(vo);
		}
		//dispatch
		dispatchEvent({type:LOAD_LIST, playList:playList});
	}
}