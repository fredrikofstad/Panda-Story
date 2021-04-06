package  {
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;
	
	public class Input extends Sprite{
		
		static var leftPressed: Boolean = false;
		static var rightPressed: Boolean = false;
		static var upPressed: Boolean = false;
		static var downPressed: Boolean = false;
		static var spacePressed: Boolean = false;
		static var enterPressed: Boolean = false;
		static var mPressed: Boolean = false;
		static var iPressed: Boolean = false;

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
		
		public static function get up():Boolean
		{
			return upPressed;
		}
		public static function get down():Boolean
		{
			return downPressed;
		}
		public static function get left():Boolean
		{
			return leftPressed;
		}
		public static function get right():Boolean
		{
			return rightPressed;
		}
		public static function get space():Boolean
		{
			return spacePressed;
		}
		public static function get keyEnter():Boolean
		{
			return enterPressed;
		}
		public static function get i():Boolean
		{
			return iPressed;
		}
		public static function get m():Boolean
		{
			return mPressed;
		}
		
		
	}	
}
