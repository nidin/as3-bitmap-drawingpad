package nid.view 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	import nid.manager.CursorManager;
	import nid.tools.Eraser;
	import nid.tools.Pencil;
	import nid.tools.ToolSet;
	
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class UserInterface extends Sprite 
	{
		private var canvas:Canvas;
		private var toolView:Sprite;
		private var tools:Dictionary;
		private var lastTool:String;
		public var cursorManager:CursorManager;
			
		public function UserInterface() 
		{
			cursorManager = new CursorManager();
			
			tools = new Dictionary();
			tools[ToolSet.PENCIL] = new Pencil();
			tools[ToolSet.ERASER] = new Eraser();
			
			canvas = new Canvas();
			toolView = new Sprite();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, onResize);
			
			addChild(canvas);
			addChild(toolView);
			canvas.addLayer("userId");
			activateTool(ToolSet.PENCIL);
		}
		
		private function activateLastTool(e:Event=null):void 
		{
			activateTool(lastTool);
		}
		
		public function activateTool(tool:String):void {
			clear();
			switch(tool) {
				case ToolSet.SELECTION: {
					lastTool = tool;
				}break;
				case ToolSet.COLORPAD: {
				}break;
				case ToolSet.PENCIL: {
					tools[ToolSet.PENCIL].activate(canvas);
					tools[ToolSet.PENCIL].setBrushColor(0xff0000);
					lastTool = tool;
				}break;
				case ToolSet.ERASER: {
					tools[ToolSet.ERASER].activate(canvas);
					lastTool = tool;
				}break;
			}
			onResize();
		}
		
		private function clear():void 
		{
			trace('clear');
			for (var i:int = 0; i < toolView.numChildren; i++)
			{
				if (toolView.getChildAt(i) != null) toolView.removeChild(toolView.getChildAt(i));
			}
			if (lastTool != null && tools[lastTool] != undefined) tools[lastTool].clear();
		}
		
		private function onResize(e:Event=null):void 
		{
			
		}
	}

}