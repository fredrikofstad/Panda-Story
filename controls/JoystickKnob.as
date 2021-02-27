package controls {
     
    import flash.display.MovieClip;
     
    public class JoystickKnob extends MovieClip {       
        private var _origin_x:Number;
        private var _origin_y:Number;       
         
        public function JoystickKnob() {
        }
         
        public function get origin_x():Number {
            return _origin_x;
        }
 
        public function set origin_x(o_x:Number):void {
            _origin_x = o_x;
        }
 
        public function get origin_y():Number {
            return _origin_x;
        }
 
        public function set origin_y(o_y:Number):void {
            _origin_y = o_y;
        }
    }
}