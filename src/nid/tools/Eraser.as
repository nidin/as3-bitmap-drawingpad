package nid.tools 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import nid.Board;
	import nid.utils.GMaths;
	import nid.view.Canvas;
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class Eraser 
	{
		private var canvas:Canvas;
		private var drawRect:Rectangle;
		private var pattern:ByteArray;
		private var _old_x:Number;
		private var _old_y:Number;
		private var continued:Boolean;
		private var shape:Sprite;
		private var patternBitmapData:BitmapData;
		
		public var color:uint = 0xffffffff;
		public var alpha:Number = 1;
		public var thickness:Number = 10;
		
		public function Eraser()
		{
			shape = new Sprite();
			buildPattern();
		}
		public function set setBrushSize(value:int):void 
		{
			thickness = value;
			buildPattern();
		}
		
		private function buildPattern():void 
		{
			shape.graphics.clear();
			shape.graphics.beginFill(color, alpha);
			shape.graphics.drawCircle(thickness/2, thickness/2, thickness/2);
			shape.graphics.endFill();
			
			pattern = null;
			patternBitmapData = new BitmapData(thickness, thickness, true, 0x00000000);
			patternBitmapData.draw(shape, null, null, null, null, true);
			drawRect = new Rectangle(0, 0, thickness, thickness);
			pattern = patternBitmapData.getPixels(drawRect);
			patternBitmapData.dispose();
		}
		public function activate(canvas:Canvas):void 
		{
			Board.app.ui.cursorManager.setCursor(ToolSet.ERASER);
			this.canvas = canvas;
			canvas.stage.addEventListener(MouseEvent.MOUSE_DOWN, handle);
			canvas.stage.addEventListener(MouseEvent.MOUSE_UP, handle);
			
		}
		private function handle(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_DOWN) {
				pattern.position = 0;
				canvas.stage.addEventListener(Event.ENTER_FRAME, drawHandle);
			}else if (e.type == MouseEvent.MOUSE_UP) {
				canvas.stage.removeEventListener(Event.ENTER_FRAME, drawHandle);
				continued = false;
			}
		}
		
		private function setPixels(_x:Number, _y:Number, _w:Number, _h:Number):void 
		{
			var rect:Rectangle = new Rectangle(_x, _y, _w, _h);
			var p1:ByteArray = canvas.activeLayer.drawingPad.bitmapData.getPixels(rect);
			p1.position = 0;
			pattern.position = 0;
			
			for (var i:int = 0; i < p1.length / 4; i++) {
				
				var a1:uint = p1.readUnsignedByte();
				var r1:uint = p1.readUnsignedByte();
				var g1:uint = p1.readUnsignedByte();
				var b1:uint = p1.readUnsignedByte();
				
				var a2:uint = pattern.readUnsignedByte();
				var r2:uint = pattern.readUnsignedByte();
				var g2:uint = pattern.readUnsignedByte();
				var b2:uint = pattern.readUnsignedByte();
				
				var a3:uint = (color >> 24) & 0xff
				var r3:uint = (color >> 16) & 0xff
				var g3:uint = (color >> 8) & 0xff
				var b3:uint = color & 0xff
				
				p1.position = i * 4;
				//pattern.position = i * 4;
				
				if (a1 != a2) {
					//trace(a1, r1, g1, b1, '|', a2, r2, g2, b2, '|', a3, r3, g3, b3);
					p1.writeByte(a1 < a2?a2:a1);
					p1.writeByte(r3);
					p1.writeByte(g3);
					p1.writeByte(b3);
					
				}else {
					p1.writeByte(a2);
					p1.writeByte(r2);
					p1.writeByte(g2);
					p1.writeByte(b2);
				}
			}
			
			p1.position = 0;
			canvas.activeLayer.drawingPad.bitmapData.setPixels(rect, p1);
		}
		
		private function drawHandle(e:Event):void 
		{
			pattern.position = 0;
			var deltaX:Number = _old_x - canvas.mouseX;
			var deltaY:Number = _old_y - canvas.mouseY;
			deltaX = Math.sqrt(deltaX * deltaX);
			deltaY = Math.sqrt(deltaY * deltaY);
			if (continued && (deltaX > 2 || deltaY > 2)) { 
				draw(_old_x, _old_y, canvas.mouseX, canvas.mouseY);
			}else{
				setPixels(canvas.mouseX, canvas.mouseY, thickness, thickness);
				continued = true;
			}
			
			_old_x = canvas.mouseX;
			_old_y = canvas.mouseY;
		}
		
		private function draw(old_x:Number, old_y:Number, mx:Number, my:Number):void 
		{
			var dx:Number = mx - old_x;
			var dy:Number = my - old_y;
			var udx:Number = Math.sqrt(dx * dx);
			var udy:Number = Math.sqrt(dy * dy);
			var c:int = Math.round(udx > udy?dx:dy);
			var nx:Number;
			var ny:Number;
			var Xsign:int = GMaths.SGN(dx);
			var Ysign:int = GMaths.SGN(dy);
			c = Math.sqrt(c * c);
			for (var i:int = 0; i < c; i)
			{
				i += 2;
				nx = (dx * (i / c));
				ny = (dy * (i / c));
				setPixels(old_x + nx, old_y + ny, thickness, thickness);
			}
		}
		
		public function clear():void 
		{
			if (canvas != null) {
				canvas.stage.removeEventListener(Event.ENTER_FRAME, drawHandle);
				canvas.stage.removeEventListener(MouseEvent.MOUSE_DOWN, handle);
				canvas.stage.removeEventListener(MouseEvent.MOUSE_UP, handle);
			}
		}
		
	}

}