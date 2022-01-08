package Levels {
	
	import flash.display.MovieClip;
	
	
	public class Level4 extends Levels.LevelClass {
		
		
		public function Level4() {
			// constructor code
		}
		override function loopCode(): void {
			//doors
			doorStation.enter(8);
			doorCabin.enter(8);
		}
		
	}
	
}
