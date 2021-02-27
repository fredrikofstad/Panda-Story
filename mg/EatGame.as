package {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;


	public class EatGame extends MovieClip {

		var m = MovieClip(root);
		var waffleCounter: int = 0;

		public function EatGame() {

			this.addEventListener(Event.ENTER_FRAME, gameLoop);

			w1.addEventListener(MouseEvent.MOUSE_UP, e1);
			w2.addEventListener(MouseEvent.MOUSE_UP, e2);
			w3.addEventListener(MouseEvent.MOUSE_UP, e3);
			w4.addEventListener(MouseEvent.MOUSE_UP, e4);
			w5.addEventListener(MouseEvent.MOUSE_UP, e5);
			w6.addEventListener(MouseEvent.MOUSE_UP, e6);
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
		}

		function gameLoop(e: Event): void {
			if (waffleCounter > 5) {
				success();
			}
		}
		function e1(event: MouseEvent): void {
			w1.gotoAndPlay(2);
			waffleCounter++
			w1.removeEventListener(MouseEvent.MOUSE_UP, e1);
		}
		function e2(event: MouseEvent): void {
			w2.gotoAndPlay(2);
			waffleCounter++
			w2.removeEventListener(MouseEvent.MOUSE_UP, e2);
		}
		function e3(event: MouseEvent): void {
			w3.gotoAndPlay(2);
			waffleCounter++
			w3.removeEventListener(MouseEvent.MOUSE_UP, e3);
		}
		function e4(event: MouseEvent): void {
			w4.gotoAndPlay(2);
			waffleCounter++
			w4.removeEventListener(MouseEvent.MOUSE_UP, e4);
		}
		function e5(event: MouseEvent): void {
			w5.gotoAndPlay(2);
			waffleCounter++
			w5.removeEventListener(MouseEvent.MOUSE_UP, e5);
		}
		function e6(event: MouseEvent): void {
			w6.gotoAndPlay(2);
			waffleCounter++
			w6.removeEventListener(MouseEvent.MOUSE_UP, e6);
		}


		function success(): void {
			m = MovieClip(root);
			result.gotoAndPlay("success");
			m.eatSuccess = true;

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