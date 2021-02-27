package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.*;

	public class SkiGame extends MovieClip {
		var rockList: Array = new Array();
		var rockSpawnTimeLeft: Number = 10;
		var HP: int = 6;
		var invincibilityTimeLeft: Number;
		var invicounter: Number = 20;
		var isInvincible: Boolean = false;
		var scoreC: Number = 0;
		var lost: Boolean = true;
		var start: Boolean = true;
		var hurt: hurtsound = new hurtsound();
		var snow2: Snow = new Snow(3, 200, false);
		var speed: int = 10;
		var treeSpeed = 8;
		var trees: Array = new Array();

		var panda: PandaSki = new PandaSki;
		var i: int;
		var points: int = 0;
		var kilo: int = 0;

		var pdv: int;

		public var background: Sprite = new Sprite();
		public var layer1: Sprite = new Sprite();
		public var layer2: Sprite = new Sprite();
		public var layer3: Sprite = new Sprite();
		public var layer4: Sprite = new Sprite();
		public var sign: Skisign = new Skisign;
		var cabin: SkiCabin = new SkiCabin;

		public function SkiGame() {
			// constructor code
			createGame();
		}

		function createGame(): void {
			addEventListener(Event.ENTER_FRAME, upDate);
			addChild(sky);
			bgTree(7);
			addChild(cabin);
			addChild(sign);
			addChild(snow2);
			addChild(layer1);
			addChild(panda);
			addChild(layer2);
			addChild(layer3);
			addChild(layer4);
			addChild(hearts);
			addChild(km);
			sky.gotoAndStop("day");

			sign.x = 1000;
			sign.y = 340;

			panda.x = 400;
			panda.y = 580;
			
			cabin.x = 2000;
			cabin.y = 340;

			HP = 6;

		}
		function upDate(e: Event): void {
			
			if(kilo > 48){
				cabin.x -= treeSpeed;
			}
			if(cabin.x < 600){
				removeSelf()
			}
			

			points++
			if (points > 50) {
				kilo++;
				points = 0;
			}
			km.text = String(kilo) + "km";
			//panda
			if (panda.y > 340 && Main.upPressed) {
				panda.y -= speed;
			}
			if (panda.y < 600 && Main.downPressed) {
				panda.y += speed;
			}
			if (panda.x > 200 && Main.leftPressed) {
				panda.x -= speed;
			}
			if (panda.x < 1050 && Main.rightPressed) {
				panda.x += speed;
			}
			//intro
			sign.x -= treeSpeed;
			if (contains(sign)) {
				if (sign.x < -100 && sign) {
					this.removeChild(sign);
				}
			}
			treeMove();
			//obstacles
			rockSpawnTimeLeft--;
			if (rockSpawnTimeLeft < 1) {
				sledRock()
				rockSpawnTimeLeft = 10 + Math.floor(Math.random() * 30);
			}


			if (panda.y < 350) {
				addChildAt(panda, getChildIndex(layer1));
			} else if (panda.y > 350 && panda.y < 425) {
				addChildAt(panda, getChildIndex(layer1)+1);
			} else if (panda.y > 425 && panda.y < 500) {
				addChildAt(panda, getChildIndex(layer2)+1);
			} else if (panda.y > 500 && panda.y < 575) {
				addChildAt(panda, getChildIndex(layer3)+1);
			} else if (panda.y > 575) {
				addChildAt(panda, getChildIndex(layer4)+1);
			}
			//getChildIndex(panda) > getChildIndex(layer1)


			//getting hurt
			if (isInvincible) {
				invincibilityTimeLeft--;
				panda.gotoAndStop("invi");
			} else{
				panda.gotoAndStop("normal");
			}
			
			if (invincibilityTimeLeft < 1) {
				isInvincible = false;
			}
			//health
			if (HP > 0) {
				hearts.gotoAndStop(HP);
			} else {
				removeSelf()
			}
			//obstacles touching

			if (!isInvincible) {
				for (i = 0; i < layer1.numChildren; i++)
					if (panda.hitbox.hitTestPoint(layer1.getChildAt(i).x, layer1.getChildAt(i).y)) {
						gotHit()
					}
				for (i = 0; i < layer2.numChildren; i++)
					if (panda.hitbox.hitTestPoint(layer2.getChildAt(i).x, layer2.getChildAt(i).y)) {
						gotHit()
					}
				for (i = 0; i < layer3.numChildren; i++)
					if (panda.hitbox.hitTestPoint(layer3.getChildAt(i).x, layer3.getChildAt(i).y)) {
						gotHit()
					}
				for (i = 0; i < layer4.numChildren; i++)
					if (panda.hitbox.hitTestPoint(layer4.getChildAt(i).x, layer4.getChildAt(i).y)) {
						gotHit()
					}
			}



			//end of loop
		}
		function gotHit(): void {
			HP -= 1;
			invincibilityTimeLeft = invicounter;
			isInvincible = true;
		}

		function bgTree(amount: int): void {
			var treex: int = 1500;
			var treey: int = 120;
			for (var i: int = 0; i < amount; i++) {
				var tree: Tree = new Tree;
				addChild(tree);
				trees.push(tree);
				tree.x = treex;
				tree.y = treey
				treex += 220 + Math.floor(Math.random() * 80);
				treey += 5;
			}

		}
		function treeMove(): void {
			if (trees.length > 0) {
				for (var j: int = 0; j < trees.length; j++) {
					trees[j].x -= treeSpeed;
					if (trees[j].x < -100) {
						trees[j].x = 1460 + Math.floor(Math.random() * 40);
						trees[j].y = 120 + Math.floor(Math.random() * 40);
					}
				}
			}
		}
		function sledRock(): void {
			var rock: Rock = new Rock(false);
			rockList.push(rock);
			if (rock.unit == 1) {
				layer1.addChild(rock);

			} else if (rock.unit == 2) {
				layer2.addChild(rock);

			} else if (rock.unit == 3) {
				layer3.addChild(rock);

			} else if (rock.unit == 4) {
				layer4.addChild(rock);

			}
			rock.addEventListener(Event.REMOVED, rockRemoved);
		}
		function rockRemoved(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED, rockRemoved);
			rockList.splice(rockList.indexOf(e.currentTarget), 1);
		}




		public function removeSelf(): void {
			MovieClip(root).skiing = false;
			MovieClip(root).cut = false;
			
			removeEventListener(Event.ENTER_FRAME, upDate);
			this.parent.removeChild(this);
		}



	}
}