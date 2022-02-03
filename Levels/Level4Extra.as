package Levels {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import MiniGame.Sledding;

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
			door2.enter(4);
			//sleeding game
			if(!inGame && door3.hitbox.hitTestObject(player.hitbox)){
				sledGame = new Sledding;
				addChild(sledGame);
				var localPoint:Point = sledGame.parent.globalToLocal(new Point(0,0));
				sledGame.x = localPoint.x;
				sledGame.y = localPoint.y;
				inGame = true;
				Main.instance.cutscene(true);
				Main.panda.x -= 10;
			}
			// characters
			// buy skis from guy

			// play minigame guy

		}

	}

}