package Levels {

	import flash.display.MovieClip;
	import flash.events.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.geom.Point;
	import Cutscene.*;
	import MiniGame.*;

	public class Train extends LevelClass {

		//cutscene
		private var bodyWall, bodyWall2: Boolean = false;
		private var cut: Boolean = false;
		private var exScene: Boolean = true;
		private var ex1: execution = new execution;
		private var ex2: Murder = new Murder;
		//mg
		private var waffle: WaffleGame = new WaffleGame;
		private var brun: SliceGame = new SliceGame;
		private var eat: EatGame = new EatGame;
		private var valve: ValveGame = new ValveGame;
		//arrival
		private var arrivalTime: int = 0;
		private var arrivalCounter: int = 60;
		//quests
		public var waffleMission: int = 0;
		public var valveSuccess: Boolean = false;
		//train
		private var carts: Array = new Array;
		private var doors: Array = new Array;
		private var doorDepth, doorDepth2: int;
		//panda
		private var panda: MovieClip;
		private var inner, loco: Boolean = false;
		private var pandaG: Point
		public var holdItem: String = null;
		//char movement
		private var player_xRight: int = 0;
		private var player_xLeft: int = 0;
		private var speed: int = 15;
		private var rightBumping, leftBumping: Boolean = false;
		//bg
		private var trees: Array = new Array();
		private var treeSpeed = 7;
		//sound
		//var trainloop: Trainloop = new Trainloop();
		private var trainDone: Boolean;
		//progression
		private var events: int = 0;
		public var inGame: Boolean = false;
		public var waffleSuccess: Boolean = false;
		public var asakoForgive: Boolean = false;


		public function Train(_trainDone: Boolean = false) {
			trainDone = _trainDone;
			createGame();
		}

		function createGame(): void {

			bgTree(6);
			addChild(tog);
			tog.t3.alpha = 0;
			carts = [tog.t3.cart1, tog.t3.cart2, tog.t3.cart3, tog.t3.cart4, tog.t3.cart5];
			doors = [tog.door1, tog.door2, tog.door3, tog.door4];
			//trainloop.play(0, 2);
			depthOrder();
			if (!trainDone) {
				tog.gotoAndStop("start");
				depthOrder();
			} else {
				tog.gotoAndStop("normal");
				tog.x = -3464.2;
				tog.circle.x = 3976.15;
				depthOrder();
			}

		}

		override function loopCode(): void {
			panda = tog.circle;

			//t2a
			if (tog.currentLabel == "start") {
				tog.t2a.gotoAndStop("start");
			} else if (tog.currentLabel == "marco") {
				tog.t2a.gotoAndStop("marco");
			} else if (tog.currentLabel == "gerald") {
				tog.t2a.gotoAndStop("gerald");
			} else if (tog.currentLabel == "thomas" || tog.currentLabel == "conducter") {
				tog.t2a.gotoAndStop("thomas");
			} else {
				tog.t2a.gotoAndStop("nothing");
			}


			//panda

			pandaG = panda.localToGlobal(new Point(0));
			treeMove();

			//frame specific

			//inner
			if (tog.currentLabel == "start") {
				if (inner) {
					talk(tog.asako, ["I wonder if there's a hidden compartment on this train,",
						"where I can store a digital copy of my current self....",
						"......Hmmm? Oh just daydreaming"
					], "Asako", false);
					talk(tog.marble, ["Oh my, what a cute panda."], "Ms. Marble");
					talk(tog.daniel, ["Socks in sandals is the newest trend y'know."], "Daniel");
					talk(tog.thomas, ["Man, I'm hungry, but they haven't started food serving yet."], "Thomas");
				}
				talk(tog.chef, ["Je suis le chef de ce train. Bon appétit!"], "Pascal");
				talk(tog.gerald, ["I heard this train is famous for its nordic cuisine."], "Gerald");
				talk(tog.greene, ["[Becuase of Marco, my inheritance is as good as gone...]",
					"..........What?", "Mind your own business, will ya!"
				], "Mr. Greene");
				talk2(tog.engineer, ["I hope you enjoy the ride!"], "Engineer", next, 1); //next();
				talk(tog.marco, ["This train ride is gonna give me motion sickness..."], "Marco");
				talk(tog.pengi, ["Don't mind me, I'm just a human doing human things", "How about those taxes, am I right?"], "Pen Quinn");

				//objects
				talk(tog.waffleDrawer, ["An assortment of brown cheeses. How exotic!"], "");
				talk(tog.waffle, ["A waffle iron. Smells good!"], "");
				talk(tog.sink, ["It's a sink."], "");

			} else if (tog.currentLabel == "marco") {

				//murder event
				if (events < 2) {
					if (tog.marco.hitTestObject(panda.hitbox)) {
						bodyWall = true;
					} else {
						bodyWall = false;
					}

				}
				if (panda.hitTestObject(tog.marco) && Main.key.space && !cut && events < 2) {
					tog.t2a.marcoDead.gotoAndStop(2);
					cut = true;
					events = 2;
					bodyWall = false;
					Main.u.transition();
					depthOrder();
					tog.x = -1664.2;
					panda.x = 2536.15;
				}

				if (tog.t2a.marcoDead.currentFrame == 3 && exScene) {
					addChild(ex1);
					ex1.gotoAndPlay(2);
					ex1.victim.gotoAndStop("greene");
					exScene = false;
				}
				if (ex1.currentLabel == "done") {
					removeChild(ex1);
					Main.u.transition();
					cut = false;
				}

				//characters
				if (inner) {
					talk(tog.marble, ["What's all this ruckus? Can't an old woman get some quiet?"], "Ms. Marble");
					talk(tog.daniel, ["Well I'm glad that's over with."], "Daniel");
				}
				talk(tog.engineer, ["Boy, do I love trains!"], "Engineer");
				talk(tog.gerald, ["I'm famished! Can someone go check what the holdup is?"], "Gerald");
				talk(tog.thomas, ["Man, all this commotion made me hungry.", "Isn't it about dinner time already?"], "Thomas");
				talk(tog.asako, ["To do such a thing, just because of inheritance.", "... adults are weird"], "Asako", false);
				talk2(tog.chef, ["Nous sommes presque prêts à servir de la nourriture."], "Pascal", next, 2);
				talk(tog.pengi, ["Not that the storage room isn't cozy...", "but I kinda wish I had my own room."], "Pen Quinn");
				//objects
				talk(tog.waffleDrawer, ["An assortment of brown cheeses. How exotic!"], "");
				talk(tog.waffle, ["A waffle iron. Smells good!"], "");
				talk(tog.sink, ["It's a sink."], "");
				talk(tog.gmarco, ["Here lies Marco"], "");


			} else if (tog.currentLabel == "gerald") {
				//murder case
				if (events < 3) {
					if (tog.gerald.hitTestObject(panda.hitbox)) {
						bodyWall2 = true;
					} else {
						bodyWall2 = false;
					}
					if (tog.stopBlock.hitTestObject(panda.hitbox)) {
						bodyWall = true;
					} else {
						bodyWall = false;
					}

				} else {
					tog.chefv.visible = false;
				}
				if (panda.hitTestObject(tog.gerald) && Main.key.space && !cut && events < 3) {
					tog.geraldDead.gotoAndStop(2);
					cut = true;
					events = 5;
					bodyWall = false;
					bodyWall2 = false;
					Main.u.transition();
					depthOrder();
					tog.x = 3510;
					panda.x = -3090;
				}

				if (tog.geraldDead.currentFrame == 3 && exScene) {
					addChild(ex1);
					ex1.gotoAndPlay(2);
					ex1.victim.gotoAndStop("chef");
					exScene = false;
				}
				if (ex1.currentLabel == "done") {
					removeChild(ex1);
					cut = false;
					Main.u.transition();
				}

				//events
				if (panda.hitbox.hitTestObject(tog.waffle) && !inGame && Main.key.space && waffleMission == 1) {
					startGame(waffle);
				}
				if (panda.hitbox.hitTestObject(tog.brunost) && !inGame && Main.key.space && waffleMission == 3) {
					startGame(brun);
				}
				//characters
				if (inner) {
					talk(tog.daniel, ["Yeah, that's right... Sandals stay on, even in bed!"], "Daniel");
					talk(tog.marble, ["I suppose I can't spend all my time cooped up in my room."], "Ms. Marble");
					talk(tog.engineer, ["It's about time for dinner, you should get ready!"], "Engineer");
				}
				if (waffleMission < 2) {
					talk2(tog.thomas, ["Hey panda, since we don't have a chef anymore...", "How about you serve dinner instead?"], "Thomas", doExtra, 1);
				} else if (waffleMission == 2) {
					talk2(tog.thomas, ["Ah thanks!", "But I'd like some brown cheese on top, if you don't mind"], "Thomas", doExtra, 2);
				} else if (waffleMission == 3) {
					talk(tog.thomas, ["There should be some brown cheese in the kitchen drawer."], "Thomas");
				} else if (waffleMission == 4) {
					next(3);
				}

				talk(tog.asako, ["What? Dinner time?", "But I'm not hungry yet!"], "Asako", false);
				talk(tog.pengi, ["Don't mind me, just enjoying the breeze."], "Pen Quinn");
				talk(tog.gmarco, ["Here lies Marco"], "");

			} else if (tog.currentLabel == "thomas") {
				//murder case
				if (events < 6) {
					if (tog.thomas.hitTestObject(panda.hitbox)) {
						bodyWall2 = true;
					} else {
						bodyWall2 = false;
					}
				}
				if (events < 7) {
					if (panda.hitTestObject(tog.thomas) && Main.key.space && !cut) {
						tog.thomasDead.gotoAndStop(2);
						events = 6;
						bodyWall2 = false;
						Main.u.transition();
						tog.x = 3271;
						panda.x = -2460;
						panda.scaleX = 1;
						holdItem = null;
						tog.plate.gotoAndStop("full");
					}
					if (tog.thomasDead.currentFrame == 3 && exScene) {
						addChild(ex1);
						ex1.gotoAndPlay(2);
						ex1.victim.gotoAndStop("marble");
						exScene = false;
					}
					if (ex1.currentLabel == "done") {
						removeChild(ex1);
						Main.u.transition();
						events = 7;
					}
				}

				//events
				if (holdItem == "wash") {
					tog.plate.gotoAndStop("empty");
					waffleMission = 6;
				}

				//characters
				if (panda.hitbox.hitTestObject(tog.eat) && Main.key.space && !inGame && waffleMission == 5) {
					startGame(eat);
				}
				if (panda.hitbox.hitTestObject(tog.sink) && Main.key.space && waffleMission == 6) {
					holdItem = null
					depthOrder();
					next(4);
				}
				if (inner) {
					talk(tog.asako, ["I guess I get both top and bottom bunk now!"], "Asako", false);
				}
				talk(tog.daniel, ["Thank god we didn't have to listen to the old woman's investigation."], "Daniel");
				talk(tog.engineer, ["Did you enjoy the dinner?"], "Engineer");
				if (waffleMission < 5) {
					talk2(tog.pengi, ["You shouldn't let that food go to waste!", "What me? Nah, I prefer fish."], "Pen Quinn", doExtra, 3);
				} else if (waffleMission == 5) {
					talk(tog.pengi, ["If you don't eat it, no one will!"], "Pen Quinn");
				} else if (waffleMission == 6) {
					talk(tog.pengi, ["You should probably wash that dish."], "Pen Quinn");
				}

				talk(tog.gmarco, ["Here lies Marco"], "");
				talk(tog.ggerald, ["Here lies Gerald"], "");
			} else if (tog.currentLabel == "engineer") {
				//murder case
				if (events < 8) {
					if (tog.engineer.hitTestObject(panda.hitbox)) {
						bodyWall2 = true;
					} else {
						bodyWall2 = false;
					}
					talk(tog.pengi, ["Ahhh! Finally a room for myself. I guess things aren't all bad."], "Pen Quinn");

				} else {
					tog.pengiV.visible = false;
				}
				if (panda.hitTestObject(tog.engineer) && Main.key.space && !cut) {
					tog.engineerDead.gotoAndStop(2);
					events = 8;
					bodyWall2 = false;
					Main.u.transition();
					depthOrder();
					tog.x = -3539;
					panda.x = 4390;
				}
				if (tog.engineerDead.currentFrame == 3 && exScene) {
					addChild(ex1);
					ex1.gotoAndPlay(2);
					ex1.victim.gotoAndStop("penguin");
					exScene = false;
				}
				if (ex1.currentLabel == "done") {
					removeChild(ex1);
					next(5);
					depthOrder();
					Main.u.transition();
				}
				//characters
				talk(tog.daniel, ["Doesn't it feel... A lot emptier?"], "Daniel");
				talk(tog.asako, ["Well no more murders so far..."], "Asako", false);

				talk(tog.gmarco, ["Here lies Marco"], "");
				talk(tog.ggerald, ["Here lies Gerald"], "");
				talk(tog.gthomas, ["Here lies Thomas"], "");
			} else if (tog.currentLabel == "conducter") {
				if (holdItem == "coal") {
					talk(tog.asako, ["Smart thinking!", "Now go put it in the furnace!"], "Asako", false);
				} else {
					talk(tog.asako, ["It seems like the train is slowing down...", "Hey your hat is kinda like the engineers, so why don't you fix it?"], "Asako", false);
				}
				if (holdItem == "coal") {
					talk(tog.daniel, ["That's what Santa gives me every year for Christmas.."], "Daniel");
				} else {
					talk(tog.daniel, ["The train is running out of steam, and we have no engineer...", "I bet we just need some more charcoal though"], "Daniel");
				}
				if (panda.hitbox.hitTestObject(tog.coalBox) && Main.key.space) {
					holdItem = "coal";
				}
				if (panda.hitbox.hitTestObject(tog.engine) && Main.key.space && holdItem == "coal" && !inGame) {
					startGame(valve);
				}
				if (valveSuccess) {
					holdItem = null;
					next(6);
					depthOrder();
				}
				talk(tog.gmarco, ["Here lies Marco"], "");
				talk(tog.ggerald, ["Here lies Gerald"], "");
				talk(tog.gthomas, ["Here lies Thomas"], "");
				talk(tog.gengineer, ["Here lies the engineer"], "");

			} else if (tog.currentLabel == "daniel") {
				//murder case
				if (events < 9) {
					if (tog.daniel.hitTestObject(panda.hitbox)) {
						bodyWall = true;
					} else {
						bodyWall = false;
					}

				}
				if (panda.hitTestObject(tog.daniel) && Main.key.space && !cut) {
					tog.danielDead.gotoAndStop(2);
					events = 9;
					tog.x = 6315.85;
					panda.x = -5479.8;
					bodyWall = false;
					Main.u.transition();
					depthOrder();
					cut = true;
				}
				if (tog.danielDead.currentFrame == 3 && exScene) {
					trace("now");
					addChild(ex2);
					ex2.gotoAndPlay(2);
					exScene = false;
					panda.visible = false;
				}
				if (ex2.currentLabel == "done") {
					removeChild(ex2);
					tog.danielDead.gotoAndStop(4);
					tog.x = 6315.85;
					panda.x = -5479.8;
					Main.u.transition();
				}
				if (ex2.currentLabel == "life") {
					Main.panda.takeLife();
				}
				if (tog.danielDead.currentFrame == 5) {
					///m.trainDepart() /// arrival
					Main.u.transition();
				}

				//characters
				talk(tog.asako, ["Hey! You got the train moving again! Good job, Panda!"], "Asako", false);
				talk(tog.gmarco, ["Here lies Marco"], "");
				talk(tog.ggerald, ["Here lies Gerald"], "");
				talk(tog.gthomas, ["Here lies Thomas"], "");
				talk(tog.gengineer, ["Here lies the engineer"], "");

			} else if (tog.currentLabel == "normal") {

				//characters

				if (asakoForgive) {
					talk(tog.asako, ["Hey panda! Fancy seeing you here again!", "Don't worry I'm done with the whole murder thing!"], "Asako", false);
				} else {
					talk(tog.asako, ["Oh... It's you. I still haven't forgotten about the bamboo...", "It really hurt y'know!"], "Asako", false);
				}

				//if (panda.hitbox.hitTestObject(tog.engineer) && Main.) {
					//m.yesno("Are you ready to disembark?"); make engineer class talk
				//}

				//events
				if (panda.hitbox.hitTestObject(tog.coalBox) && Main.key.space) {
					holdItem = "coal";
				}
				if (panda.hitbox.hitTestObject(tog.engine) && Main.key.space && holdItem == "coal" && !inGame) {
					startGame(valve);
				}
				if (panda.hitbox.hitTestObject(tog.waffle) && Main.key.space && !inGame) {
					startGame(waffle);
				}
				if (panda.hitbox.hitTestObject(tog.brunost) && Main.key.space && !inGame && holdItem == "waffle") {
					startGame(brun);
				}
				if (holdItem == "brun" && !inGame) {
					if ((panda.hitbox.hitTestObject(tog.table1) || (panda.hitbox.hitTestObject(tog.table2))) && Main.key.space) {
						startGame(eat);
					}
				}
				if (panda.hitbox.hitTestObject(tog.sink) && Main.key.space && holdItem == "wash") {
					holdItem = null
				}
				
				

			}
			//objects
			if (panda.hitbox.hitTestObject(tog.trainHorn) && Main.key.space && tog.trainHorn.currentFrame == 1) {
				tog.trainHorn.gotoAndPlay(2);
				Mixer.play.FX("horn");
			}
			// same for all frames

			//layer 3
			for (var j: int = 0; j < carts.length; j++) {
				if (!carts[j].hitTestObject(panda.hitbox)) {
					fadeIn(tog.t3);
				} else {
					fadeOut(tog.t3);
				}
			}

			if (carts[0].hitTestObject(panda.hitbox) || carts[4].hitTestObject(panda.hitbox)) {
				loco = true;
			} else {
				loco = false;
			}

			for (var i: int = 0; i < doors.length; i++) {
				if (inner) {
					tog.addChildAt(doors[i], doorDepth);
				} else {
					tog.addChildAt(panda, doorDepth);
				}
				if (doors[i].hitbox.hitTestObject(panda.hitbox)) {
					if (inner) {
						doors[i].alpha = 0.3;
					} else {
						doors[i].alpha = 1;
					}

					if (Main.key.down && inner) {
						doors[i].ani.gotoAndPlay(2);
						inner = false;
						fadeIn(tog.t2);
						fadeIn(tog.t2a);
					} else if (Main.key.up && !inner) {
						doors[i].ani.gotoAndPlay(2);
						inner = true;
						fadeOut(tog.t2);
						fadeOut(tog.t2a);
					}
				} else {
					if (inner) {
						doors[i].alpha = 0.3;
					} else {
						doors[i].alpha = 1;
					}
				}
			}

			//wall collisions
			if (tog.wall.hitTestPoint(pandaG.x - panda.width / 2, pandaG.y - panda.height / 2, true)) {
				leftBumping = true;
			} else {
				leftBumping = false;
			}

			if (tog.wall.hitTestPoint(pandaG.x + panda.width / 2, pandaG.y - panda.height / 2, true)) {
				rightBumping = true;
			} else {
				rightBumping = false;
			}

			//animation
			if (holdItem != null) {
				panda.gotoAndStop("hold");
				panda.item.gotoAndStop(holdItem);
			} else {
				panda.gotoAndStop("normal");
			}

			//movement
			if (!Main.isPaused && !cut) {
				if (Main.key.right && !bodyWall2 && (!rightBumping || !inner && !loco)) {
					player_xRight = speed;
					panda.scaleX = -1;
				} else {
					player_xRight = 0;
				}
				if (Main.key.left && !bodyWall && (!leftBumping || !inner && !loco)) {
					player_xLeft = speed;
					panda.scaleX = 1;
				} else {
					player_xLeft = 0;
				}

				if (pandaG.x < stage.x + 900) {
					panda.x += player_xRight;
				} else {
					tog.x -= player_xRight;
					panda.x += player_xRight;
				}
				if (pandaG.x > stage.x + 300) {
					panda.x -= player_xLeft;
				} else {
					tog.x += player_xLeft;
					panda.x -= player_xLeft;
				}
			}



		}

		function talk(mc: MovieClip, body: Array, nName: String = "", nGender: Boolean = true): void {

			if (mc.hitTestObject(tog.circle) && Main.key.space) {
				Main.u.talk.say(body, nName, nGender);
			}
		}
		function talk2(mc: MovieClip, body: Array, nName: String, f: Function = null, arg: int = 0): void {

			if (mc.hitTestObject(tog.circle) && Main.key.space) {
				Main.u.talk.say(body, nName);
				if (f != null) {
					f(arg);
				}

			}
		}

		function doExtra(what: int): void {
			switch (what) {
				case 1: //thomas eat 1
					waffleMission = 1;
					break;
				case 2:
					waffleMission = 3;
					waffleSuccess = false;
					holdItem = "plate";
					break;
				case 3:
					waffleMission = 5;
					break;
			}
		}



		function depthOrder(): void {
			tog.addChild(tog.t2);
			tog.addChild(tog.t2a);
			tog.addChild(tog.circle);
			tog.addChild(tog.t3);
			doorDepth = tog.getChildIndex(tog.circle);
			doorDepth2 = tog.getChildIndex(tog.door1);
			inner = false;
		}
		override function fadeIn(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: 1
			});
		}

		override function fadeOut(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: -5
			});
		}
		function bgTree(amount: int): void {
			var treex: int = 1500;
			for (var i: int = 0; i < amount; i++) {
				var tree: Tree = new Tree;
				addChild(tree);
				trees.push(tree);
				tree.scaleX = 0.3;
				tree.scaleY = 0.3;
				tree.x = treex;
				tree.y = 300;
				treex += 300 + Math.floor(Math.random() * 80);
			}

		}
		function next(victim: int): void {
			depthOrder();
			if (victim == 1) {
				tog.gotoAndStop("marco");
			} else if (victim == 2) {
				tog.gotoAndStop("gerald");
			} else if (victim == 3) {
				tog.gotoAndStop("thomas");
			} else if (victim == 4) {
				tog.gotoAndStop("engineer");
			} else if (victim == 5) {
				tog.gotoAndStop("conducter");
				treeSpeed = 2;
			} else if (victim == 6) {
				tog.gotoAndStop("daniel");
				treeSpeed = 7;
				valveSuccess = false;
			}

			exScene = true;
		}

		function startGame(mg): void {
			addChild(mg);
			mg.x = Main.getStage.stageWidth / 2 - mg.width / 2;
			mg.y = 50;
			inGame = true;
			Main.pauseGame();
		}


		function treeMove(): void {
			if (trees.length > 0) {
				for (var j: int = 0; j < trees.length; j++) {
					trees[j].x -= treeSpeed;
					if (trees[j].x < -100) {
						trees[j].x = 1460 + Math.floor(Math.random() * 40);
					}
				}
			}
		}//end treeMove

	}
}