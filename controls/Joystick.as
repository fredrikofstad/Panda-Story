package controls {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	import JoystickKnob;

	public class Joystick extends MovieClip {
		private var my_x: Number;
		private var my_y: Number;
		public var upAble: Boolean = false;
		private var moving: Boolean = false;

		public var newxy: Array;


		private var knob: JoystickKnob;
		var m = MovieClip(root);


		public function Joystick(margin_left: Number, margin_bottom: Number) { //pls work

			my_x = margin_left;
			my_y = margin_bottom;

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

			this.x = my_x + this.width / 2;
			this.y = stage.stageHeight - my_y - this.height / 2;

			knob = new JoystickKnob();
			knob.x = 0;
			knob.y = 0;

			knob.origin_x = 0;
			knob.origin_y = 0;

			addChild(knob);

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			this.addEventListener(MouseEvent.MOUSE_DOWN, snapKnob);
			knob.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);

			knob.buttonMode = true;
		}
		public function moveJoy() {
			moving = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}
		public function moveJoyDone() {
			moving = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			this.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}


		function startDragging(event: MouseEvent): void {
			this.startDrag();
		}

		function stopDragging(event: MouseEvent): void {
			this.stopDrag();
		}

		private function snapKnob(event: MouseEvent): void {
			knob.x = this.mouseX;
			knob.y = this.mouseY;
			mouseDown(null);
		}

		private function mouseDown(event: MouseEvent): void {

			this.addEventListener(Event.ENTER_FRAME, knobMoved);
			if (!moving) {
				knob.startDrag(false, new Rectangle(-this.width / 2, -this.height / 2, this.width, this.height));
			}
		}
		public function disableUp(): void {
			upAble = false;
		}

		public function activateUp(): void {
			upAble = true;
		}


		private function knobMoved(event: Event): void {
			// LEFT OR RIGHT
			if (knob.x > 20) {
				Main.rightPressed = true;
				Main.leftPressed = false;
			} else if (knob.x < -20) {
				Main.leftPressed = true;
				Main.rightPressed = false;
			} else {
				Main.rightPressed = false;
				Main.leftPressed = false;
			}

			// UP OR DOWN
			if (knob.y > 20) {
				Main.downPressed = true;
				Main.upPressed = false;
			} else if (knob.y < -20 && upAble) {
				Main.downPressed = false;
				Main.upPressed = true;
			} else {
				Main.downPressed = false;
				Main.upPressed = false;
			}
		}

		private function mouseReleased(event: MouseEvent): void {
			knob.stopDrag();

			knob.x = knob.origin_x
			knob.y = knob.origin_y;

			Main.leftPressed = false;
			Main.upPressed = false;
			Main.rightPressed = false;
			Main.downPressed = false;

			if (this.hasEventListener(Event.ENTER_FRAME)) {
				this.removeEventListener(Event.ENTER_FRAME, knobMoved);
			}

		}

	}
}