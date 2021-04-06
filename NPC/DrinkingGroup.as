package NPC {
	
	import flash.display.MovieClip;
	
	
	public class DrinkingGroup extends NPC {

		override function doAction():void{
			trace("group action");
			level.getDrunk();
		}
	}
	
}
