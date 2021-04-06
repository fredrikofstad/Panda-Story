package Objects {
	
	import flash.display.MovieClip;
	
	
	public class InsideDoor extends Door {
		
		override function loopCode():void {
			if(this.hitTestObject(player.hitbox)){
				this.gotoAndStop("open");
			} else {
				this.gotoAndStop("closed");
			}

		}
		override public function enter(levelselect:int, extra:int = 0):void {
			if(this.hitbox.hitTestObject(player.hitbox)){
				Main.level.changeStage(levelselect, extra);
			}
		}
	}
	
}
