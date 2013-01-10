package nid.utils 
{
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	import nid.events.VCREvent;
	import nid.events.VCRSignals;
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class Transmitter extends EventDispatcher
	{
		public var streamSignalTx:String;
		public var boardSignalTx:String;
		
		private var jsTx:Dictionary;
		private var jsRx:Dictionary;
		private var receiveAll:Boolean;
		
		public function Transmitter() 
		{
			jsTx = new Dictionary();
			jsRx = new Dictionary();
		}
		
		public function callback(signal:String, data:Object = null):void
		{
			if (ExternalInterface.available && jsRx[signal] != undefined) ExternalInterface.call(jsRx[signal], { signal:signal, data:data } );
		}
		public function addCallBack(signal:String, _callback:String):void 
		{
			jsRx[signal] = _callback;
		}
		public function getCallback(signal:String):String 
		{
			return jsRx[signal];
		}
		public function addTx(signal:String, listener:String):void 
		{
			if (signal == "ALL") {
				receiveAll = true; 
				jsTx[signal] = listener; 
				return; 
			}
			if (VCREvent.available(signal)) jsTx[signal] = listener;
			else ExternalInterface.call("handleAS3Exceptions", { signal:VCREvent.WARNING, data:"[ NOT IMPLEMENTED ] " + signal } );
		}
		
		public function transmit(signal:String, data:Object=null):void
		{
			if (ExternalInterface.available && (receiveAll || jsTx[signal] != undefined)) ExternalInterface.call(jsTx[receiveAll?"ALL":signal], { signal:signal, data:data } );
		}
		
	}

}