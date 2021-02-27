package {


	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.system.fscommand;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;

	import flash.net.SharedObject;

	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.text.CSMSettings;
	import flash.ui.Mouse;

	import flash.geom.Point;

	import com.greensock.*;
	import com.greensock.easing.*;


	public class Main extends MovieClip {



		/*var joystick: Joystick;
		var spaceButton: GameButton;
		var upButton: GameButton;*/

		private static var _instance: Main = null;
		public static var sledscore: Number = 0;

		//	importing movieclips:

		var player: player_mc = new player_mc;
		var collisions: collisions_mc = new collisions_mc;
		var ui: ui_mc = new ui_mc;
		var cs: cutscene = new cutscene;
		var snow: Snow = new Snow;
		var t: Touch = new Touch;
		var border: Border = new Border;
		var inTrain: Boolean = false;

		//zoo
		var sadCounter: int = 0;
		var sadMode: Boolean = false;
		//snowing
		var snowing = false;
		//itembox
		var itembox1: String = "empty"
		var itembox2: String = "empty"
		var itembox3: String = "empty"
		var itembox4: String = "empty"

		//items
		var talkitem: Boolean = false;
		var talkcontent: String;
		var male: Boolean = true;


		//settings
		var startup: Boolean = true;
		var selectorUp: Boolean = true;
		//static public var movejoy: Boolean = false; //999

		//murray
		var murray: int = 0;
		//snowball

		//progress
		var snowmanComplete, cabinOpen: Boolean = false
		var overSnowball, overWheel, leftSnowball, rightSnowball, rightWheel, leftWheel: Boolean = false;
		var bulletList: Array = new Array();

		var gotitem: String;

		//quests
		var toilclear = false;
		var snowmanquest: int = 0;
		//item stuff
		var hasBamboo, hasMeat, hasKey, hasGelato: Boolean = false;
		var hasSkis: Boolean = false;
		var holding: Boolean = false;
		var holdingitem: String = "gelato";

		var worldmap, sledding, skiing, menubaropen, startscreen: Boolean = false;
		//stages
		public var currentStage: Number = 2;
		var inside: Boolean = false;

		var cut: Boolean = false;

		var hp: Number = 6;

		var pushing, wpushing, skimode: Boolean = false;

		//downtown
		var downtownInside, door: Boolean = false;
		var ready: Boolean = true;
		var time = new Date();


		//other
		public var lifeC: Number = 3;
		public var paused: Boolean = false;
		var attacking: Boolean = false;
		var talkable: Boolean = false;
		public var talking: Boolean = false;
		public static var csTalk: Boolean = false;
		public static var trainDone: Boolean = false;
		var enter: Boolean = false;
		var attack_count: Number = 0;
		var safe: Boolean = false;
		var convo: Boolean = false;

		//coin
		var coinCount: int = 0;

		//train
		var train: Train;
		public var waffling, bruning, waffleSuccess: Boolean = false;
		public var brunSuccess: Boolean = false;
		public var valveSuccess: Boolean = false;
		public var eatSuccess: Boolean = false;
		public static var asakoForgive: Boolean = false;

		//	player settings

		var player_topSpeed: Number = 10; //	This is the fastest the player will be able to go
		var player_acceleration: Number = 0.4; //	The speed that the player speeds up
		var player_friction: Number = 0.8; //	The speed that the player slows down once key is let go
		var player_1stJumpHeight: Number = -18; //	The first jump height
		var player_2ndJumpHeight: Number = -10; //	If player_doubleJump is true, this will be height of second jump
		var player_gravity: Number = 1; //	The acceleration of the fall.
		var player_maxGravity: Number = 25; //   fastest the player will be able to fall
		var player_doubleJump: Boolean = false; //	Determinds whether player will double jump or not
		var player_bounce: Boolean = false; //	Determinds whether player will bounce off the walls like a ball
		var player_bounciness: Number = -1.5; //	How bouncy the player will be if player_bounce is true
		var player_sideScrollingMode: Boolean = false; //	Determinds whether player or background moves.



		// other player variables:

		var player_currentSpeed: Number; //  To help the calculations on the speed of player
		var player_doubleJumpReady: Boolean = false;
		var player_inAir: Boolean = false;
		var player_xRight: Number = 0;
		var player_xLeft: Number = 0;
		public static var player_y: Number = 0;

		//player stuff
		var invincibilityTimeLeft: Number;
		var invicounter: Number = 40;
		var isInvincible: Boolean = false;
		var safeTimeLeft: Number;
		var safeCounter: Number = 30;
		var isSafe: Boolean = false;

		//sounds

		var bg1: Sound = new bg();
		var bg2: Sound = new pixles();
		var bg3: Sound = new winter();
		var bg4: Sound = new relax();
		var s1: Sound = new mySound();
		var warps: Sound = new warpsound();
		var talksound: Sound = new talkingsound();
		var talksound2: Sound = new talkingsound2();
		var hurt: hurtsound = new hurtsound();
		var nosound: blank = new blank();
		var sadSound: Sad = new Sad();

		var sfx: SoundChannel = new SoundChannel();

		var channel: SoundChannel = new SoundChannel();
		var soundPosition: int;
		var musicon: Boolean = true;
		var currentsong = bg1;


		//savedata
		var so: SharedObject = SharedObject.getLocal("/");

		var coinstaken: Array = [];
		var enemiestaken: Array = [];

		var fullScreen: Boolean = false;



		// collisions of the player:
		var downBumping, leftBumping, upBumping, rightBumping, underBumping: Boolean = false;



		//	keys pressed 
		public static var holditem, doneTalking, leftPressed,
			rightPressed, upPressed, downPressed, spacePressed, enterPressed, transfer: Boolean = false;
		//talking
		var Aposition: int;
		var textPosition: int;
		var speech: String;
		var speechName: String;
		var textSpeed: int = 1;
		var script: Array = new Array;
		var hurtbox = false;
		//yesno
		var ask, end: Boolean = false;
		public static var question: Boolean = false;
		var endquestion: String;
		var qyes: Boolean = true;
		public var yesnoCase: int = 0;
		var questionDone, select: Boolean = false;


		public function Main() {

			createGame();

		}

		function createGame() {
			//android controls
			/*joystick = new Joystick(30, 80); //999
			upButton = new GameButton(this, 30, 90, false);
			spaceButton = new GameButton(this, 200, 90);*/

			//android stuff
			stage.addEventListener(Event.ACTIVATE, fl_Activate);
			stage.addEventListener(Event.DEACTIVATE, fl_Deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			//Main instance
			_instance = this;

			//white noise lol
			nosound.play(0, 999);
			//adding mah children
			addChild(collisions);
			addChild(player);
			addChild(snow);
			addChild(ui);
			//addChild(joystick); //999
			//addChild(spaceButton);
			//addChild(upButton);
			positions();

			ui.x = stage.x;
			ui.y = 720;
			t.x = 0; //can't remember what this is??
			t.y = 0;
			border.x = 0;
			border.y = 0;

			//SETTINGS
			//joystick.visible = false; //999
			//spaceButton.visible = false;
			//upButton.visible = false;
			fullScreen = true;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

			playcs("start_screen");
			Mouse.hide();

			//event listeners
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);

			//ui.hearts.addEventListener(MouseEvent.CLICK, doface);
			ui.face.addEventListener(MouseEvent.CLICK, toggleScreen);

			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			t.hu.addEventListener(TouchEvent.TOUCH_BEGIN, dohu);
			t.hs.addEventListener(TouchEvent.TOUCH_BEGIN, dohs);

			//ui
			ui.wpbutton.addEventListener(MouseEvent.CLICK, dowm);
			ui.itembutton.addEventListener(MouseEvent.CLICK, doitem);
			ui.menubtn.addEventListener(MouseEvent.CLICK, domenu);


		}




		function playcs(scene: String): void {
			addChild(cs);

			cut = true;
			cs.gotoAndStop(scene);
			if (scene == "map") {
				worldmap = true;
				inside = false;
			}
			if (scene == "start_screen") {
				startscreen = true;
			}
			if (scene == "gameover") {
				startscreen = true;
			}
			joyDepth();

		}
		function joyDepth():void {
			//addChild(joystick); //999
			//addChild(spaceButton);
			//addChild(upButton);
			//addChild(border);
		}
		public function removecs(): void {
			removeChild(cs);
			if (currentStage != 5) {
				cut = false;
			}
			worldmap = false;
			startscreen = false;
		}

		//sounds
		function pause(): void {
			soundPosition = channel.position;
			channel.stop();
		}
		function resume(): void {
			if (musicon) {
				channel = currentsong.play(soundPosition);
			}
		}



		function onComplete(event: Event): void {
			channel = currentsong.play();
		}

		function positions2(location: String): void {
			player.y = stage.stageHeight / 1.8;
			skimode = false;
			door = false;
			player_xRight = 0;
			player_xLeft = 0;
			if (location == "cabin") {
				collisions.x = stage.stageWidth / 2 + 7700;
				collisions.y = stage.stageHeight / 1.2 - 100;
				player.x = 600;
				player.y += 80;
				inside = false;
				delaySafe();
				snowing = true;

			} else if (location == "cabin inside") {
				collisions.x = stage.stageWidth / 2 + 8800;
				collisions.y = 1700;
				player.x = 400;
				player.y += 30;
				inside = true;
				delaySafe();
				snowing = false;
				player.scaleX = -1;
			} else if (location == "warp") {
				collisions.x = stage.stageWidth / 2 - 6070;
				collisions.y = -1000;
				player.x = 400;
				player.y += 40;

			} else if (location == "warp2") {
				collisions.x = stage.stageWidth / 2 - 6100;
				collisions.y = stage.stageHeight / 1.2;
				player.x = 400;
				player.y += 40;

			} else if (location == "zoo") {
				collisions.x = stage.stageWidth / 2 - 1400;
				collisions.y = stage.stageHeight / 1.2 - 1600;
				player.y += 90;
				player.x = 600;
			} else if (location == "winter") { //winterland
				player.x = 400;
				player.y += 80;
				collisions.x = stage.stageWidth / 2 + 10700;
				collisions.y = stage.stageHeight / 1.2 - 100;
				snowing = true;
				inside = false;

			} else if (location == "winter2") {
				collisions.x = stage.stageWidth / 2 + 11600;
				collisions.y = 1800;
				player.x = 800;
				player.y += 75;
				inside = true;
				delaySafe();
				snowing = false;
				player.scaleX = 1;

			}
		}
		//position function
		function positions(): void {
			delaySafe();
			door = false;
			player.gotoAndStop("normal");
			player.x = 410;
			player.y = stage.stageHeight / 1.8;
			snowing = false;
			skimode = false;
			inside = false;


			if (currentStage == 1) { //bar
				collisions.x = 2400;
				collisions.y = stage.stageHeight / 1.2 - 100;
				player.y += 70;
				player.scaleX = -1;
			} else if (currentStage == 2) { //zoo
				collisions.x = stage.stageWidth / 2 + 5700;
				collisions.y = stage.stageHeight / 1.2 - 1600;
				player.y += 80;
				player.x = 400;
			} else if (currentStage == 3) {
				player.x = 800;
				collisions.x = stage.stageWidth / 2;
				collisions.y = (stage.stageHeight / 1.2) + 2500
			} else if (currentStage == 4) { //winterland
				player.x = 400;
				player.y += 80;
				collisions.x = stage.stageWidth / 2 + 10700;
				collisions.y = stage.stageHeight / 1.2 - 100;
				snowing = true;
				inside = false;
			} else if (currentStage == 5) {
				collisions.x = stage.stageWidth / 2 + 7800;
				collisions.y = stage.stageHeight / 1.2 - 100;
				player.x = 600;
				player.y += 80;
				snowing = false;
				startTrain();
			} else if (currentStage == 6) { //downtown
				collisions.x = -7600;
				collisions.y = stage.stageHeight / 1.2 - 100;
				player.y += 70;
				player.x = 400;
			} else if (currentStage == 7) { //winter station
				collisions.x = stage.stageWidth / 2 + 13000;
				collisions.y = 1800;
				player.x = 490;
				player.y += 80;
				inside = true;
				delaySafe();
				snowing = false;
				trainArrive();
				currentStage = 4;
			}






		}

		function newStage(level: Number, pos2: String = null) {
			holding = false;
			currentStage = level;
			if (pos2) {
				positions2(pos2)
			} else {
				positions();
			}
			channel.stop();
			if (currentStage == 1) {
				currentsong = bg2;
			} else if (currentStage == 2) {
				currentsong = bg4;
			} else if (currentStage == 4) {
				currentsong = bg3;
			} else {
				currentsong = bg1;
			}
			if (musicon) {
				channel = currentsong.play();
			}

		}



		public static function getInstance(): Main {
			return _instance;
		}
		public static function getStage(): Stage {
			return getInstance().stage;
		}


		//android stuff
		private function fl_Activate(event: Event = null): void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			if (!startup) {
				resume();
			}

		}

		private function fl_Deactivate(event: Event): void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			pause();
		}



		function onEnterFrameHandler(e: Event) {

			//enter frame
			//winterwonderland
			//snow


			if (snowing) {
				snow.visible = true;
			} else {
				snow.visible = false;
			}
			if (skimode) {
				player_topSpeed = 20;
				player_acceleration = 0.6;
				player_friction = 0.4
			} else {
				player_topSpeed = 10;
				player_acceleration = 0.4;
				player_friction = 0.8
			}

			if (hasSkis) {
				if (skimode) {
					collisions.skistand.gotoAndStop("empty");
				} else {
					collisions.skistand.gotoAndStop("skis");
				}
			} else {
				collisions.skistand.gotoAndStop("empty");
			}


			//Character hurt
			if (isSafe) {
				safe = true;
				safeTimeLeft--;
			}
			if (safeTimeLeft < 1) {
				safe = false;
				isSafe = false;
				safeTimeLeft = safeCounter;

			}

			if (isInvincible) {
				invincibilityTimeLeft--;
			}
			if (invincibilityTimeLeft < 1) {
				isInvincible = false;
			}
			if (hp < 1) {
				restartGame();
				hp = 6;
			}
			if (hp > 6) {
				hp = 6;
			}
			if (musicon) {
				channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
			} else {
				channel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			}

			//intro
			if (startscreen) {
				cs.start_button.addEventListener(MouseEvent.CLICK, dostart);
				cs.load_button.addEventListener(MouseEvent.CLICK, doload);
				if (selectorUp) {
					cs.selector.gotoAndStop(1);
					if (downPressed) {
						selectorUp = false;
					}
					if (transfer) {
						dostart2();
					}
				} else {
					cs.selector.gotoAndStop(2);
					if (upPressed) {
						selectorUp = true;
					}
					if (transfer) {
						doload2();
					}
				}
			}
			//gameover
			if (cs.currentLabel == "gameover") {
				cs.continue_button.addEventListener(MouseEvent.CLICK, docontinue);
				cs.save_and_quit_button.addEventListener(MouseEvent.CLICK, dosavequit);
			}


			//Talking
			csTalk = talking;

			if (talking) {
				TextField(ui.txt.getChildByName("t_name")).text = speechName;
				TextField(ui.txt.getChildByName("t_body")).text = speech.substr(0, textPosition);
				speech = script[Aposition];
				if (textPosition < speech.length) {
					doneTalking = false;
					textPosition += textSpeed;
					ui.txt.arrow.visible = false;
					if (male) {
						talksound.play();
					} else {
						talksound2.play();
					}

				} else {
					doneTalking = true;
					ui.txt.arrow.visible = true;
				}
			}
			if (question) {
				questionDone = true;
				if (qyes) {
					MovieClip(root).ui.txt.arrow.gotoAndStop("yes");
					if (rightPressed) {
						qyes = false;
					}
					if (select) {
						doYesno();
						questionDone = false;
						select = false;
						talking = false;
						question = false;
					}
				} else {
					MovieClip(root).ui.txt.arrow.gotoAndStop("no");
					if (leftPressed) {
						qyes = true;
					}
					if (select) {
						talking = false;
						question = false;
						questionDone = false;
						select = false;
					}
				}
			}

			//something with talkable...............

			//zoo
			if (currentStage == 2) {
				if (player.hitTestObject(collisions.tesla.hitbox) && talkable) {
					talk(["woff, woff!"], "Tesla", null, false);

				}
				if (sadMode) {
					player.sad.gotoAndStop("on");
				} else {
					player.sad.gotoAndStop("off");
				}
				if (collisions.z1.hitTestObject(player.hitbox) && talkable) {
					talk(["Meow! Meow!"], "Kattkatt", null, false);
				} else if (collisions.z2.hitTestObject(player.hitbox) && talkable) {
					talk(["Iri Noi ya de!"], "Iri", null, false);
				} else if (collisions.z3.hitTestObject(player.hitbox) && talkable) {
					talk(["That'll be 10btc... Oh this is your home?"], "Bill");
				}

				if (collisions.cottonmachine.hitTestObject(player.hitbox) && talkable) {
					talk(["Looks like the cotton candy is free!"]);
					holding = true;
					holdingitem = "cottoncandy";
				}


				if (collisions.cage1.hitTestObject(player.hitbox)) {
					if (!sadMode) {
						sadCounter++
					}
				} else {
					sadMode = false;
					sadCounter = 0;
				}
				if (sadCounter > 90) {
					sadMode = true;
					sadCounter = 0;
					sadSound.play();
				}

				if (collisions.door_bar.hitTestObject(player.hitbox) && !player_inAir) {
					door = true;
					//joystick.activateUp(); //999
					if (upPressed) {
						newStage(1);
						transition();
					}
				}
				if (collisions.pandacage.hitTestObject(player.hitbox)) {
					fadeOut(collisions.pandacage);
				} else {
					fadeIn(collisions.pandacage);
				}

			} //end of zoo
			//bar



			if (collisions.wheelchair.hitTestObject(player.hitbox) && talkable) {
				if (collisions.wheelchair.head) {
					talk(["Sure, just use my head as a ladder..."], "Stephen");
					collisions.wheelchair.head = false;
				} else {
					if (collisions.wheelchair.state == 1) {
						talk(["Thanks, now please give me some privacy...", "I can do the rest myself."], "Stephen");
					} else if (collisions.wheelchair.state == 2) {
						talk(["Hey man, you pushed me too far..."], "Stephen");
					} else {
						talk(["Hey, can you help push me to the toilet?"], "Stephen");
					}
				}
			}

			if (collisions.c1.hitTestObject(player.hitbox) && talkable) {
				if (hasMeat && snowmanquest < 2) {
					talk(["Yakiniku?? Gimme gimme! You can have this key I found."], "Mariya", null, false);
					remove("meat");
					talkitem = true;
					talkcontent = "key"
					hasMeat = false;
					hasKey = true;
					snowmanquest = 2;
				} else {
					talk(["Hey Sugar, what's your poison?"], "Mariya", null, false);
				}
			} else if (collisions.c2.hitTestObject(player.hitbox) && talkable) {
				talk(["Cheers! *Hiccup*"], "Old Drunk");

			} else if (collisions.c3.hitTestObject(player.hitbox) && talkable) {
				talk(["..."], "Passed out man");
			} else if (collisions.c4.hitTestObject(player.hitbox) && talkable) {
				if (hasGelato) {
					talk(["Is this icecream for me? Thanks much! "], "Sakko", null, false);
					remove("gelato");
					hasGelato = false;
					holding = false;
				} else {
					talk(["Welcome to the bar, we are still renovating", "Enjoy your stay!"], "Sakko", null, false);
				}
			} else if (collisions.c5.hitTestObject(player.hitbox) && talkable) {
				talk(["Oh my god! It's The Pixels!", "They're like totes my favorite band!"], "Fangirl", null, false);
			} else if (collisions.c6.hitTestObject(player.hitbox) && talkable) {
				talk(["Wow! That bassist is the real deal!"], "Fanboy");
			} else if (collisions.cbartender.hitTestObject(player.hitbox) && talkable) {
				talk(["I got a joke for ya, A panda walks into a bar! HAR HAR!"], "Bartender");
			} else if (collisions.cdarts.hitTestObject(player.hitbox) && talkable) {
				talk(["Doesn't seem to accept bitcoins"], "Dart Machine");
			}

			//winter stage
			if (collisions.stationWall.hitTestObject(player.hitbox)) {
				fadeOut(collisions.stationWall);
			} else {
				fadeIn(collisions.stationWall);
			}

			if (collisions.winter_train.currentLabel == "arrive") {
				transition();
				player.visible = true;
				cut = false;
				collisions.winter_train.gotoAndPlay("leave");
				//asako trigger
				trainDone = true;
			}
			if (collisions.winter_train.currentLabel == "asako") {
				if (trainDone) {
					collisions.winter_train.gotoAndPlay("panda");
				}
			}

			if (collisions.conductorW.hitTestObject(player.hitbox) && talkable) {
				talk(["Welcome to Winterland!"], "Lars");
			}

			if (snowmanComplete) {
				if (collisions.snow.hitTestObject(player.hitbox) && talkable) {
					if (!hasMeat && snowmanquest < 1) {
						talk(["Hey, thanks for making me and stuff. Here's some meat"], "Snowman", "meat");
						talkitem = true;
						hasMeat = true;
						talkcontent = "meat";
						snowmanquest = 1;
					} else {
						talk(["I'll probably melt away soon, alas such is life."], "Snowman");
					}
				}
			}
			if (collisions.l1.hitTestObject(player.hitbox) && talkable) {
				if (!toilclear) {
					talk(["Hey, no cutting in line!"], "George");
				} else {
					talk(["Oh, I don't have to go to the bathroom", "I'm just here to make friends."], "George");
				}
			}
			if (collisions.l2.hitTestObject(player.hitbox) && talkable) {
				if (!toilclear) {
					talk(["Back of the line with ya!"], "Clint");
				} else {
					talk(["We're the line gang!"], "Clint");
				}
			}
			if (collisions.l3.hitTestObject(player.hitbox) && talkable) {
				if (!toilclear) {
					talk(["This line is taking forever!"], "Old man");
				} else {
					talk(["These blokes are alright!", "The real treasure are the friends you meet in a line."], "Old man");
				}
			}


			if (collisions.p1.hitTestObject(player.hitbox) && talkable) {
				if (!skimode) {
					talk(["You're a weird looking penguin!", "You ain't got no beak!"], "Pengi");
				} else {
					talk(["Why do you have planks on your feet, Mr. No beak?", "Can't you just slide on your belly?"], "Pengi");
				}
			}
			if (collisions.p2.hitTestObject(player.hitbox) && talkable) {
				if (!skimode) {
					talk(["Sorry I can't let you pass, you'll hurt yourself!"], "Pongo");
				} else {
					talk(["Oh! With those you will be fine! Good Luck!"], "Pongo");
				}
			}

			if (collisions.s2.hitTestObject(player.hitbox) && talkable) {
				talk(["Sledding is free! The door is on the right."], "Barry");
			}
			if (collisions.s1.hitTestObject(player.hitbox) && talkable) {
				if (murray == 0) {
					talk(["Skis? You can buy a pair for 10bits. Hehe."], "Murray");
					murray = 1;
				} else if (murray == 1) {
					if (coinCount >= 10) {
						talk(["Wozah! You actually got the money, kid!"], "Murray", null, true, "Buy skiis for 10bits?");
						yesnoCase = 2;
					} else {
						talk(["10 or no deal buddy, now scram!"], "Murray");
					}
				} else if (murray == 2) {
					talk(["Skis are outside, go nuts! Hehehe"], "Murray");
				}
			}


			if (collisions.block.hitTestObject(player.hitbox)) {
				if (!skimode) {
					player.player_xRight = 0;
					player.x -= 10;
				}
			}
			if (collisions.block2.hitTestObject(player.hitbox)) {
				if (!toilclear) {
					player.player_xRight = 0;
					player.x -= 10;
				}
			}
			if (collisions.toilbarrier.hitTestObject(player.hitbox)) {
				toilclear = true;
			}



			if (collisions.skientry.hitTestObject(player.hitbox)) {
				skiStart()

			}

			if (hasSkis) {
				if (collisions.skibox.hitTestObject(player.hitbox)) {
					if (talkable) {
						if (!skimode) {
							skimode = true;
							player.x -= 15;
							player.y -= 5
							talkable = false;
							delaySafe();
						} else {
							skimode = false;
							talkable = false;
						}
					}
				}
			}

			if (collisions.door_station.hitTestObject(player.hitbox) && !player_inAir) {
				door = true;
				//joystick.activateUp(); //999
				if (upPressed) {
					positions2("winter2");
					transition();
					delaySafe();
				}
			} else {
				door = false;
			}



			if (collisions.door1.hitTestObject(player.hitbox) && !player_inAir) {
				door = true;
				//joystick.activateUp(); //999
				if (upPressed) {

					if (hasKey) {
						positions2("cabin inside");
						cabinOpen = true;
					}
				}
				if (talkable) {
					if (hasKey) {
						talk(["The door is unlocked!"], "");
					} else {
						talk(["The door is locked."], "");
					}
				}
			} else {
				door = false;
			}


			if (!talking && !question) {
				ui.txt.gotoAndStop(1);
				if (!waffling && !bruning) {
					paused = false
				}
			}

			////// DOWNTOWN //////

			if (collisions.change6.hitTestObject(player.hitbox)) {
				currentStage = 6;
			}
			if (collisions.change1.hitTestObject(player.hitbox)) {
				currentStage = 1;
			}

			if (currentStage == 6) {
				//wall in shops
				if (downtownInside) {
					if (collisions.dWall.hitTestPoint(player.x - player.width / 2, player.y - player.height / 2, true)) {
						leftWheel = true;
					} else {
						leftWheel = false;
					}

					if (collisions.dWall.hitTestPoint(player.x + player.width / 2, player.y - player.height / 2, true)) {
						rightWheel = true;
					} else {
						rightWheel = false;
					}
					if (collisions.d1.hitTestObject(player.hitbox) && talkable) {
						talk(["Irasshaimase!", "Welcome to my curry shop!"], "Kanari", null, false);
					}
					if (collisions.barrista.hitTestObject(player.hitbox) && talkable && ready) {
						talk(["Welcome, welcome!"], "Barrista", null, true, "Would you like a gelato?");
						yesnoCase = 3;

					}
					if (collisions.iceEvent.currentLabel == "done") {
						cut = false;
						ready = true;
						talkable = true;
						if (!hasGelato) {
							talk(["Enjoy"], "Barrista", "gelato");
							talkitem = true;
							hasGelato = true;
							talkcontent = "gelato";
							holdingitem = "gelato";
							holding = true;
						} else {
							talk(["You sure love icecream!"], "Barrista");
						}

					}
				}

				if (collisions.curryDoor.hitTestObject(player.hitbox) && !player_inAir) {
					door = true;
					//joystick.activateUp(); //999
					if (!downtownInside) {
						if (upPressed) {
							fadeOut(collisions.curryShop);
							downtownInside = true;
							inside = true;
							collisions.flr.mp.y -= 25;
						}
					} else {
						if (downPressed) {
							fadeIn(collisions.curryShop);
							downtownInside = false;
							inside = false;
							collisions.flr.mp.y += 25;
						}
					}

				} else {
					if (!downtownInside) {
						door = false;
					}

				}
				if (collisions.gelatoDoor.hitTestObject(player.hitbox) && !player_inAir) {
					door = true;
					//joystick.activateUp(); //999
					if (!downtownInside) {
						if (upPressed && !cut) {
							fadeOut(collisions.gelatoShop);
							downtownInside = true;
							inside = true;
							collisions.flr.mp.y -= 25;
						}
					} else {
						if (downPressed && !cut && !talking && !question) {
							fadeIn(collisions.gelatoShop);
							downtownInside = false;
							inside = false;
							collisions.flr.mp.y += 25;
						}
					}

				} else {
					if (!downtownInside) {
						door = false;
					}

				}
				if (collisions.vendingmachine.hitTestObject(player.hitbox) && talkable) {
					yesno("Get a soda bottle?");
					yesnoCase = 5;
				}

				//dparture
				time = new Date();
				var hour = time.getHours();
				var minuteI = time.getMinutes();
				var minute = String;
				if (minuteI < 10) {
					minute = String("0" + minuteI);
				} else {
					minute = minuteI;
				}
				if (hour == 23) {
					TextField(collisions.billboard.getChildByName("timeBox2")).text = 0 + ":" + "15";
				} else {
					TextField(collisions.billboard.getChildByName("timeBox2")).text = hour + 1 + ":" + "15";
				}
				TextField(collisions.billboard.getChildByName("timeBox")).text = hour + ":" + minute;





				if (collisions.dtconductor.hitTestObject(player.hitbox) && talkable) {
					talk(["All aboard!", "The train is about to depart"], "Train Conductor", null, true, "Ready to board the train?");
					yesnoCase = 1;
				}
				if (collisions.dtconductor2.hitTestObject(player.hitbox) && talkable) {
					talk(["Howdy, the train has arrived on platform 1."], "Mark");
				}
				if (collisions.dtticket1.hitTestObject(player.hitbox) && talkable) {
					talk(["The ticket system is currently out of service."], "Jack");
				}
				if (collisions.dtticket2.hitTestObject(player.hitbox) && talkable) {
					talk(["No tickets needed today."], "Sally", null, false);
				}
				if (collisions.train.currentLabel == "go") {
					player.visible = true;
					newStage(5);
				}

			} //end of downtown


			//character animation
			if (attacking && !talking && !question && !isInvincible && !holditem && !inside && !skimode && !safe) {
				player.gotoAndStop("attack");
				if (currentStage != 4 && player.player_attack.currentLabel == "attack") {
					hurtbox = true;
				} else {
					hurtbox = false;
				}
				if (currentStage == 4) {

					player.attack.gotoAndStop("winter");
					if (player.player_attack.currentFrame == 10) {
						fireBullet();
					}
					player.player_attack.visible = false;

				} else {
					player.attack.gotoAndStop("normal");
					player.player_attack.visible = true;
				}
				if (player.player_attack.currentLabel == "attack_done") {
					attacking = false;
				}
			} else if (isInvincible) {
				player.gotoAndStop("hurt");
				if (currentStage == 4) {
					player.hurt.gotoAndStop("winter");
				} else {
					player.hurt.gotoAndStop("normal");
				}
			} else if (holditem) {
				player.gotoAndStop("gotitem");
				player.itemover.gotoAndStop(gotitem);
				if (currentStage == 4) {
					player.gotitem.gotoAndStop("winter");
				} else {
					player.gotitem.gotoAndStop("normal");
				}
			} else if (pushing && !attacking && !upPressed && !skimode) {
				player.gotoAndStop("push");
			} else if (wpushing && !attacking && !upPressed) {
				player.gotoAndStop("wpush");
			} else if (skimode) {
				player.gotoAndStop("skiing");

			} else {
				player.gotoAndStop("normal");
				if (currentStage == 4) {
					player.normal.gotoAndStop("winter");

				} else if (holding) {
					player.normal.gotoAndStop("holding");
					player.normal.holding.gotoAndStop(holdingitem);
				} else {
					player.normal.gotoAndStop("normal");
				}
			}

			//collisions

			if (collisions.door_winter.hitTestObject(player.hitbox)) {
				collisions.door_winter.gotoAndStop("open");
				if (collisions.door_winter.hitbox.hitTestObject(player.hitbox)) {
					positions2("winter");
					transition();
					delaySafe();
				}
			} else {
				collisions.door_winter.gotoAndStop("closed");
			}




			if (collisions.door2.hitTestObject(player.hitbox)) {
				collisions.door2.gotoAndStop("open");
				if (collisions.door2.hitbox.hitTestObject(player.hitbox)) {
					positions2("cabin");
					transition();
					delaySafe();
				}
			} else {
				collisions.door2.gotoAndStop("closed");
			}

			if (collisions.door3.hitTestObject(player.hitbox)) {
				collisions.door3.gotoAndStop("open");
				if (collisions.door3.hitbox.hitTestObject(player.hitbox)) {
					player.x -= 50;
					playsled();
				}
			} else {
				collisions.door3.gotoAndStop("closed");
			}

			if (collisions.door4.hitTestObject(player.hitbox)) {
				collisions.door4.gotoAndStop("open");
				if (collisions.door4.hitbox.hitTestObject(player.hitbox)) {
					newStage(2, "zoo");
					transition();
				}
			} else {
				collisions.door4.gotoAndStop("closed");
			}

			if (collisions.warp1.hitTestPoint(player.x, player.y, true)) {
				if (downPressed) {
					positions2("warp");
					warps.play();
				}
			}
			if (collisions.warp2.hitTestObject(player)) {
				if (rightPressed) {
					positions2("warp2");
					warps.play();
				}
			}


			//bumping

			if (collisions.flr.hitTestPoint(player.x, player.y + 5, true)) {
				downBumping = true;
			} else {
				downBumping = false;
			}
			if (collisions.flr.hitTestPoint(player.x, player.y - 2, true)) {
				underBumping = true;
			} else {
				underBumping = false;
			}

			if (collisions.flr.hitTestPoint(player.x - player.width / 2, player.y - player.height / 2, true)) {
				leftBumping = true;
			} else {
				leftBumping = false;
			}

			if (collisions.flr.hitTestPoint(player.x + player.width / 2, player.y - player.height / 2, true)) {
				rightBumping = true;
			} else {
				rightBumping = false;
			}

			if (collisions.flr.hitTestPoint(player.x, player.y - player.height, true)) {
				upBumping = true;
			} else {
				upBumping = false;
			}

			if (collisions.restart_mc.hitTestPoint(player.x, player.y, true)) {

				restartGame();

			}
			//Snowman


			if (!snowmanComplete) {
				if (bulletList.length > 0) // if there are any bullets alive
				{
					for (var j: int = 0; j < bulletList.length; j++) // for each bullet in the bulletList
					{
						if (collisions.snow.hitTestObject(bulletList[j])) {
							collisions.snow.makesnowman();
							bulletList[j].removeSelf();
						}
					}
				}
			}
			//snowballs dissapear
			if (cut || inside) {
				if (bulletList.length > 0) // if there are any bullets alive
				{
					for (var k: int = 0; k < bulletList.length; k++) // for each bullet in the bulletList
					{
						bulletList[k].removeSelf();
					}
				}
			}


			//inside house
			//CONTROLS
			if (!paused && !cut) {

				if (rightPressed && (!attacking || player_inAir)) {
					if (player_xRight < player_topSpeed) {
						player_xRight += player_acceleration;
						player.scaleX = -1;
					}
				} else {
					if (player_xRight > 0.5) {
						player_xRight -= player_friction;
					} else if (player_xRight < -0.5) {
						player_xRight += player_friction;
					} else {
						player_xRight = 0;
					}
				}
				if (leftPressed && (!attacking || player_inAir)) {
					if (player_xLeft < player_topSpeed) {
						player_xLeft += player_acceleration;
						player.scaleX = 1;
					}

				} else {
					if (player_xLeft > 0.5) {
						player_xLeft -= player_friction;
					} else if (player_xLeft < -0.5) {
						player_xLeft += player_friction;
					} else {
						player_xLeft = 0;
					}
				}


				if (rightBumping || rightSnowball || rightWheel) {
					if (player_bounce) {
						player_xRight *= player_bounciness;
					} else {
						player_xRight = 0;
					}
				}

				if (leftBumping || leftSnowball || leftWheel) {
					if (player_bounce) {
						player_xLeft *= player_bounciness;
					} else {
						player_xLeft = 0;
					}
				}
				if (upBumping) {
					player_y = 1;
				}
				if (downBumping || overSnowball || overWheel) {
					player_y = 0;
					player_inAir = false;
				} else {
					if (player_y < player_maxGravity) {
						player_y += player_gravity;
					}
				}

				if (underBumping) {
					player_y = -2;
				}
				if (upPressed && !door) {
					if (downBumping || overSnowball || overWheel) {
						player_y = player_1stJumpHeight;
						player_doubleJumpReady = false;
						player_inAir = true;
					}

					if (player_doubleJumpReady && player_inAir && player_doubleJump) {
						player_y = player_2ndJumpHeight;
						player_doubleJumpReady = false;
						player_inAir = false;
					}

				} else {
					if (player_inAir) {
						player_doubleJumpReady = true;
					}
				}
			} else {
				player_y = 0;
				player_xLeft = 0;
				player_xRight = 0;
			}
			//UI STUFF
			ui.hearts.gotoAndStop(hp);
			TextField(ui.getChildByName("life")).text = String(lifeC);
			TextField(ui.getChildByName("coins_txt")).text = String(coinCount);

			if (lifeC <= 0) {
				playcs("gameover");
			}
			if (player.x < 800) {
				player.x += player_xRight;
			} else {
				collisions.x -= player_xRight;
			}
			if (player.x > 400) {
				player.x -= player_xLeft;
			} else {
				collisions.x += player_xLeft;
			}


			collisions.y -= player_y;

			if (skiing || inTrain || door) {
				//joystick.activateUp(); //999
			} else {
				// joystick.disableUp(); //999
			}
			if (contains(t) && !sledding) {
				removeChild(t);
			}

			//bar mirror
			if (collisions.mirror.hitTestObject(player)) {
				var localPoint: Point = collisions.mirror.globalToLocal(new Point(player.x + 60, player.y - 50));
				collisions.mirror.panda.x = localPoint.x;
				collisions.mirror.panda.y = localPoint.y;
				if (player.currentLabel == "attack") {
					collisions.mirror.panda.gotoAndStop("attack");
				} else if (player.currentLabel == "normal") {
					if (player.normal.currentLabel == "holding") {
						collisions.mirror.panda.gotoAndStop("holding");
						collisions.mirror.panda.holding.gotoAndStop(holdingitem);
					} else {
						collisions.mirror.panda.gotoAndStop("normal");
					}
					if (player.normal.norm.currentFrame == 1) {
						collisions.mirror.panda.norm.gotoAndPlay(1);
					}
				}
				if (player.scaleX == 1) {
					collisions.mirror.panda.scaleX = 1;
				} else {
					collisions.mirror.panda.scaleX = -1;
				}


			}




		}

		function playsled(): void {
			if (!sledding) {
				var sledGame: Sledding = new Sledding;
				addChild(sledGame);
				sledGame.addEventListener(Event.REMOVED, removesled);
				sledding = true;
				paused = true;
				addChild(t);
				addChild(border);
			}
		}
		function removesled(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED, removesled);
		}
		function skiStart(): void {
			if (!skiing) {
				var skiGame: SkiGame = new SkiGame;
				addChild(skiGame);
				skiing = true;
				cut = true;
				positions2("cabin inside");
				/*addChild(joystick);
				joystick.activateUp();
				addChild(border);*/ //999

			}
		}

		function startTrain(): void {
			var train: Train = new Train(true);
			inTrain = true;
			addChild(train);
			cut = true;
			addChild(ui);
			joyDepth();


		}
		function trainArrive(): void {
			collisions.winter_train.gotoAndPlay(2);
			player.visible = false;
			cut = true;
			collisions.train.gotoAndPlay(2);

		}


		function restartGame() {
			positions();
			lifeC -= 1;
			isInvincible = true;
			invincibilityTimeLeft = invicounter;

		}

		function startWaffle(): void {
			var waffle: waffleGame = new waffleGame;
			addChild(waffle);
			waffle.x = stage.stageWidth / 2 - waffle.width / 2;
			waffle.y = 50;
			waffling = true;
			paused = true;
		}
		function startBrun(): void {
			var brun: SliceGame = new SliceGame;
			addChild(brun);
			brun.x = stage.stageWidth / 2 - brun.width / 2;
			brun.y = 50;
			bruning = true;
			paused = true;
		}
		function startValve(): void {
			var valve: ValveGame = new ValveGame;
			addChild(valve);
			valve.x = stage.stageWidth / 2 - valve.width / 2;
			valve.y = 50;
			waffling = true;
			paused = true;
		}
		function startEat(): void {
			var eat: EatGame = new EatGame;
			addChild(eat);
			eat.x = stage.stageWidth / 2 - eat.width / 2;
			eat.y = 50;
			waffling = true;
			paused = true;
		}


		public function talk(_script: Array, i_name: String = "", item: String = null,
			gender: Boolean = true, _end: String = null): void {
			Aposition = 0;
			textPosition = 0;
			script = _script
			speech = _script[Aposition];
			speechName = i_name;
			male = gender;
			if (_end) {
				endquestion = _end;
				ask = true;
			}

			safe = true;
			if (talkable || holditem || inTrain) {
				ui.txt.gotoAndStop(2);
				talking = true;
				paused = true;
				talkable = false;
			}
			if (item && talkable) {
				talkitem = true;
				talkcontent = item;
				gotitem = item;
				talkable = false;
				talking = true;
				paused = true;

			}


		}

		public function yesno(_script: String): void {
			safe = true;
			ui.txt.gotoAndStop("yesno");
			TextField(ui.txt.getChildByName("body")).text = _script;
			question = true;
			paused = true;
			talkable = false;
			talking = false;
		}
		function doYesno(): void {
			switch (yesnoCase) {

				case 1: //train
					cut = true;
					player.visible = false;
					player.x -= 30;
					collisions.train.gotoAndPlay(2);
					break;
				case 2:
					hasSkis = true;
					coinCount -= 10;
					murray = 2;
					break;
				case 3:
					cut = true;
					ready = false
					collisions.iceEvent.gotoAndPlay("start");
					break;
				case 4:
					trainDepart()
					break;
				case 5: //solo
					holding = true;
					holdingitem = "solo";
					paused = false;
					delaySafe();
					break;
				case 6: //asako Question
					asakoForgive = true;
					break;
			}
		}
		public function trainDepart(): void {
			cut = false;
			paused = false;
			inTrain = false;
			newStage(7);
		}


		public function gotItem(item: String) {
			delaySafe();
			holditem = true;
			if (item == "key") {
				talk(["You got the mysterious key. What is it for?"], "Key");
			} else if (item == "bamboo") {
				talk(["You found your trusty bamboo! Attack away!"], "Bamboo");
			} else if (item == "meat") {
				talk(["Wow, a piece of raw meat. Too bad you're vegetarian."], "Raw Meat");
			} else if (item == "gelato") {
				talk(["A delicious gelato! Looks Yummy!"], "Gelato");
			}
			if (itembox1 == "empty") {
				itembox1 = item;
			} else if (itembox2 == "empty") {
				itembox2 = item;
			} else if (itembox3 == "empty") {
				itembox3 = item;
			} else if (itembox4 == "empty") {
				itembox4 = item;
			}
			gotitem = item


		}

		public function remove(item: String): void {
			if (itembox1 == item) {
				itembox1 = "empty";
			} else if (itembox2 == item) {
				itembox2 = "empty";
			} else if (itembox3 == item) {
				itembox3 = "empty";
			} else if (itembox4 == item) {
				itembox4 = "empty";
			}
		}

		public function gotHit() {
			invincibilityTimeLeft = invicounter;
			isInvincible = true;
		}

		//snowball
		function fireBullet(): void {
			var playerDirection: String;
			if (player.scaleX < 0) {
				playerDirection = "right";
			} else if (player.scaleX > 0) {
				playerDirection = "left";
			}
			var bullet: Bullet = new Bullet(player.x, player.y, playerDirection);
			stage.addChild(bullet);
			bulletList.push(bullet);
			bullet.addEventListener(Event.REMOVED, bulletRemoved);
		}


		function bulletRemoved(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED, bulletRemoved);
			bulletList.splice(bulletList.indexOf(e.currentTarget), 1);
		}

		function delaySafe(): void {
			safeTimeLeft = safeCounter;
			isSafe = true;
			attacking = false;
		}


		public function space(): void {

			if (!talking && !question && !worldmap && !question) {
				if (!player_inAir) {
					talkable = true;
				}
				if (!inTrain && !skimode && !inside && !safe && !isInvincible && hasBamboo) {
					attacking = true;
				} else {
					attacking = false;
				}
			} else if (doneTalking) {
				delaySafe();
				if (talkitem) {
					gotitem = talkcontent
					gotItem(talkcontent);
					talkitem = false;
				} else {
					holditem = false;
					textPosition = 0;
					Aposition++;
					if (Aposition >= script.length) {
						if (ask) {
							yesno(endquestion);
							ask = false;
						} else {
							talking = false;
							doneTalking = false;
						}
					}
				}
			}
			if (questionDone) {
				select = true;
			}

			transfer = true;


		}
		public function spaceUp(): void {
			talkable = false;
			transfer = false;
		}



		function keyUpHandler(e: KeyboardEvent) {
			switch (e.keyCode) {

				case 80: //p
					break;
				case 32: //space
					spaceUp();
					break;
				case 65:
					leftPressed = false;
					break;

				case 37:
					leftPressed = false;
					break;

				case 87:
					upPressed = false;
					break;

				case 38:
					upPressed = false;
					break;

				case 39:
					rightPressed = false;
					break;

				case 68:
					rightPressed = false;
					break;

				case 83:
					downPressed = false;
					//movejoy = false;
					break;

				case 40:
					downPressed = false;
					//movejoy = false;
					break;
				case 73: //i
					doitem2();
					break;
				case 77: //m
					if (!cut && !downtownInside) {
						playcs("map");
					}
					break;
				case 13: //enter
					spaceUp();
					break;
			}

		}

		public function leftp(): void {
			leftPressed = true;
		}
		public function rightp(): void {
			rightPressed = true;
		}



		function keyDownHandler(e: KeyboardEvent) {
			switch (e.keyCode) {
				case 32: //space
					space();
					break;

				case 65:
					leftp();
					break;

				case 37:
					leftp();
					break;

				case 87:
					upPressed = true;
					break;

				case 38:
					upPressed = true;
					break;

				case 39:
					rightp();
					break;

				case 68:
					rightp();
					break;

				case 83:
					downPressed = true;
					break;

				case 40:
					downPressed = true;
					break;
				case 13: //enter
					space();
					break;
			}
		} //END KEYS

		//SAVE
		function saveGame(): void {
			s1.play();
			so.data.coins = coinCount;
			so.data.coinstaken = coinstaken
			so.data.enemiestaken = enemiestaken
			so.flush();
			so.data.itembox1 = itembox1;
			so.data.itembox2 = itembox2;
			so.data.itembox3 = itembox3;
			so.data.itembox4 = itembox4;

			//progress
			so.data.hasBamboo = hasBamboo;
			so.data.hasMeat = hasMeat;
			so.data.hasKey = hasKey;
			so.data.hasGelato = hasGelato;
			so.data.snowmanquest = snowmanquest;
			so.data.toilclear = toilclear;
			so.data.cabinOpen = cabinOpen;
			so.data.hasSkis = hasSkis;
			so.data.murray = murray;

			so.data.currentStage = currentStage;
			//settings
			so.data.musicon = musicon;
			//scores
			so.data.sledscore = sledscore;
			so.flush(); //intensive
		}
		function loadGame(): void {
			coinCount = so.data.coins;
			coinstaken = so.data.coinstaken;
			enemiestaken = so.data.enemiestaken;
			itembox1 = so.data.itembox1;
			itembox2 = so.data.itembox2;
			itembox3 = so.data.itembox3;
			itembox4 = so.data.itembox4;

			//progress
			hasBamboo = so.data.hasBamboo;
			hasMeat = so.data.hasMeat;
			hasKey = so.data.hasKey;
			hasGelato = so.data.hasGelato;
			snowmanquest = so.data.snowmanquest;
			toilclear = so.data.toilclear;
			cabinOpen = so.data.cabinOpen;
			hasSkis = so.data.hasSkis;
			murray = so.data.murray;

			currentStage = so.data.currentStage;
			//settings
			musicon = so.data.musicon;
			//scores
			if (so.data.sledscore) {
				sledscore = so.data.sledscore;
			}
		}


		//cutscene

		function doload(e: MouseEvent): void {
			doload2()
		}

		function doload2(): void {
			if (so.data.coins) {
				Mouse.show();
				loadGame();
				newStage(currentStage);
				removecs();
				startup = false;
			} else {
				hurt.play();
			}


		}

		function docontinue(e: MouseEvent): void {
			positions();
			lifeC = 3;
			hp = 6;
			removecs();
		}

		function dosavequit(e: MouseEvent): void {
			saveGame();
			quitGame()
		}

		function dostart(e: MouseEvent): void {
			dostart2()
		}
		function dostart2(): void {
			removecs();
			startup = false;
			newStage(2);
			Mouse.show();
		}

		function quitGame(): void {
			NativeApplication.nativeApplication.exit();
		}


		//world map button
		function dowm(e: MouseEvent): void {
			if (!cut && !downtownInside) {
				playcs("map");
			}
		}
		//item box
		function doitem(e: MouseEvent): void {
			doitem2();
		}
		function doitem2(): void {
			if (ui.itembox.currentLabel == "closed") {
				ui.itembox.gotoAndStop("open");
				ui.itembox.item1.gotoAndStop(itembox1);
				ui.itembox.item2.gotoAndStop(itembox2);
				ui.itembox.item3.gotoAndStop(itembox3);
				ui.itembox.item4.gotoAndStop(itembox4);
			} else if (ui.itembox.currentLabel == "open") {
				ui.itembox.gotoAndStop("closed");
			}
		}

		//menubar
		function domenu(e: MouseEvent): void {
			if (ui.menubar.currentLabel == "closed") {
				ui.menubar.gotoAndStop("open");
				menubaropen = true;
				if (musicon) {
					ui.menubar.musiconoff.mouseEnabled = false;
					TextField(ui.menubar.getChildByName("musiconoff")).text = "music on";

				} else {
					TextField(ui.menubar.getChildByName("musiconoff")).text = "music off";
					ui.menubar.musiconoff.mouseEnabled = false;
				}

				ui.menubar.musicbtn.addEventListener(MouseEvent.CLICK, domusic);
				ui.menubar.exitbtn.addEventListener(MouseEvent.CLICK, doexit);
				ui.menubar.savebtn.addEventListener(MouseEvent.CLICK, dosave);
				//ui.menubar.joySettings.addEventListener(MouseEvent.CLICK, doJoy); //999

				/*function doJoy(e: MouseEvent): void {
					if (!movejoy) {
						joystick.moveJoy();
						movejoy = true;
					} else {
						joystick.moveJoyDone();
						movejoy = false;
					}
				}*/ //999

				function dosave(e: MouseEvent): void {
					saveGame();
				}

				function doexit(e: MouseEvent): void {
					quitGame()
				}

				function domusic(e: MouseEvent): void {

					if (musicon) {
						musicon = false;
						TextField(ui.menubar.getChildByName("musiconoff")).text = "music off";
						channel.stop();

					} else {
						musicon = true;
						TextField(ui.menubar.getChildByName("musiconoff")).text = "music on";
						channel = currentsong.play();
					}


				}

			} else if (ui.menubar.currentLabel == "open") {
				ui.menubar.gotoAndStop("closed");
				menubaropen = false;
			}
		}
		function toggleScreen(e: MouseEvent): void {
			if (fullScreen == false) {
				fullScreen = true;
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {
				fullScreen = false;
				stage.displayState = StageDisplayState.NORMAL;
			}

		}


		/*function doface(e: MouseEvent): void {
			if (joystick.visible) {
				joystick.visible = false;
				spaceButton.visible = false;
				upButton.visible = false;
			} else {
				joystick.visible = true;
				spaceButton.visible = true;
				upButton.visible = true;
			}
		}*/ //999



		//START




		function dohu(e: TouchEvent): void {
			addEventListener(TouchEvent.TOUCH_END, endhu);
			upPressed = true;
		}
		function dohs(e: TouchEvent): void {
			addEventListener(TouchEvent.TOUCH_END, endhs);
			space();
		}

		//FINISH
		function endhu(e: TouchEvent): void {
			removeEventListener(TouchEvent.TOUCH_END, endhu);
			upPressed = false;
		}

		function endhs(e: TouchEvent): void {
			removeEventListener(TouchEvent.TOUCH_END, endhs);
			spaceUp();



		} //end TOUCH

		//border
		public function transition(): void {
			addChild(border);
			border.transition.gotoAndPlay(2);
		}


		//downtown functionality
		function fadeIn(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: 1
			});
		}

		function fadeOut(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: 0
			});
		}

	}
}