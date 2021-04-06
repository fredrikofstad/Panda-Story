﻿package {

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
		private var lvl4s: Level4Station;
		private var lvl4: Level4;
		private var lv5: Level5;


		private var trainDone: Boolean = false;


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
			trace("start of changeStage");
			if (loadedLevel) {
				loadedLevel.removeChildren();
				removeChild(loadedLevel);
				loadedLevel = null;
			}
			Main.panda.makeSafe(true);
			Main.panda.normal();
			Main.panda.resume();
			Main.panda.positions(200, 400);
			positions(0, 0);
			Main.fg.change("empty");
			snowing = false;
			currentStage = lvl;
			switch (lvl) {
				case 0:
					trace("level 0 loaded");
					lvl1 = new Level1(true);
					loadedLevel = lvl1;
					addChild(lvl1);
					Main.para.change("zoo");
					Main.bg.change("dawn");
					Main.panda.positions(300, 520);
					break;
				case 1:
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
					lvl2 = new Level2;
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
				case 6:
					lvl2e = new Level2Extra;
					loadedLevel = lvl2e;
					addChild(lvl2e);
					Main.panda.positions(100, 500);
					positions(0, 0);
					break;
				case 4:
					Main.panda.resume();
					Main.panda.visible = true;
					lvl4 = new Level4;
					loadedLevel = lvl4;
					addChild(lvl4);
					snowing = true;
					Main.para.change("snow");
					Main.bg.change("morning");
					Main.snowing.visible = true;
					Main.panda.positions(100, 500);
					positions(0, 0);
					break;
				case 5:
					Main.panda.halt();
					Main.panda.visible = false;
					train = new Train(trainDone);
					loadedLevel = train;
					addChild(train);
					break;
				case 7:
					lv5 = new Level5;
					loadedLevel = lv5;
					addChild(lv5);
					Main.para.change("luna");
					Main.bg.change("morning");
					
					break;
			}
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