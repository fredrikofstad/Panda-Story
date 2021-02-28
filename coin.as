package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;

	import flash.media.Sound;
	public class Coin extends MovieClip {
		var player: MovieClip;
		var mainTimeLine = MovieClip(root);
		var coinValue: int = 1;
		var coinstaken: Array;

		var coinsound: Sound = new mySound();
		public function Coin() { 
			this.addEventListener(Event.ENTER_FRAME, upDate);

			if (this.name == "key") {
				this.gotoAndStop("key");
			} else if (this.name == "bamboo") {
				this.gotoAndStop("bamboo");
			} else if (this.name == "meat") {
				this.gotoAndStop("meat");
			} else if (this.name.indexOf("heart") >= 0) {
				this.gotoAndStop("heart");
			} else {
				this.gotoAndStop("coin");
			}
		}
		function upDate(e: Event): void {
			mainTimeLine = MovieClip(root);
			player = mainTimeLine.player;

			if (mainTimeLine.coinstaken.indexOf(this.name) > -1) {
				this.removeEventListener(Event.ENTER_FRAME, upDate);
				this.visible = false;
			}

			if (this.hitTestObject(player.hitbox)) {
				this.removeEventListener(Event.ENTER_FRAME, upDate);
				this.visible = false;
				coinsound.play();
				if (this.name.indexOf("heart") == -1) {
					mainTimeLine.coinstaken.push(this.name);
					trace(mainTimeLine.coinstaken);
				}
				if (this.currentLabel == "coin") {
					mainTimeLine.coinCount += coinValue;
				} else if (this.currentLabel == "heart") {
					mainTimeLine.hp += 1;
				} else if (this.currentLabel == "key") {
					mainTimeLine.gotItem("key");
				} else if (this.currentLabel == "bamboo") {
					mainTimeLine.gotItem("bamboo");
					mainTimeLine.hasBamboo = true;
				} else if (this.currentLabel == "meat") {
					mainTimeLine.gotItem("meat");
				}
			}
		}
	}
}