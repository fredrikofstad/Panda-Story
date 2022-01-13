package {

	import flash.display.*;
	import flash.media.Sound;

	public class Main extends MovieClip {

		var input: Input = new Input;
		var inventory: Inventory = new Inventory;
		var levelManager: LevelManager = new LevelManager;
		var parallax: Parallax = new Parallax(levelManager);
		var background: Background = new Background;
		var player: Player = new Player(levelManager); //panda
		var ui: UI = new UI(stage.stageHeight);
		var screens: Screens = new Screens();
		var snow: Snow = new Snow;
		var foreground: Foreground = new Foreground;
		var prog: Progression = new Progression;
		var border: Border = new Border;
		var mixer:Mixer = new Mixer;

		static var paused: Boolean = false;

		private static var _instance: Main = null;

		public function Main() {

			_instance = this;
			setUp();
		}

		private function setUp(): void {
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			addChild(input);
			addChild(inventory);
			addChild(background);
			addChild(parallax);
			addChild(levelManager);
			addChild(player);
			addChild(foreground);
			addChild(snow);
			addChild(ui);
			addChild(screens);
			addChild(border);

		}

		public static function get instance(): Main {return _instance;}
		public static function get getStage(): Stage {return instance.stage;}
		public static function get key(): Input {return instance.input;}
		public static function get i(): Inventory {return instance.inventory;}
		public static function get panda(): Player {return instance.player;}
		public static function get level(): LevelManager {return instance.levelManager;}
		public static function get u(): UI {return instance.ui;}
		public static function get screen(): Screens {return instance.screens;}
		public static function get para(): Parallax {return instance.parallax;}
		public static function get bg(): Background {return instance.background;}
		public static function get fg(): Foreground {return instance.foreground;}
		public static function get snowing(): Snow {return instance.snow;}
		public static function get isPaused(): Boolean {return paused;}

		public static function pauseGame(): void {
			paused = true;
		}
		public static function unpauseGame(): void {
			paused = false;
		}
		public function cutscene(setBool: Boolean): void {
			paused = setBool;
			ui.visible = !setBool;
			player.visible = !setBool;
		}


	}

}