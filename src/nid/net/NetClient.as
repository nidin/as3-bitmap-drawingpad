package nid.net 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class NetClient extends EventDispatcher 
	{
		/** connection setup **/
		protected var nc:NetConnection;
		
		
		public function get connected():Boolean
		{
			return(nc != null && nc.connected);
		}
		
		public function NetClient() 
		{
			
		}
		public function close():void
		{
			if (nc != null && nc.connected)
			{
				nc.close();
			}
		}
		
		protected function onAsyncErrorEvent(e:AsyncErrorEvent):void 
		{
			trace('[AsyncErrorEvent]:' + e.error);
		}
		
		public function onBWCheck(info:Object=null):void
		{
			
		}
		/*
		 * ON META DATA LOAD
		 */
		public function onMetaData(infoObject:Object):void 
		{
			
		}
		/*
		 * Cue Point
		 */
		public function onCuePoint(infoObject:Object):void
		{
			
		}
		/*
		 * On Play Status
		 */
		public function onPlayStatus(infoObject:Object):void
		{
			
		}
		/*
		 * On onBWDone
		 */
		public function onBWDone(...param):void
		{
			
		}
		public function onTimeCoordInfo(info:Object=null):void
		{
			
		}
		protected function doAsyncError(e:AsyncErrorEvent):void 
		{
			
		}
	}

}