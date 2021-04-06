package NPC {
	
	import flash.display.MovieClip;
	
	public class Barrista extends NPC {

		override function doAction():void{
			level.startIceEvent();
		}
	}
	
}
