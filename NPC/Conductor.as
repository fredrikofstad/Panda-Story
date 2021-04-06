package NPC {
	
	import flash.display.MovieClip;

	public class Conductor extends NPC {

		override function doAction():void{
			level.startTrain();
		}
	}
	
}
