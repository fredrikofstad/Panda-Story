package Levels {

	import NPC.NPC;

	public class Level2 extends LevelClass {
		//flags
		var vent1Flag: Boolean = false;
		var vent2Flag: Boolean = false;

		//exterior
		var downtownInside: Boolean = false;
		var ready: Boolean = true;
		//billboard
		var time = new Date();
		var hour = time.getHours();
		var minuteI = time.getMinutes();
		var minute = String;
		//events
		var timer: int = 0;



		public function Level2() {
			Main.panda.canJump();
		}

		override function loopCode(): void {
			//npc
			if (Progression.flag.ticket < 7) {
				ground.wall2.gotoAndStop(1);
			} else {
				ground.wall2.gotoAndStop(2);
			}
			if (Sakko.touch) {
				if (Progression.flag.ticket < 2) {
					Sakko.say(["Welcome to the bar! We hope you enjoy your stay."], "Sakko", false);
				} else if (Progression.flag.ticket == 2) {
					Sakko.say(["You're looking for a train ticket? You're in luck!", "I actually have one, but I'm unable to go.",
						"Tell you what, if you bring me an icecream I'll give it to ya!"
					], "Sakko", false);
					Progression.flag.ticket = 3;
				} else if (Progression.flag.ticket == 3) {
					Sakko.say(["There's a place selling gelato pretty close by."], "Sakko", false);
				} else if (Progression.flag.ticket == 4) {
					Sakko.say(["Oh! Thank you!", "The ticket is in my apartment, but I'm still on my shift.",
						"If you're in a hurry, I'll give you my key and you can go get it."
					], "Sakko", false, null, "key");
					Progression.flag.ticket = 5;
					Main.panda.holding = null;
					Main.i.removeKeyItem("gelato");
				} else if (Progression.flag.ticket == 5) {
					Sakko.say(["My apartment is over the convenience store", "Take the elevator up to reach it"], "Sakko", false);
				} else {
					Sakko.say(["Hey Panda! How are things?"], "Sakko", false);
				}
			}

			if (Progression.flag.ticket == 5 && Main.i.hasItem("ticket")) {
				Progression.flag.ticket = 6;
			}

			if (Main.panda.holding && !Main.isPaused && Progression.flag.ticket != 4) {
				timer--
				if (timer <= 0) {
					Main.panda.holding = null;
					Main.u.talk.say(["Panda ate the icecream."], "");
					Main.i.removeKeyItem("gelato");
				}
			}
			Mariya.wander();
			Mariya.talk(["Hey Sugar, what's your poison?"], "Mariya", false);
			//door
			door.enter(1, 1);
			//vents
			if (!vent1Flag && vent1HB.hitTestObject(player.hitbox)) {
				vent1.play();
				vent1Flag = true;
			}
			if (!vent2Flag && vent2HB.hitTestObject(player.hitbox)) {
				vent2.play();
				vent2Flag = true;
				Progression.flag.toilclear = true;
			}
			if (Progression.flag.toilclear) {
				ground.wall1.gotoAndStop(2);
			} else {
				ground.wall1.gotoAndStop(1);
			} if (ventExterior.hitTestObject(player.hitbox)) {
				fadeOut(ventExterior);
			} else {
				fadeIn(ventExterior);
			}
			//frigg cutscene
			if (player.hitTestObject(frigg) && Progression.flag.Frigg == 2) {
				frigg.gotoAndStop(2);
				player.halt();
				Progression.flag.Frigg = 3;
				Progression.flag.ticket = 1;
				Main.u.transition();
			}
			if (Progression.flag.Frigg > 3) {
				frigg.visible = false;
			}
			if (frigg.currentFrame == 3) {
				player.resume();
				Progression.flag.Frigg = 4;
			}
			//toilet gang
			if (!Progression.flag.toilclear) {
				george.talk(["Hey, no cutting in line!"]);
				clint.talk(["Back of the line with ya!"]);
				oldMan.talk(["This line is taking forever!"], "Old man");
			} else {
				george.talk(["Oh, I don't have to go to the bathroom", "I'm just here to make friends."]);
				clint.talk(["We're the line gang!"]);
				oldMan.talk(["These blokes are alright!", "The real treasure are the friends you meet in a line."], "Old man");
			}
			//HIMYM
			himym.talk(["Hey Panda, this night is gonna be legen... wait for it..............."], "Group", true, ["Drink with the group?"]);
			if (drunkScene.currentLabel == "done") {
				Main.unpauseGame();
				Main.panda.visible = true;
				himym.say(["...dary...... *hiccup*"], "Group");
				Main.u.transition();
			}

			//downtown
			//elevators

			elevatorDown.down();
			if (!player.riding && Progression.flag.ticket > 4) {
				elevatorUp.up();
			}
			if (elevatorDown.getSignal) {
				elevatorUp.openDoor();
			}
			if (elevatorUp.getSignal) {
				elevatorDown.openDoor();
			}

			//downtown inside
			if (curryDoor.active || gelatoDoor.active || twosonDoor.active || stationDoor.active) {
				if (downtownInside) {
					if (Main.key.down) {
						downtownInside = false;
						downTownExterior.door.play();
					}
				} else {
					if (Main.key.up) {
						downtownInside = true;
						downTownExterior.door.play();
					}
				}
			}
			if (downtownInside) {
				ground.inside.gotoAndStop(2);
				fadeOut(downTownExterior);
				//everything else:
				kanari.talk(["Irasshaimase!", "Welcome to my curry shop!"], "Kanari", false);
				barrista.talk(["Welcome, welcome!"], "Barrista", true, ["Would you like a Gelato?"]);
				if (iceEvent.currentLabel == "done") {
					Main.unpauseGame();
					if (Progression.flag.ticket == 3) {
						Progression.flag.ticket = 4;
					}
					Main.i.keyItemAdd("gelato");
					Main.panda.holding = "gelato";
					timer = 100;
				}
				//train station
				time = new Date();
				hour = time.getHours();
				minuteI = time.getMinutes();
				if (minuteI < 10) {
					minute = String("0" + minuteI);
				} else {
					minute = minuteI;
				}
				if (hour == 23) {
					billboard.timeBox2.text = 0 + ":" + "15";
				} else {
					billboard.timeBox2.text = hour + 1 + ":" + "15";
				}
				billboard.timeBox.text = hour + ":" + minute;
				//in station


				susan.talk(["I heard one of the waitresses at the bar has a spare ticket", "She was supposed to go on a trip with her sister, but has to work", "How sad..."], "Susan", false);
				if (Progression.flag.ticket < 6) {
					mark.talk(["Only customers with a valid ticket can enter the platform"]);
					jack.talk(["You want to go to Mount luna?", "I'm afraid that train is cancelled due to weather conditions.",
						"The train to Winterland is your closest option.", "Speak to the clerk beside me for tickets."
					]);

				} else if (Progression.flag.ticket < 7) {
					mark.talk(["Please check in at the counter."]);
					jack.talk(["Tickets are handled by my colleague on my right."]);
				} else {
					mark.talk(["Everything seems to be in order. Bon voyage!"]);
					jack.talk(["The train is about to depart."]);
				}
				if (sally.touch) {
					if (Progression.flag.ticket == 1) {
						sally.say(["I'm afraid all tickets are sold out at the moment.", "We apologize for any inconvenience"], "Sally", false);
						Progression.flag.ticket = 2;
					} else if (Progression.flag.ticket < 6) {
						sally.say(["Not much I can do without a valid ticket."], "Sally", false);
					} else if (Progression.flag.ticket == 6) {
						sally.say(["Oh! You have a ticket. ", "I'm afraid this ticket is for humans however...",
							"Hmmm, the ticket is valid though...", "Tell you what... You can ride in the storage cart.",
							"It might not be ideal, but we have to consiser the other passengers too.", "Safe travels."
						], "Sally", false);
						Progression.flag.ticket = 7
					} else {
						sally.say(["Safe travels"], "Sally", false);
					}
				}

				//platform
				conductor.talk(["Ello, govna!"], "Train Conductor", true, ["Ready to board the train?"]);
				if (train.currentLabel == "go") {
					Main.level.changeStage(5);
				}

			} else {
				ground.inside.gotoAndStop(1);
				fadeIn(downTownExterior);
				if (!Progression.flag.skateUnlocked) {
					david.talk(["Nice weather we havin', good day for playin'."], "David", true, ["Give the man 1 bit?"]);
				} else {
					david.talk(["Skateboard is all yours, I'm off to new adventures."]);
				}
			} if (Progression.flag.skateUnlocked) {
				if (player.hitTestObject(skateField1) || player.hitTestObject(skateField2)) {
					if (Main.key.space) {
						player.riding = true;
					}
				} else {
					if (player.player_xLeft < 1 && player.player_xRight < 1 && Main.key.space) {
						player.riding = false;
					}
				}
			}
			//skateboard
			if (Progression.flag.skateUnlocked && !player.riding) {
				skateField1.gotoAndStop("there");
				skateField2.gotoAndStop("there");
			} else {
				skateField1.gotoAndStop("gone");
				skateField2.gotoAndStop("gone");
			} if (player.riding && (player.hitbox.hitTestObject(skateDrop2) || player.hitTestObject(skateDrop))) {
				player.riding = false;
				player.slowDown();
			}
			//Osaki
			doorOsaki.enter(6);


		}
		public function startTrain(): void {
			player.halt();
			player.visible = false;
			player.x -= 100;
			train.gotoAndPlay(2);
		}
		public function startIceEvent(): void {
			iceEvent.gotoAndPlay("start");
			Main.pauseGame();
		}
		public function doSkate(): void {
			trace("doSkate");
			Progression.flag.skateUnlocked = true;
			Main.i.takeCoin(1);
			Main.u.transition();
			Main.u.talk.safe = false;
			david.talk(["Thanks panda!", "I'm about to leave town, so you are welcome to my skateboard."]);
		}
		public function getDrunk(): void {
			trace("drinking");
			Main.u.transition();
			Mixer.play.jingle("himym");
			drunkScene.gotoAndPlay("start");
			Main.pauseGame();
			Main.panda.visible = false;
		}
	}

}