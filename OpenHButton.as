package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class OpenHButton extends MovieClip {
		
		/*I created 6 classes for each button class so the code inside 
		each of them is the same, the only things that are different are the instance names
		and variables names, also for each I am embeding a different instrument sample so each button class will play
		a different sound when the alpha is equal to les than one. If alpha of the button class instance is 1 the sound will not play.
		
		I am looping through the tracks arrays in the main class and inside the loop I am also checking for the alpha state of the button
		in each button class*/
		
		
		public var openHSoundArray:Array = new Array();	// array variable that will hold the sound of the button
														// when the button is pressed, alpha is less than 1 and 
														//then the sound will be pushed into the array


		
		[Embed(source = "sounds/HatOpen.mp3")]	//getting the path of the sample and embeding it in the app
			
		public var openHSoundClass:Class;
		
		public var openHSound:Sound = new openHSoundClass() as Sound;
		
		public function OpenHButton()
		{
			// constructor code
			//checkIfBtActive = true;
			this.addEventListener(MouseEvent.CLICK, checkButtonState);		//event listener on this because it is inside the button class
																			//and event listenre will be checking the button state
																			//to see if the button is pressed or not and if its alpha
																			//value is 1 or less than one
		}
		
		public function checkButtonState(event:MouseEvent)
		{
			if (this.alpha == 1)	//by default the alpha value is equal to 1, so if it is one
			{
				this.alpha = 0.5;
				openHSoundArray.push(openHSound);
				trace(openHSoundArray);
				//snareSound.play();
				trace("ButtonActive: " + this.alpha);
				trace(this.parent.name);
				trace(this.name);
				
					//so if the alpha is equal to one then set the alpha of this button to 0.5
					//and also push the sound embeded in the constructor to the sound array which
					//will be used lated for playing the sound for each button. In orded to play 
				 	//the sound I am gonna have the loop in the main class
			}
			
			else if (this.alpha == 0.5)	//if the alpha value is equal to 0.5 when the button was clicked and the value was set
			{
				this.alpha = 1;
				openHSoundArray.splice(0);
				trace(openHSoundArray);
				
				trace("Button Deactivated: " + this.alpha);
				
				//then change the alpha value of the button to 1 
				//and splice(delete) the sound form the soundArray at 1st position (0)
			}
		}
	}
}