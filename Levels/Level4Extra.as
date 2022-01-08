package Levels {

	import flash.display.MovieClip;

	public class Level4Extra extends LevelClass {
		public function Level4Extra(fromTrain: Boolean = false) {
			if (fromTrain) {
				Main.panda.visible = false;
				Main.panda.halt();
				train.gotoAndPlay(2);
			}
		}
		override function loopCode(): void {
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

	}

}