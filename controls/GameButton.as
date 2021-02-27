package controls {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class GameButton extends MovieClip {
		private var my_x: Number;
		private var my_y: Number;
		private var my_action: Boolean;
		private var _main: Main;
		private var drag: Boolean = false;


		public function GameButton(main: Main, margin_left: Number, margin_bottom: Number, action: Boolean = true) {

			_main = main;
			my_x = margin_left;
			my_y = margin_bottom;
			my_action = action;

			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}

		}

		private function init(e: Event = null): void {
			if (hasEventListener(Event.ADDED_TO_STAGE)) {
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}

			this.x = stage.stageWidth - my_x - this.width / 2;
			this.y = stage.stageHeight - my_y - this.height / 2;

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			this.addEventListener(TouchEvent.TOUCH_BEGIN, Press);
			stage.addEventListener(TouchEvent.TOUCH_END, Release);

		}

		/*public function moveBtn() {
			this.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}*/

		private function Press(event: TouchEvent): void {
			if (!drag) {
				if (my_action) {
					_main.space();
				} else {
					Main.upPressed = true;
				}
			}
		}
		private function Release(event: TouchEvent): void {
			if (my_action) {
				_main.spaceUp();
			} else {
				Main.upPressed = false;
			}
		}

	}

}