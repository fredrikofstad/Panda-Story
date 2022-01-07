package Objects {
	
	import flash.display.MovieClip;
	
	
	public class Tree extends MovieClip {
		
		
		public function Tree() {
			gotoAndStop(1);
		}
		public function change(frame:int):void{
			gotoAndStop(frame);
		}
	}
	
}
