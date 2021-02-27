package {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class SliceGame extends MovieClip {
		
		var m = MovieClip(root);
		
		private var bound: Rectangle;
		var skive: BrunOstSkive = new BrunOstSkive;
		var skiveEvent: Boolean = false;
		var successY: Number = 225;
		var maxY: Number = 60;
		var sliceCount: Number = 1;

		public function SliceGame() {
			bound = new Rectangle(0, 0, 600, 500);
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
			hovel.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			startPoint.gotoAndStop("start");
			marker.gotoAndStop(1);
		}
		function gameLoop(e: Event): void {
			
			trace(hovel.y);
			
			if (plate.currentFrame < 9) {
				plate.gotoAndStop(sliceCount);
			} else {
				success();
			}

			if (skiveEvent) {
				if(hovel.y < maxY){
					hovel.y = maxY;
				}
				skive.x = hovel.x;
				skive.y = hovel.y;
				skive.height = hovel.y - startPoint.y;
				if (startPoint.y > hovel.y) {
					skive.height = 10;
				}
				if (!hovel.hitbox.hitTestObject(brunost.hitbox)) {
					loseGame();
					marker.gotoAndStop("batsu");
					marker.batsu.gotoAndPlay(2);
				}

				if (hovel.y > successY) {
					skive.gotoAndStop("done");
					skiveEvent = false;
					startPoint.gotoAndStop("start");
					marker.gotoAndStop("maru");
					marker.maru.gotoAndPlay(2);
					sliceCount++;

				}
			}
			if (!skiveEvent) {
				if (startPoint.hitbox.hitTestObject(hovel.hitbox)) {
					startSlice();
				}
			}
		}
		function startSlice(): void {
			startPoint.gotoAndStop("arrow");
			addChild(skive);
			skive.gotoAndStop("start");
			skiveEvent = true;
		}
		function loseGame(): void {
			skiveEvent = false;
			startPoint.gotoAndStop("start");
			skive.gotoAndStop("done");
		}
		function startDragging(event: MouseEvent): void {
			hovel.startDrag(false, bound);
		}

		function stopDragging(event: MouseEvent): void {
			hovel.stopDrag();
		}
		function success(): void {
			m = MovieClip(root);
			result.gotoAndStop("success");
			m.brunSuccess = true;
		}
		function removeSelf(event: MouseEvent): void {
			m = MovieClip(root);
			m.bruning = false;
			m.paused = false;
			removeEventListener(Event.ENTER_FRAME, gameLoop);
			this.parent.removeChild(this);
		}


	}

}