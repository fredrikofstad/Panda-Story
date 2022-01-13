package Levels {

	import flash.display.MovieClip;

	public class Level4Extra extends LevelClass {
		
		var sledGame: Sledding;
		var inGame: Boolean;
		
		public function Level4Extra(fromTrain: Boolean = false) {
			if (fromTrain) {
				Main.panda.visible = false;
				Main.panda.halt();
				train.gotoAndPlay(2);
			}
		}
		override function loopCode(): void {
			station();
			cabin();
		}
		
		function station():void{
			//door
			door.enter(4);
			//train
			if (train.currentLabel == "arrive") {
				Main.u.transition();
				Main.panda.visible = true;
				Main.panda.resume();				
				train.gotoAndPlay("leave");
				Progression.flag.trainDone = true;
			}
			if (train.currentLabel == "asako") {
				if (Progression.flag.trainDone) {
					train.gotoAndPlay("panda");
				}
			}
			if (player.hitTestObject(stationWall)) {
				fadeOut(stationWall);
			} else {
				fadeIn(stationWall);
			}
		}
		function cabin():void{
			//doors
			if(!inGame && door3.hitbox.hitTestObject(player.hitbox)){
				sledGame = new Sledding;
				parent.addChild(sledGame);
				inGame = true;
				trace("sled game");
				//disable and relocate panda
			}
		}

	}

}