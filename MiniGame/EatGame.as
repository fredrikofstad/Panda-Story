package MiniGame {

	import flash.events.*;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;


	public class EatGame extends MiniGame {

		var waffleCounter: int = 0;
		var waffles: Array;

		public function EatGame() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		function init(e: Event): void {
			
			level = (parent as MovieClip);

			this.addEventListener(Event.ENTER_FRAME, loop);
			
			waffles = [w1, w2, w3, w4, w5, w6];
			
			result.gotoAndStop("normal");

			for (var i: int = 0; i < waffles.length; i++) 
			{
				waffles[i].gotoAndStop(1);
				waffles[i].addEventListener(MouseEvent.MOUSE_UP, eat); 
			}
			
			close.addEventListener(MouseEvent.MOUSE_UP, removeSelf);
		}

		function loop(e: Event): void {
			if (waffleCounter > 5) {
				success();
			}
		}
		
		function eat(e:MouseEvent):void {
			e.currentTarget.gotoAndPlay(2);
			waffleCounter++
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, eat);
		}
		

		function success(): void {
			result.gotoAndStop("success");
			level.holdItem = "wash";

		}
		function removeSelf(event: MouseEvent): void {
			quit();
			removeEventListener(Event.ENTER_FRAME, loop);
		}

	}

}