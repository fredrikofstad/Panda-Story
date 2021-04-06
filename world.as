package {
	import flash.display.MovieClip;
	import flash.events.*;

	public class World extends MovieClip {
		private var rotationspeed: int = 2;
		private var levelselect: int = 1;

		public function World() {}
		public function start(): void {
			this.addEventListener(Event.ENTER_FRAME, loop);
			Main.paused = true;
			Main.panda.halt();
		}
		function gotoLevel(level: Number, other: int = 0) {
			if (Main.key.space) {
				Main.level.changeStage(levelselect, other);
				Main.screen.changeScreens("normal");
				removeEventListener(Event.ENTER_FRAME, loop);
				Main.paused = false;

			}

		}
		function loop(e: Event): void {

			/*
			if (mainTimeLine.snowmanComplete) {
				map.snowcomplete.visible = true;
			} else {
				map.snowcomplete.visible = false;
			}*/
			if (map.world1hb.hitTestObject(panda)) {
				worldtext.text = "The Bar";
				levelselect = 2;
				gotoLevel(levelselect);
			} else if (map.downtown.hitTestObject(panda)) {
				worldtext.text = "Downtown";
				levelselect = 2;
				gotoLevel(levelselect, 1);
			} else if (map.station.hitTestObject(panda)) {
				worldtext.text = "Winterland";
				levelselect = 4;
				gotoLevel(levelselect);

			} else if (map.world2hb.hitTestObject(panda)) {
				worldtext.text = "The Zoo";
				levelselect = 1;
				gotoLevel(levelselect);
			} else if (map.world3hb.hitTestObject(panda)) {
				worldtext.text = "Train";
				levelselect = 5;
				gotoLevel(levelselect);
			} else if (map.cabin.hitTestObject(panda)) { //check if open
				worldtext.text = "Cabin";
				//levelselect = 4;
				//gotoLevel(levelselect, 1);
			} else if (map.luna.hitTestObject(panda)) { //check if open
				worldtext.text = "Mount Luna";
				levelselect = 7;
				gotoLevel(levelselect);
			} else {
				worldtext.text = "";
			}

			if (Main.key.left) {
				map.rotation += rotationspeed;
				panda.scaleX = 1;
			}
			if (Main.key.right) {
				map.rotation -= rotationspeed;
				panda.scaleX = -1;
			}

		}
	}
}