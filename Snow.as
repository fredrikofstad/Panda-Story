package {	import flash.display.MovieClip	import flash.events.Event;	import flash.utils.Timer;	import flash.events.TimerEvent;
			public class Snow extends MovieClip	{		private var flakesVector:Vector.<MovieClip> = new Vector.<MovieClip>();		private var timer:Timer = new Timer(2000);
		var mainTimeLine = MovieClip(root);
		var change: Boolean = true;				public function Snow(speed:int = 3, flakesNumber = 200, adjust:Boolean = true):void		{
			if (!adjust){change = false} 			for(var i:int = 0; i < flakesNumber; i++)			{				var flake:Snowflake = new Snowflake();								flake.vel = (Math.random() * speed) + 0.5;				flake.xSpeed = Math.floor(Math.random() * (0.5 - -0.5 + 1)) + -0.5;								flake.scaleX = (Math.random() * 1) + 0.3;				flake.scaleY = flake.scaleX;				flake.x = Math.random() * 1280;				flake.y = Math.random() * 720;								addChild(flake);								flakesVector.push(flake);			}						addEventListener(Event.ENTER_FRAME, fall);			timer.addEventListener(TimerEvent.TIMER, changeMovement);			timer.start();		}				private function fall(e:Event):void		{
			mainTimeLine = MovieClip(root);
			for(var i:int = 0; i < flakesVector.length; i++)			{				flakesVector[i].x += flakesVector[i].xSpeed;
				if(change){				flakesVector[i].y += flakesVector[i].vel - Main.player_y/2;				} else {
				flakesVector[i].y += flakesVector[i].vel
				}				if(flakesVector[i].y > Main.getStage().stageHeight-200)				{					flakesVector[i].x = Math.random() * Main.getStage().stageWidth;					flakesVector[i].y = -flakesVector[i].height;				}			}		}				private function changeMovement(e:TimerEvent):void		{			for(var i:int = 0; i < flakesVector.length; i++)			{				flakesVector[i].xSpeed *= -1;			}		}	}}		