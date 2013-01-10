package nid.net 
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import nid.Board;
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class MediaServer extends NetClient
	{
		public var SERVER:String;
		public var APP:String = "board";
		
		public function MediaServer() 
		{
			
		}
		/** 
		 * connection 
		 **/
		public function connect():void {
			
			if (nc == null)
			{
				nc = new NetConnection();
			}
			else if(nc.connected)
			{
				nc.close();
			}
			if (SERVER == null || APP == null) {
				trace('[SERVER ]:' + SERVER +',[APP]:' + APP);
				return;
			}
			nc.client = this;
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
			nc.connect(SERVER +'/' + APP);
			trace(SERVER +'/' + APP);
		}
		private function netStatus(e:NetStatusEvent):void 
		{
			trace(e.info.code)
			if (e.info.code == 'NetConnection.Connect.Success') { 
				
			} else if (e.info.code == 'NetConnection.Connect.Failed') {
			}
		}
		
	}

}