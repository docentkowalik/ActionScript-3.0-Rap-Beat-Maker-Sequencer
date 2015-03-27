package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.system.Security;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.events.MouseEvent;
	import flash.events.ActivityEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

/*this is the microphone class used for recording, playing and stopping the recording*/

	public class RecordingSound extends MovieClip
	{

		private var mic:Microphone;							// creating new variable for the microphone of type Microphone
		private var soundBytes:ByteArray;					//ByteArray for storing the recorded data
		private var soundMic:Sound;							//sounchannel for playback
		private var micSoundChannel:SoundChannel;			//and the timer for the recording seconds count
		public var currentStep:int = 0;
		public var clocksaTimer:Timer = new Timer(1000);


		public function RecordingSound()
		{
			micSoundChannel = new SoundChannel();
			soundMic = new Sound();
			soundBytes  = new ByteArray();
			mic = Microphone.getMicrophone();
			mic.setSilenceLevel(5, 1000);
			mic.gain = 70;//0 to 100
			mic.rate = 44;

			activityMC.visible = false;		//this are the two indicator bars to visualize the sound being processed 
			activityMC1.visible = false;	//by the microphone in real time and they are set to invisible at the start
											

			recBar.counter.visible = false;	//this a an instance name of a dynamic text for displaying the recording time
			stopRecAudio.visible = false;		//stop playback button set fo invisible
			playButton.visible = false;			//start playback button set to invisible at the start
			loopPlaybackRec.visible = false;	//loop playback button set to invisible
			stopLoopPlayback.visible = false;	//and stop playback button set to invisible
												//the reason for doing this is that they are invisible at the start but when the user
												//presses the start recording button they will switch to visible
												//in order to allow user to play the recording.
			

			switch_playRecord.visible = false;

			micButton.addEventListener(MouseEvent.CLICK, startRecording);
			playButton.addEventListener(MouseEvent.CLICK, startPlayback);
			stopRecAudio.addEventListener(MouseEvent.CLICK, stopRec);
			loopPlaybackRec.addEventListener(MouseEvent.CLICK, loopPlayback);
			stopLoopPlayback.addEventListener(MouseEvent.CLICK, stopPlayback);

			addEventListener(Event.ENTER_FRAME, onFrame);
			clocksaTimer.addEventListener(TimerEvent.TIMER,checkTime);

		}
		
		private function onFrame(e:Event)
		{
			if (mic.activityLevel > 0)
			{
				activityMC.maskMC.scaleY = mic.activityLevel / 100;
				activityMC1.maskMC.scaleY = mic.activityLevel / 100;
			}
			
			/*I am using the mic activitylevel to update the indicator bars position, for that purpose I am using the
			enter frame event*/
		}
		
		private function startRecording(e:MouseEvent)
		{
			clocksaTimer.start();			
			recBar.counter.visible = true;	
			stopRecAudio.visible = true;	
			recBar.rec_txt.text = "Recording...";
			recBar.counter.text = "00:00";
			currentStep = 0;


			activityMC.visible = true;
			activityMC1.visible = true;

			soundBytes  = new ByteArray();
			mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micRecord);
			
			/*in this function I am setting eve*/
		}
		
		private function startPlayback(e:MouseEvent)
		{
			stopRecAudio.visible = false;
			activityMC.visible = false;
			activityMC1.visible = false;
			recBar.rec_txt.text = "Your Recording";
			playButton.visible = false;
			stopLoopPlayback.visible = true;

			switch_playRecord.visible = true;

			soundBytes.position = 0;
			soundMic.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);

			
			micSoundChannel = soundMic.play();
			micSoundChannel.addEventListener( Event.SOUND_COMPLETE, micPlaybackComplete );
		}
		
		private function micRecord(e:SampleDataEvent)
		{
			while (e.data.bytesAvailable)
			{
				var sample:Number = e.data.readFloat();
				soundBytes.writeFloat(sample);
			}
		}
		
		function playbackSampleHandler(e:SampleDataEvent):void
		{
			for (var i:int = 0; i < 8192 && soundBytes.bytesAvailable > 0; i++)
			{
				var sample:Number = soundBytes.readFloat();
				e.data.writeFloat(sample);
				e.data.writeFloat(sample);
				//write the data twice because there are 2 channels (stereo)
			}
		}

		public function loopPlayback(event:MouseEvent):void
		{
			loopPlaybackRec.alpha = 0.5;
			//setting loop button alpha to 0.5 when is pressed
		}
			
		public function stopPlayback(event:MouseEvent):void
		{
			micPlaybackComplete(null);
			playButton.visible = true;

			switch_playRecord.visible = false;
			
			if (loopPlaybackRec.alpha <1)
			{
				loopPlaybackRec.alpha = 1;
			}
			/*function used  to stop playback of the recording. in order to do this I am calling the micPlaybackComplete function
			and reseting the play button to be visible, and the loop button alpha to 1 to be used again*/
		}
		
		private function micPlaybackComplete(e:Event)
		{
			soundMic.removeEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
			playButton.visible = true;

			switch_playRecord.visible = false;
			
			if (loopPlaybackRec.alpha <1)
			{
				startPlayback(null);
			}
			
			/*this function was called by the SoundComplete event and it is used to check if the recording playback is completed and
			if it is the play button is set to visible so you can play the recording again,
			and if  statement checks if the loop button is pressed and its alpha value is less than 1 and if it is start playback 
			function is called and the recording playback will loop*/
		}

		function stopRec(event:MouseEvent)
		{
			mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micRecord);
			mic.setLoopBack(false);
			clocksaTimer.stop();
			activityMC.visible = false;
			activityMC1.visible = false;
			playButton.visible = true;
			loopPlaybackRec.visible = true;
			/*this function is used to stop the recording when the stop recording button is pressed
			and then it will display the play recording button, stop playback button and also the play recording in loop button
			it also removes the SampleData event fro the recorder so it will prevent microphone activity in the background
			even if it is not recording*/
		}

		function checkTime(event:TimerEvent):void
		{
			currentStep++;
			recBar.counter.text = currentStep + ":00";
			
			/*in this function I am using the timer to update the time of the recording that has passed. 
			For this I have the timer set to run every second and by getting the currentStep value which is incremented by the 
			timer I am passing the value to the recBar.counter which is the dynamic field and it will display the value in seconds */
		}
	}
}