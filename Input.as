package  {
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;
	
	public class Input extends Sprite{
		
		protected var leftPressed: Boolean = false;
		protected var rightPressed: Boolean = false;
		protected var upPressed: Boolean = false;
		protected var downPressed: Boolean = false;
		protected var spacePressed: Boolean = false;
		protected var enterPressed: Boolean = false;
		protected var mPressed: Boolean = false;
		protected var iPressed: Boolean = false;

		public function Input() {
			addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		protected function start(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, start);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
		}
		
		function keyDownHandler(e: KeyboardEvent) {
			switch (e.keyCode) {
				case Keyboard.SPACE:
					spacePressed = true;
					break;

				case Keyboard.LEFT:
					leftPressed = true;
					break;

				case Keyboard.A:
					leftPressed = true;
					break;

				case Keyboard.UP:
					upPressed = true;
					break;

				case Keyboard.W:
					upPressed = true;
					break;

				case Keyboard.RIGHT:
					rightPressed = true;
					break;

				case Keyboard.D:
					rightPressed = true;
					break;

				case Keyboard.DOWN:
					downPressed = true;
					break;

				case Keyboard.S:
					downPressed = true;
					break;
				case Keyboard.ENTER:
					enterPressed = true;
					break;
				case Keyboard.I:
					iPressed = true
					break;
				case Keyboard.M:
					mPressed = true
			}
		}
		
		function keyUpHandler(e: KeyboardEvent) {
			switch (e.keyCode) {
				case Keyboard.SPACE: //space
					spacePressed = false;
					break;
				case Keyboard.LEFT:
					leftPressed = false;
					break;
				case Keyboard.A:
					leftPressed = false;
					break;
				case Keyboard.UP:
					upPressed = false;
					break;
				case Keyboard.W:
					upPressed = false;
					break;
				case Keyboard.RIGHT:
					rightPressed = false;
					break;
				case Keyboard.D:
					rightPressed = false;
					break;
				case Keyboard.DOWN:
					downPressed = false;
					break;
				case Keyboard.S:
					downPressed = false;
					break;
				case Keyboard.I:
					iPressed = false
					break;
				case Keyboard.M:
					mPressed = false
					break;
				case Keyboard.ENTER:
					enterPressed = false
					break;
			}
		}
		
		//Get functions
		
		public function get up():Boolean
		{
			return upPressed;
		}
		public function get down():Boolean
		{
			return downPressed;
		}
		public function get left():Boolean
		{
			return leftPressed;
		}
		public function get right():Boolean
		{
			return rightPressed;
		}
		public function get space():Boolean
		{
			return spacePressed;
		}
		public function get keyEnter():Boolean
		{
			return enterPressed;
		}
		public function get i():Boolean
		{
			return iPressed;
		}
		public function get m():Boolean
		{
			return mPressed;
		}
		
		
	}	
}
