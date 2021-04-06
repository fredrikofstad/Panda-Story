package MiniGame {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ValveGame extends MiniGame {


		private var bound: Rectangle;

		var score: Number;
		var positive: Boolean;
		var open: Boolean;

		public function ValveGame() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			level = (parent as MovieClip);
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownF, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpF, false, 0, true);
			furnace.gotoAndStop("closed");
			result.gotoAndStop("normal");
			valve.visible = true;
			score = 0;
			positive = false;
			open = false;


		}
		function gameLoop(e: Event): void {

			if (open) {
				furnace.gotoAndStop("open");
			} else {
				furnace.gotoAndStop("closed");
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
					valve.visible = false;
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
			angle = angle * 180 / Math.PI - 90; //convert to degree, is it pedantic to use tau?
			valve.rotation = angle; //rotate
		}
		public function mouseUpF(e: MouseEvent): void {
			removeEventListener(MouseEvent.MOUSE_MOVE, rotate);
		}


		function success(): void {
			result.gotoAndStop("success");
			level.valveSuccess = true;
			level.holdItem = null;
		}
		function removeSelf(event: MouseEvent): void {
			removeEventListener(Event.ENTER_FRAME, gameLoop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, rotate);
			quit();
		}



	}

}