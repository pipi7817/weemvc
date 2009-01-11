package application.events {
	
	import flash.events.Event;

	public class PlayListBuilderEvent extends Event {
		
		public static const PLAYLIST_LOAD:String = "playListLoad";
		public static const LOAD_ERROR:String = "loadError";
		
		public var playList:Array;
		
		public function PlayListBuilderEvent(type:String, playList:Array = null){
			super(type);
			if (playList != null) {
				this.playList = playList;
			}
		}
	}
}