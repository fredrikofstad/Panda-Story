package{

	import flash.display.MovieClip;
	import flash.events.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.geom.Point;

	public class Train extends MovieClip {

		//mc
		var ex1: execution = new execution;
		var ex2: Murder = new Murder;

		//arrival
		var arrivalTime: int = 0;
		var arrivalCounter: int = 60;

		//quests
		var coalquest: Boolean = false;
		var waffleMission: int = 0;

		//train
		var carts: Array = new Array;
		var doors: Array = new Array;
		var doorDepth, doorDepth2: int;

		//panda
		var panda: MovieClip;
		var inner, loco: Boolean = false;
		var pandaG: Point
		var holding: Boolean = false;
		var holdItem: String = null;

		//char movement
		var player_xRight: int = 0;
		var player_xLeft: int = 0;
		var speed: int = 15;
		var rightBumping, leftBumping: Boolean = false;

		//bg
		var trees: Array = new Array();
		var treeSpeed = 7;

		var m = MovieClip(root);
		var events: int = 0;
		//sound
		var trainloop: Trainloop = new Trainloop();
		var trainDone: Boolean;
		//cutscene
		var bodyWall, bodyWall2: Boolean = false;
		var cut: Boolean = false;
		var exScene: Boolean = true;

		public function Train(_trainDone: Boolean = false) {
			trainDone = _trainDone;
			createGame();
		}

		function createGame(): void {
			addEventListener(Event.ENTER_FRAME, loop);


			bgTree(6);

			addChild(tog);

			depthOrder();

			tog.t3.alpha = 0;

			carts = [tog.t3.cart1, tog.t3.cart2, tog.t3.cart3, tog.t3.cart4, tog.t3.cart5];
			doors = [tog.door1, tog.door2, tog.door3, tog.door4];
			trainloop.play(0, 2);

			if (!Main.trainDone) {
				tog.gotoAndStop("start");
				depthOrder();
			} else {
				tog.gotoAndStop("normal");
				tog.x = -3464.2;
				tog.circle.x = 3976.15;
				depthOrder();
			}

			//tog.x = -3464.2;
			//tog.circle.x = 3976.15;   marco coordinates

			//tog.x = 4425.8
			//tog.circle.x = -3688.9  gerald coordinates






		}

		function loop(e: Event): void {


			m = MovieClip(root);

			panda = tog.circle;

			if (m.currentStage == 5) {

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
						if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
							m.talk(["I wonder if there's a hidden compartment on this train,", "where I can store a digital copy of my current self....",
								"......Hmmm? Oh just daydreaming"
							], "Asako", null, false);
						} else if (panda.hitbox.hitTestObject(tog.marble) && m.talkable) {
							m.talk(["Oh my, what a cute panda."], "Ms. Marble");
						} else if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
							m.talk(["Socks in sandals is the newest trend y'know."], "Daniel");
						} else if (panda.hitbox.hitTestObject(tog.thomas) && m.talkable) {
							if (holdItem == "waffle") {
								m.talk(["Wow! Is that waffle for me? Many thanks!"], "Thomas");
								holding = false;
								m.waffleSuccess = false;
							} else if (holdItem == "coal") {
								m.talk(["Well, beggars can't be choosers, I guess... *Munch* *Munch*"], "Thomas");
								holding = false;
							} else {
								m.talk(["Man, I'm hungry, but they haven't started food serving yet."], "Thomas");
							}
						}
					}


					if (panda.hitbox.hitTestObject(tog.chef) && m.talkable) {
						m.talk(["Je suis le chef de ce train. Bon appétit!"], "Pascal");
					}
					if (panda.hitbox.hitTestObject(tog.gerald) && m.talkable) {
						m.talk(["I heard this train is famous for its nordic cuisine."], "Gerald");
					}
					if (panda.hitbox.hitTestObject(tog.greene) && m.talkable) {
						m.talk(["[Becuase of Marco, my inheritance is as good as gone...]", "..........What?", "Mind your own business, will ya!"], "Mr. Greene");
					}
					if (panda.hitbox.hitTestObject(tog.engineer) && m.talkable) {

						m.talk(["I hope you enjoy the ride!"], "Engineer");
						next(1);
					}
					if (panda.hitbox.hitTestObject(tog.marco) && m.talkable) {
						m.talk(["This train ride is gonna give me motion sickness..."], "Marco");
					}
					if (panda.hitbox.hitTestObject(tog.pengi) && m.talkable) {
						m.talk(["Don't mind me, I'm just a human doing human things", "How about those taxes, am I right?"], "Pen Quinn");
					}

					//objects
					if (panda.hitbox.hitTestObject(tog.waffleDrawer) && m.talkable) {
						m.talk(["An assortment of brown cheeses. How exotic!"], "");
					}
					if (panda.hitbox.hitTestObject(tog.waffle) && m.talkable) {
						m.talk(["A waffle iron. Smells good!"], "");
					}
					if (panda.hitbox.hitTestObject(tog.sink) && m.talkable) {
						m.talk(["It's a sink."], "");
					}

				} else if (tog.currentLabel == "marco") {

					//murder event
					if (events < 2) {
						if (tog.marco.hitTestObject(panda.hitbox)) {
							bodyWall = true;
						} else {
							bodyWall = false;
						}

					}
					if (panda.hitTestObject(tog.marco) && m.talkable && !cut && events < 2) {
						tog.t2a.marcoDead.gotoAndStop(2);
						events = 2;
						bodyWall = false;
						m.transition();
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
						m.transition();
					}

					//characters
					if (inner) {

						if (panda.hitbox.hitTestObject(tog.marble) && m.talkable) {
							m.talk(["What's all this ruckus? Can't an old woman get some quiet?"], "Ms. Marble");
						} else if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
							m.talk(["Well I'm glad that's over with."], "Daniel");
						}
					}
					if (panda.hitbox.hitTestObject(tog.engineer) && m.talkable) {
						m.talk(["Boy, do I love trains!"], "Engineer");
					}
					if (panda.hitbox.hitTestObject(tog.gerald) && m.talkable) {
						m.talk(["I'm famished! Can someone go check what the holdup is?"], "Gerald");
					}
					if (panda.hitbox.hitTestObject(tog.thomas) && m.talkable) {
						m.talk(["Man, all this commotion made me hungry.", "Isn't it about dinner time already?"], "Thomas");
					}
					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						m.talk(["To do such a thing, just because of inheritance.", "... adults are weird"], "Asako", null, false);
					}
					if (panda.hitbox.hitTestObject(tog.chef) && m.talkable) {
						m.talk(["Nous sommes presque prêts à servir de la nourriture."], "Pascal");
						next(2);
					}
					if (panda.hitbox.hitTestObject(tog.pengi) && m.talkable) {
						m.talk(["Not that the storage room isn't cozy...", "but I kinda wish I had my own room."], "Pen Quinn");
					}
					//objects
					if (panda.hitbox.hitTestObject(tog.waffleDrawer) && m.talkable) {
						m.talk(["An assortment of brown cheeses. How exotic!"], "");
					}
					if (panda.hitbox.hitTestObject(tog.waffle) && m.talkable) {
						m.talk(["A waffle iron. Smells good!"], "");
					}
					if (panda.hitbox.hitTestObject(tog.sink) && m.talkable) {
						m.talk(["It's a sink."], "");
					}
					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}

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
					if (panda.hitTestObject(tog.gerald) && m.talkable && !cut && events < 3) {
						tog.geraldDead.gotoAndStop(2);
						events = 5;
						bodyWall = false;
						bodyWall2 = false;
						m.transition();
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
						m.transition();
					}

					//events
					if (panda.hitbox.hitTestObject(tog.waffle) && m.talkable && !m.waffling && waffleMission == 1) {
						m.talkable = false;
						m.startWaffle();
					}
					if (panda.hitbox.hitTestObject(tog.brunost) && m.talkable && !m.bruning && waffleMission == 3) {
						m.talkable = false;
						m.startBrun();
					}
					if (m.waffleSuccess) {
						holding = true;
						holdItem = "waffle";
						waffleMission = 2;
					}
					if (m.brunSuccess) {
						holding = true;
						holdItem = "brunost";
						waffleMission = 4;
						next(3);
					}
					//characters
					if (inner) {
						if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
							m.talk(["Yeah, that's right... Sandals stay on, even in bed!"], "Daniel");
						}
					}
					if (panda.hitbox.hitTestObject(tog.marble) && m.talkable) {
						m.talk(["I suppose I can't spend all my time cooped up in my room."], "Ms. Marble");
					}
					if (panda.hitbox.hitTestObject(tog.engineer) && m.talkable) {
						m.talk(["It's about time for dinner, you should get ready!"], "Engineer");
					}
					if (panda.hitbox.hitTestObject(tog.thomas) && m.talkable) {
						if (waffleMission < 2) {
							m.talk(["Hey panda, since we don't have a chef anymore...", "How about you serve dinner instead?"], "Thomas");
							waffleMission = 1;
						} else if (waffleMission == 2) {
							m.talk(["Ah thanks!", "But I'd like some brown cheese on top, if you don't mind"], "Thomas");
							waffleMission = 3;
							m.waffleSuccess = false;
							holdItem = "plate";
						} else if (waffleMission == 3) {
							m.talk(["There should be some brown cheese in the kitchen drawer."], "Thomas");
						}

					}

					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						m.talk(["What? Dinner time?", "But I'm not hungry yet!"], "Asako", null, false);
					}
					if (panda.hitbox.hitTestObject(tog.pengi) && m.talkable) {
						m.talk(["Don't mind me, just enjoying the breeze."], "Pen Quinn");
					}
					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}



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
						if (panda.hitTestObject(tog.thomas) && m.talkable && !cut) {
							tog.thomasDead.gotoAndStop(2);
							events = 6;
							bodyWall2 = false;
							m.transition();
							tog.x = 3271;
							panda.x = -2460;
							panda.scaleX = 1;
							holding = false;
							m.brunSuccess = false;
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
							m.transition();
							events = 7;
						}
					}

					//events

					if (m.eatSuccess) {
						tog.plate.gotoAndStop("empty");
						holding = true;
						holdItem = "wash";
						waffleMission = 6;
					}
					//characters
					if (panda.hitbox.hitTestObject(tog.eat) && m.talkable && !m.waffling && waffleMission == 5) {
						m.talkable = false;
						m.startEat();
					}
					if (panda.hitbox.hitTestObject(tog.sink) && m.talkable && waffleMission == 6) {
						m.eatSuccess = false;
						holding = false;
						depthOrder();
						next(4);
					}
					if (inner) {
						if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
							m.talk(["I guess I get both top and bottom bunk now!"], "Asako", null, false);
						}
					}
					if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
						m.talk(["Thank god we didn't have to listen to the old woman's investigation."], "Daniel");
					}
					if (panda.hitbox.hitTestObject(tog.engineer) && m.talkable) {
						m.talk(["Did you enjoy the dinner?"], "Engineer");
					}
					if (panda.hitbox.hitTestObject(tog.pengi) && m.talkable) {
						if (waffleMission < 5) {
							m.talk(["You shouldn't let that food go to waste!", "What me? Nah, I prefer fish."], "Pen Quinn");
							waffleMission = 5;
						} else if (waffleMission == 5) {
							m.talk(["If you don't eat it, no one will!"], "Pen Quinn");
						} else if (waffleMission == 6) {
							m.talk(["You should probably wash that dish."], "Pen Quinn");
						}
					}
					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}
					if (panda.hitbox.hitTestObject(tog.ggerald) && m.talkable) {
						m.talk(["Here lies Gerald"], "");
					}

				} else if (tog.currentLabel == "engineer") {
					//murder case
					if (events < 8) {
						if (tog.engineer.hitTestObject(panda.hitbox)) {
							bodyWall2 = true;
						} else {
							bodyWall2 = false;
						}
						if (panda.hitbox.hitTestObject(tog.pengi) && m.talkable) {
							m.talk(["Ahhh! Finally a room for myself. I guess things aren't all bad."], "Pen Quinn");
						}

					} else {
						tog.pengiV.visible = false;
					}
					if (panda.hitTestObject(tog.engineer) && m.talkable && !cut) {
						tog.engineerDead.gotoAndStop(2);
						events = 8;
						bodyWall2 = false;
						m.transition();
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
						m.transition();
					}
					//characters
					if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
						m.talk(["Doesn't it feel... A lot emptier?"], "Daniel");
					}
					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						m.talk(["Well no more murders so far..."], "Asako", null, false);
					}


					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}
					if (panda.hitbox.hitTestObject(tog.ggerald) && m.talkable) {
						m.talk(["Here lies Gerald"], "");
					}
					if (panda.hitbox.hitTestObject(tog.gthomas) && m.talkable) {
						m.talk(["Here lies Thomas"], "");
					}
				} else if (tog.currentLabel == "conducter") {


					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						if (holdItem == "coal") {
							m.talk(["Smart thinking!", "Now go put it in the furnace!"], "Asako", null, false);
						} else {
							m.talk(["It seems like the train is slowing down...", "Hey your hat is kinda like the engineers, so why don't you fix it?"], "Asako", null, false);
						}

					}
					if (panda.hitbox.hitTestObject(tog.daniel) && m.talkable) {
						if (holdItem == "coal") {
							m.talk(["That's what Santa gives me every year for Christmas.."], "Daniel");
						} else {
							m.talk(["The train is running out of steam, and we have no engineer...", "I bet we just need some more charcoal though"], "Daniel");
						}

					}
					if (panda.hitbox.hitTestObject(tog.coalBox) && m.talkable) {
						holdItem = "coal";
						holding = true;
						m.waffleSuccess = false;
					}
					if (panda.hitbox.hitTestObject(tog.engine) && m.talkable && holdItem == "coal" && !m.paused) {
						m.talkable = false;
						m.startValve();
					}
					if (m.valveSuccess) {
						holding = false;
						coalquest = true;
						next(6);
						depthOrder();

					}
					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}
					if (panda.hitbox.hitTestObject(tog.ggerald) && m.talkable) {
						m.talk(["Here lies Gerald"], "");
					}
					if (panda.hitbox.hitTestObject(tog.gthomas) && m.talkable) {
						m.talk(["Here lies Thomas"], "");
					}
					if (panda.hitbox.hitTestObject(tog.gengineer) && m.talkable) {
						m.talk(["Here lies the engineer"], "");
					}

				} else if (tog.currentLabel == "daniel") {
					//murder case
					if (events < 9) {
						if (tog.daniel.hitTestObject(panda.hitbox)) {
							bodyWall = true;
						} else {
							bodyWall = false;
						}

					}
					if (panda.hitTestObject(tog.daniel) && m.talkable && !cut) {
						tog.danielDead.gotoAndStop(2);
						events = 9;
						tog.x = 6315.85;
						panda.x = -5479.8;
						bodyWall = false;
						m.transition();
						depthOrder();
						m.paused = true;
					}
					if (tog.danielDead.currentFrame == 3 && exScene) {
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
						m.transition();
					}
					if (ex2.currentLabel == "life") {
						m.lifeC = 2;
					}
					if (tog.danielDead.currentFrame == 5) {
						m.trainDepart()
						m.transition();
					}

					//m.trainDepart()

					//characters
					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						m.talk(["Hey! You got the train moving again! Good job, Panda!"], "Asako", null, false);
					}
					if (panda.hitbox.hitTestObject(tog.gmarco) && m.talkable) {
						m.talk(["Here lies Marco"], "");
					}
					if (panda.hitbox.hitTestObject(tog.ggerald) && m.talkable) {
						m.talk(["Here lies Gerald"], "");
					}
					if (panda.hitbox.hitTestObject(tog.gthomas) && m.talkable) {
						m.talk(["Here lies Thomas"], "");
					}
					if (panda.hitbox.hitTestObject(tog.gengineer) && m.talkable) {
						m.talk(["Here lies the engineer"], "");
					}

				} else if (tog.currentLabel == "normal") {

					//characters

					if (panda.hitbox.hitTestObject(tog.asako) && m.talkable) {
						if (Main.asakoForgive) {
							m.talk(["Hey panda! Fancy seeing you here again!", "Don't worry I'm done with the whole murder thing!"], "Asako", null, false);
						} else {
							m.talk(["Oh... It's you. I still haven't forgotten about the bamboo...", "It really hurt y'know!"], "Asako", null, false);
						}

					}
					if (panda.hitbox.hitTestObject(tog.engineer) && m.talkable) {
						m.yesno("Are you ready to disembark?");
						m.yesnoCase = 4;

					}

					//events
					if (panda.hitbox.hitTestObject(tog.coalBox) && m.talkable) {
						holdItem = "coal";
						holding = true;
						m.waffleSuccess = false;
						m.brunSuccess = false;
						m.eatSuccess = false;
					}
					if (panda.hitbox.hitTestObject(tog.engine) && m.talkable && holdItem == "coal" && !m.paused) {
						m.talkable = false;
						m.startValve();
					}
					if (panda.hitbox.hitTestObject(tog.waffle) && m.talkable && !m.waffling) {
						m.talkable = false;
						m.startWaffle();
						m.brunSuccess = false;
					}
					if (panda.hitbox.hitTestObject(tog.brunost) && m.talkable && !m.bruning && waffleMission == 2) {
						m.talkable = false;
						m.waffleSuccess = false;
						m.startBrun();
					}
					if (holdItem == "brunost") {
						if ((panda.hitbox.hitTestObject(tog.table1) || (panda.hitbox.hitTestObject(tog.table2))) && m.talkable) {
							m.talkable = false;
							m.startEat();
						}
					}
					if (m.waffleSuccess) {
						holding = true;
						holdItem = "waffle";
						waffleMission = 2;
					}
					if (m.brunSuccess) {
						holding = true;
						holdItem = "brunost";
					}
					if (m.valveSuccess) {
						holding = false;
						m.waffleSuccess = false;
						m.brunSuccess = false;
					}

					if (m.eatSuccess) {
						holding = true;
						holdItem = "wash";
						waffleMission = 6
					}
					if (panda.hitbox.hitTestObject(tog.sink) && m.talkable && waffleMission == 6) {
						m.eatSuccess = false;
						holding = false;
					}

				}


				//objects


				if (panda.hitbox.hitTestObject(tog.trainHorn) && m.talkable && tog.trainHorn.currentFrame == 1) {
					tog.trainHorn.gotoAndPlay(2);
				}





				//same for all frames

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

				/*for (var l: uint = 0; l < tog.numChildren; l++) {
					trace('\t|\t ' + l + '.\t name:' + tog.getChildAt(l).name + '\t type:' + typeof (tog.getChildAt(l)) + '\t' + tog.getChildAt(l));
				}*/

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

						if (Main.downPressed && inner) {
							doors[i].ani.gotoAndPlay(2);
							inner = false;
							fadeIn(tog.t2);
							fadeIn(tog.t2a);
						} else if (Main.upPressed && !inner) {
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

				//events



				//animation

				if (holding) {
					panda.gotoAndStop("hold");
					panda.item.gotoAndStop(holdItem);
				} else {
					panda.gotoAndStop("normal");
					holdItem = null;
				}

				//movement
				//!cut
				if (!m.paused) {
					if (Main.rightPressed && !bodyWall2 && (!rightBumping || !inner && !loco)) {
						player_xRight = speed;
						panda.scaleX = -1;
					} else {
						player_xRight = 0;
					}
					if (Main.leftPressed && !bodyWall && (!leftBumping || !inner && !loco)) {
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
			} else {
				removeSelf();
				trace("removed");
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
		function fadeIn(mc: MovieClip): void {
			TweenLite.to(mc, 1, {
				alpha: 1
			});
		}

		function fadeOut(mc: MovieClip): void {
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
				m.valveSuccess = false;
			}


			exScene = true;
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
		}

		public function removeSelf(): void {
			removeEventListener(Event.ENTER_FRAME, loop);
			m.inTrain = false;
			m.paused = false;
			this.parent.removeChild(this);
		}



	}

}