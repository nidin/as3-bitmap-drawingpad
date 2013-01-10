package nid.view 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class Canvas extends Sprite 
	{
		private var layers:Vector.<Layer>;
		
		public var activeLayer:Layer;
		
		public function Canvas() 
		{
			layers = new Vector.<Layer>();
		}
		public function addLayer(name:String):void {
			var layer:Layer = new Layer(name, stage.stageWidth, stage.stageHeight);
			addChild(layer);
			activeLayer = layer;
			layers.push(layer);
		}
		public function getLayer(name:String):Layer {
			for (var i:int = 0; i < layers.length; i++){
				if (layers[i].name == name){
					return layers[i];
				}
			}
			return null;
		}
		public function setLayer(name:String):void {
			activeLayer = getLayer(name);
		}
		public function removeLayer(name:String):void {
			for (var i:int = 0; i < layers.length; i++){
				if (layers[i].name == name){
					if (this.contains(layers[i])) this.removeChild(layers[i]);
				}
			}
		}
	}

}