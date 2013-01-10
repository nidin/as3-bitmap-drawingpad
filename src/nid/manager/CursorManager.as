package nid.manager 
{
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import flash.utils.Dictionary;
	import nid.tools.ToolSet;
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class CursorManager 
	{
		[Embed(source = "cursors/assets/pencil.png")]private var pencil_img:Class;
		[Embed(source = "cursors/assets/eraser.png")]private var eraser_img:Class;
		
		public function CursorManager() 
		{
			Mouse.registerCursor(ToolSet.PENCIL, getCursorData(new pencil_img().bitmapData));
			Mouse.registerCursor(ToolSet.ERASER, getCursorData(new eraser_img().bitmapData));
		}
		public function setCursor(name:String):void {
			Mouse.cursor = name;
		}
		
		public function getCursorData(bitmapData:BitmapData):MouseCursorData
		{
			var data:MouseCursorData = new MouseCursorData();
			var bmpData:Vector.<BitmapData> = new Vector.<BitmapData>(1, true);
			bmpData[0] = bitmapData;
			data.data = bmpData;
			return data
		}
		
	}

}