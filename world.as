package {


	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.*;

	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;


	public class world extends MovieClip {
		var rotationspeed: Number = 2;
		var leftPressed, rightPressed, transfer: Boolean = false;
		var mainTimeLine = MovieClip(root);
		var levelselect: Number = 1;



		public function world() {
			this.addEventListener(Event.ENTER_FRAME, upDate);

		}
		function gotoLevel(level: Number, other: String = null) {
			if (Main.transfer) {
				mainTimeLine.worldmap = false;
				mainTimeLine.removecs();
				mainTimeLine.newStage(level, other);
			}

		}



		function upDate(e: Event): void {

			if (mainTimeLine.worldmap) {

				if (mainTimeLine.snowmanComplete) {
					map.snowcomplete.visible = true;
				} else {
					map.snowcomplete.visible = false;
				}



				if (map.world1hb.hitTestObject(panda)) {
					worldtext.text = "The Bar";
					levelselect = 1;
					gotoLevel(levelselect);
				} else if (map.downtown.hitTestObject(panda)) {
					worldtext.text = "Downtown";
					levelselect = 6;
					gotoLevel(levelselect);
				} else if (map.station.hitTestObject(panda)) {
					worldtext.text = "Winterland";
					levelselect = 4;
					gotoLevel(levelselect);

				} else if (map.world2hb.hitTestObject(panda)) {
					worldtext.text = "The Zoo";
					levelselect = 2;
					gotoLevel(levelselect);
				} else if (map.world3hb.hitTestObject(panda)) {
					worldtext.text = "???";
					levelselect = 3;
					gotoLevel(levelselect);
				/*} else if (map.world4hb.hitTestObject(panda)) {
					worldtext.text = "WinterLand";
					levelselect = 4;
					gotoLevel(levelselect);*/
				} else if (map.cabin.hitTestObject(panda) && mainTimeLine.cabinOpen) {
					worldtext.text = "Cabin";
					levelselect = 4;
					gotoLevel(levelselect, "cabin inside");
				} else {
					worldtext.text = "";
				}

				if (Main.leftPressed) {
					map.rotation += rotationspeed;
					panda.scaleX = 1;
				}
				if (Main.rightPressed) {
					map.rotation -= rotationspeed;
					panda.scaleX = -1;
				}

				//hitbox
			}

		}

	}

}