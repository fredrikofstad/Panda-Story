package NPC {
	
	import flash.display.MovieClip;
	
	
	public class NewEngineer extends NPC {
		
		override function doAction():void{
			Main.level.changeStage(8);
		}
	}
	
}
