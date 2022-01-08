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
		private var lvl1: Level1;
		private var lvl2: Level2;
		private var lvl2e: Level2Extra;
		private var train: Train; //level3
		private var lvl4: Level4;
		private var lvl4e: Level4Extra;
		private var lv5: Level5;


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
			if (snowing) {
				Main.snowing.visible = true;
			} else {
				Main.snowing.visible = false;
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
			if (loadedLevel) {
				loadedLevel.removeChildren();
				removeChild(loadedLevel);
				loadedLevel = null;
			}
			defaultValues();
			currentStage = lvl;
			switch (lvl) {
				case 0: //zoo dawn
					trace("level 0 loaded");
					lvl1 = new Level1(true);
					loadedLevel = lvl1;
					addChild(lvl1);
					Main.para.change("zoo");
					Main.bg.change("dawn");
					Main.panda.positions(300, 520);
					break;
				case 1: //zoo morning
					lvl1 = new Level1;
					loadedLevel = lvl1;
					addChild(lvl1);
					Main.para.change("zoo");
					Main.bg.change("morning");
					Mixer.play.BG(1);
					if (extra == 1) {
						Main.panda.positions(840, 520);
						positions(-6800, 0);
					}
					break;
				case 2:
					lvl2 = new Level2; //bar
					loadedLevel = lvl2;
					addChild(lvl2);
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
					lvl2e = new Level2Extra;
					loadedLevel = lvl2e;
					addChild(lvl2e);
					Main.panda.positions(100, 500);
					positions(0, 0);
					break;
				case 4: // winterland
					lvl4 = new Level4;
					loadedLevel = lvl4;
					addChild(lvl4);
					snowing = true;
					Mixer.play.BG(6);
					Main.para.change("snow");
					Main.bg.change("morning");
					Main.snowing.visible = true;
					Main.panda.changeClothes("winter");
					Main.panda.positions(450, 500);
					positions(-800, 0);
					break;
				case 5: //train
					train = new Train(Progression.flag.trainDone);
					loadedLevel = train;
					addChild(train);
					Main.panda.halt();
					Main.panda.visible = false;
					Mixer.play.BG(3);
					break;
				case 7: // mount luna
					lv5 = new Level5;
					loadedLevel = lv5;
					addChild(lv5);
					Main.para.change("luna");
					Main.bg.change("morning");
					break;
				case 8: // winterland cabin and station
					if (extra == 1) {
						lvl4e = new Level4Extra(false);
						Main.panda.positions(400, 520);
						positions(-1000, 0);
					}
					if (extra == 2) {
						lvl4e = new Level4Extra(false);
						Main.panda.positions(400, 520);
						positions(-1000, 0);
					} else {
						lvl4e = new Level4Extra(true);
						Main.panda.positions(400, 520);
						positions(-1000, 0);
					}
					Main.panda.changeClothes("winter");
					loadedLevel = lvl4e;
					addChild(lvl4e);
					Mixer.play.BG(6);
					Main.bg.change("morning");
					Main.para.change("snow");
			}
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
			snowing = false;
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