package {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ValveGame extends MovieClip {

		var m = MovieClip(root);

		private var bound: Rectangle;

		var score: Number = 0;
		var positive: Boolean = false;
		var open: Boolean = false;

		public function ValveGame() {
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownF, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpF, false, 0, true);


		}
		function gameLoop(e: Event): void {
			trace(positive, score, valve.rotation);

			if (open) {
				furnace.gotoAndStop("open");
			} else {
				furnace.gotoAndStop("closed");
			}
			if (!open) {
				if (positive) {
					if (valve.rotation > 0 && valve.rotation < 20) {
						score++
						positive = false;
					}
				} else {
					if (valve.rotation > 160 && valve.rotation < 180) {
						score++
						positive = true;
					}
				}
				if (score > 7) {
					removeChild(valve);
					open = true;
					success();
				}
			}


		}

		public function mouseDownF(e: MouseEvent): void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, rotate, false, 0, true);
		}
		public function rotate(e: MouseEvent): void {
			var angle: Number = Math.atan2(mouseY - valve.y, mouseX - valve.x); //get angle in radians 

			angle = angle * 180 / Math.PI - 90; //convert to degrees

			valve.rotation = angle; //rotate
		}
		public function mouseUpF(e: MouseEvent): void {
			removeEventListener(MouseEvent.MOUSE_MOVE, rotate);
		}


		function success(): void {
			m = MovieClip(root);
			result.gotoAndStop("success");
			m.valveSuccess = true;
		}
		function removeSelf(event: MouseEvent): void {
			m = MovieClip(root);
			m.paused = false;
			m.waffling = false;
			removeEventListener(Event.ENTER_FRAME, gameLoop);
			this.parent.removeChild(this);
		}



	}

}