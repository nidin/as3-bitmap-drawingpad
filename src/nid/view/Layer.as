package nid.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class Layer extends Sprite 
	{
		public var drawingPad:Bitmap;
		
		public function Layer(name:String,w:Number,h:Number) 
		{
			super.name = name;
			drawingPad = new Bitmap(new BitmapData(w, h, true, 0x00000000));
			addChild(drawingPad);
		}
		
	}

}