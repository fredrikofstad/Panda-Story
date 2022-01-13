package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import Levels.*;


	public class LevelManager extends MovieClip {

		private var player;
		private var bumpTrigger: Boolean = false;
		private var rBumpTrigger: Boolean = false;
		private var dBumpTrigger: Boolean = false;
		private var _startY: int = 550;
		private var currentStage = 1;
		private var snowing: Boolean = false;
		private var loadedLevel = null;


		public function LevelManager() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			player = Main.panda;
			this.addEventListener(Event.ENTER_FRAME, loop);

			_startY = this.y;
		}

		public function get startY(): int {
			return _startY;
		}

		function loop(e: Event) {
			player = Main.panda;
			if (!player.isHalt && loadedLevel != null) {
				collisions();
			}
		}

		function collisions(): void {
			if (loadedLevel.ground.hitTestPoint(player.x, player.y + 3, true)) {
				player.downBumping = true;
				dBumpTrigger = true;
			} else {
				if (dBumpTrigger) {
					player.downBumping = false;
					dBumpTrigger = false;
				}
			}
			if (loadedLevel.ground.hitTestPoint(player.x, player.y - 10, true)) {
				player.underBumping = true;
			} else {
				player.underBumping = false;
			}
			if (loadedLevel.ground.hitTestPoint(player.x - player.width / 3, player.y - player.height / 3, true)) {
				player.leftBumping = true;
				bumpTrigger = true;
			} else {
				if (bumpTrigger) {
					player.leftBumping = false;
					bumpTrigger = false;
				}
			}
			if (loadedLevel.ground.hitTestPoint(player.x + player.width / 3, player.y - player.height / 3, true)) {
				player.rightBumping = true;
				rBumpTrigger = true;
			} else {
				if (rBumpTrigger) {
					player.rightBumping = false;
					rBumpTrigger = false;
				}
			}
			if (loadedLevel.ground.hitTestPoint(player.x, player.y - player.height, true)) {
				player.upBumping = true;
			} else {
				player.upBumping = false;
			}
		}
		
		public function changeStage(lvl: int, extra: int = 0): void {
			//unload level if stored
			if (loadedLevel) {
				loadedLevel.removeChildren();
				removeChild(loadedLevel);
				loadedLevel = null;
			}
			//change all values to default
			defaultValues();
			currentStage = lvl;
			//change settings based on level
			//consider altering this in level classes
			switch (lvl) {
				case 0: //zoo dawn
					loadedLevel = new Level1(true);
					Main.para.change("zoo");
					Main.bg.change("dawn");
					Main.panda.positions(300, 520);
					break;
				case 1: //zoo morning
					loadedLevel = new Level1;
					Main.para.change("zoo");
					Main.bg.change("morning");
					Mixer.play.BG(1);
					if (extra == 1) {
						Main.panda.positions(840, 520);
						positions(-6800, 0);
					}
					break;
				case 2: //bar
					loadedLevel = new Level2;
					Main.para.change("night");
					Main.bg.change("night");
					Main.fg.change("downtown");
					Mixer.play.BG(2);
					if (extra == 1) {
						Main.panda.positions(350, 500);
						positions(-14051, 0);
					} else if (extra == 2) {
						Main.panda.positions(835, 234);
						positions(-12249, 464);
					} else {
						Main.panda.positions(100, 520);
					}
					break;
				case 6: //osaki house
					loadedLevel = new Level2Extra;
					Main.panda.positions(100, 500);
					positions(0, 0);
					break;
				case 4: // winterland
					loadedLevel = new Level4;
					Mixer.play.BG(6);
					Main.para.change("snow");
					Main.bg.change("morning");
					Main.snowing.visible = true;
					Main.panda.changeClothes("winter");
					Main.panda.positions(450, 500);
					positions(-800, 0);
					break;
				case 5: //train
					loadedLevel = new Train(Progression.flag.trainDone);
					Main.panda.halt();
					Main.panda.visible = false;
					Mixer.play.BG(3);
					break;
				case 7: // mount luna
					loadedLevel = new Level5;
					Main.para.change("luna");
					Main.bg.change("morning");
					break;
				case 8: // winterland cabin and station
					if (extra == 1) { //station
						loadedLevel = new Level4Extra(false);
						Main.panda.positions(1000, 540);
						positions(-2074, 0);
					}
					else if (extra == 2) { //cabin
						loadedLevel = new Level4Extra(false);
						Main.panda.positions(400, 540);
						positions(-4020, 0);
					} else {
						loadedLevel = new Level4Extra(true);
						Main.panda.positions(400, 520);
						positions(-1000, 0);
					}
					Main.panda.changeClothes("winter");
					Mixer.play.BG(6);
					Main.bg.change("morning");
					Main.para.change("snow");
			}
			addChild(loadedLevel);
		}
		private function defaultValues(): void {
			Main.panda.makeSafe(true);
			Main.panda.resume();
			Main.panda.visible = true;
			Main.panda.riding = false;
			Main.panda.normal();
			Main.panda.positions(200, 400);
			Main.panda.changeClothes("normal");
			positions(0, 0);
			Main.fg.change("empty");
			Main.snowing.visible = false;
		}
		public function positions(_x: int, _y: int): void {
			this.x = _x;
			this.y = _y;
		}
		//gets
		public function get getStage(): int {
			return currentStage;
		}
		public function get getX(): int {
			return x;
		}
		public function get getY(): int {
			return y;
		}
	}
}