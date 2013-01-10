package nid 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import nid.handlers.BoardHandler;
	import nid.net.MediaServer;
	import nid.view.UserInterface;
	
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class Board extends Sprite 
	{
		public var ui:UserInterface;
		public var mediaServer:MediaServer;
		public var boardHandler:BoardHandler;
		public var notifier:EventDispatcher;
		
		static private var instance:Board;
		static public function get app():Board { return instance; }
		
		public function Board() 
		{
			instance = this;
			
			ui 		= new UserInterface();
			notifier = new EventDispatcher();
			mediaServer = new MediaServer();
			boardHandler = new BoardHandler();
			
			addEventListener(Event.ADDED_TO_STAGE, initUI);
		}
		
		private function initUI(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initUI);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align 	= StageAlign.TOP_LEFT;
			
			addChild(ui);
		}
		
	}

}