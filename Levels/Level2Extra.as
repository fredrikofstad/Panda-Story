package Levels {
	
	import flash.display.MovieClip;
	
	
	public class Level2Extra extends Levels.LevelClass {
		
		
		public function Level2Extra() {
			// constructor code
		}
		override function loopCode(): void {
			door.enter(2, 2);
			if(doll.hitTestObject(player.hitbox) && Main.key.space) {
				say(["This doll looks familiar"]);
			}
		}
	}
	
}
