package {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;


	public class waffleGame extends MovieClip {

		private var ironState: String = "start";
		private var scoopState: String = "full";
		private var bound: Rectangle;
		private var timer: int = 0;
		var m = MovieClip(root);

		public function waffleGame() {
			bound = new Rectangle(100, 180, 400, 80);

			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			iron.gotoAndStop("done");

			ose.hitbox.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			iron.addEventListener(MouseEvent.MOUSE_DOWN, ironClick);
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
		}

		function gameLoop(e: Event): void {
			if (ironState == "open") {
				if (ose.scoop.hitTestObject(pour) && scoopState == "full") {
					ose.gotoAndPlay("pour");
					scoopState = "pouring"
				}
			}
			if (ose.currentLabel == "empty" && ironState == "open") {
				iron.gotoAndStop("batter");
				ironState = "batter";
			}

			trace(timer, ironState);

			if (timer > 0) {
				timer--;
			}

			if (ironState == "closed" && timer < 300 && timer > 250) {
				ironState = "good";
				iron.gotoAndStop("done");
			}
			if (ironState == "good" && timer < 250) {
				ironState = "burnt";
			}


		}

		function startDragging(event: MouseEvent): void {
			ose.startDrag(false, bound);
		}

		function stopDragging(event: MouseEvent): void {
			ose.stopDrag();
			ose.gotoAndStop("full");
			scoopState = "full"
			ose.x = 150
			ose.y = 300
		}
		function ironClick(event: MouseEvent): void {
			if (ironState == "start") {
				iron.gotoAndStop("open");
				ironState = "open";
				trace("why");
			} else if (ironState == "open") {
				iron.gotoAndStop("done");
				ironState = "start";
				trace("close");
			} else if (ironState == "batter") {
				iron.gotoAndStop("closed");
				ironState = "closed";
				trace("closed");
				timer = 400;
			} else if (ironState == "closed") {
				iron.gotoAndStop("raw");
				ironState = "finish";
				timer = 0;
			} else if (ironState == "good") {
				iron.gotoAndStop("good");
				ironState = "success";
				timer = 0;
			} else if (ironState == "burnt") {
				iron.gotoAndStop("burnt");
				ironState = "finish";
			} else if (ironState == "finish") {
				iron.gotoAndStop("open");
				ironState = "open";
				waffle(false);
			} else if (ironState == "success") {
				iron.gotoAndStop("open");
				ironState = "open";
				waffle(true);
			}

		}
		function waffle(success: Boolean = false): void {
			if (success) {
				m = MovieClip(root);
				result.gotoAndPlay("success");
				m.waffleSuccess = true;
			} else {
				result.gotoAndPlay("fail");
			}

		}
		function removeSelf(event: MouseEvent): void {
			m = MovieClip(root);
			m.waffling = false;
			m.paused = false;
			removeEventListener(Event.ENTER_FRAME, gameLoop);
			this.parent.removeChild(this);
		}

	}

}