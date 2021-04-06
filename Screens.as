package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.SharedObject;
	import flash.ui.*;


	public class Screens extends MovieClip {

		private var selectorUp = true;
		private var so: SharedObject = SharedObject.getLocal("panda");


		public function Screens() {
			changeScreens("start")
			Mouse.hide();
		}

		function loop(e: Event) {
			if (currentLabel == "start") {
				if (selectorUp) {
					selector.gotoAndStop(1);
					if (Input.down) {
						selectorUp = false;
					}
					if (Input.space) {
						dostart2();
					}
				} else {
					selector.gotoAndStop(2);
					if (Input.up) {
						selectorUp = true;
					}
					if (Input.space) {
						doload2();
					}
				}
			} else if (currentLabel == "intro") {
				if (intro.currentLabel == "done") {
					Main.level.changeStage(0);
					changeScreens("normal");
				}
			}
		}



		public function changeScreens(screen: String): void {
			/*
			For game over screen
			continue_button.removeEventListener(MouseEvent.CLICK, docontinue);
			save_and_quit_button.removeEventListener(MouseEvent.CLICK, dosavequit);*/

			gotoAndStop(screen);
			switch (screen) {
				case "map":
					world.start();
					break;
				case "start":
					start_button.addEventListener(MouseEvent.CLICK, dostart);
					load_button.addEventListener(MouseEvent.CLICK, doload);
					addEventListener(Event.ENTER_FRAME, loop);
					//Mouse.hide();
					break;
				case "gameover":
					continue_button.addEventListener(MouseEvent.CLICK, docontinue);
					save_and_quit_button.addEventListener(MouseEvent.CLICK, dosavequit);
					break;
				case "normal":
					removeEventListener(Event.ENTER_FRAME, loop);
					break;
			}

		}
		//start
		function dostart(e: MouseEvent): void {
			dostart2()
		}
		function dostart2(): void {
			//maybe initialize?
			changeScreens("intro");
			Mouse.show();
		}
		function doload(e: MouseEvent): void {
			doload2()
		}

		function doload2(): void {
			if (so.data.coins) { //implement load and startup
				Mouse.show();
				Data.loadGame();
				Main.panda.reset();
				changeScreens("normal");
				Main.level.changeStage(so.data.currentStage);
			} else {
				Mixer.play.FX("hurt");
			}
		}
		//game over
		function docontinue(e: MouseEvent): void {
			Main.panda.reset();
			changeScreens("normal");
			//reset positions??
		}
		function dosavequit(e: MouseEvent): void {
			//saveGame(); //implement save game
			//quitGame() //exit I guess, nativeapplication
		}

	}

}