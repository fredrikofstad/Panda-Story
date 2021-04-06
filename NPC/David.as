package NPC {
	
	import flash.display.MovieClip;
	
	
	public class David extends NPC {
		
		override function doAction():void{
			level.doSkate();
			trace("david action");
		}
	}
	
}
