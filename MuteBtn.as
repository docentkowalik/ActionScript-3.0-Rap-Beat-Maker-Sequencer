package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	
	public class MuteBtn extends MovieClip {
		
/*this is the class for mute button which will mute currently loaded and playing melody when the mute button is
pressed and its alpha if 0.5. When the mute button is clicked again its value goes back to 1 and the melody will be unmuted*/
		
		public function MuteBtn()
		{
			// constructor code
			//checkIfBtActive = true;
			this.addEventListener(MouseEvent.CLICK, checkButtonState);
		}
		
		public function checkButtonState(event:MouseEvent)
		{
			if (this.alpha == 1)
			{
				this.alpha = 0.5;		//change alpha value to 0.5
				this.gotoAndStop(2);	// going to the seccond frame on the symbo timeline to display a different(muted graphic)
			}							//for the button
			else if (this.alpha == 0.5)
			{
				this.alpha = 1;					//change alpha value back to 1
				this.gotoAndStop(1);			//go back to frame 1 on the symbol timeline to the (unmuted graphic) of the button
			}
		}
	}
}