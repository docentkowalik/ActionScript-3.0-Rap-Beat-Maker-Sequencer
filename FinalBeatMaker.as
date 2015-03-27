package 
{

	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Keyboard;
	import flash.events.SampleDataEvent;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import fl.events.SliderEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.display.Shape;
	import flash.media.*;
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.net.FileReference;
	import flash.geom.Rectangle;


	public class FinalBeatMaker extends MovieClip
	{

		public var currentStep:int = 0;	//var for the current step of the timer
		public var stepTimer:Timer = new Timer(200,16);	//sequencer step timer
		
		public var allTracksArray:Array = new Array();	//this is the array for all the track arrays 
		public var trackArray1:Array = new Array();	//this is the array for all the 1st track array which contains buttons  
		public var trackArray2:Array = new Array();	//this is the array for all the 2nd track array which contains buttons 
		public var trackArray3:Array = new Array();	//this is the array for all the 3rd track array which contains buttons 
		public var trackArray4:Array = new Array();	//this is the array for all the 4th array which contains buttons 
		public var trackArray5:Array = new Array();	//this is the array for all the first track array which contains buttons 
		public var trackArray6:Array = new Array();	//this is the array for all the first track array which contains buttons 

		public var tomSoundChannel:SoundChannel;		//this are the variables for all the 
		public var crashSoundChannel:SoundChannel;		//sound channels. They will be used to play all the sounds 
		public var snareSoundChannel:SoundChannel;		//that are assigned to the buttons inside the tracks arrays
		public var openHSoundChannel:SoundChannel;	
		public var closeHSoundChannel:SoundChannel;
		public var clapSoundChannel:SoundChannel;
		
		public var masterChannel:SoundChannel;	//masterChannel variable will be used for 
												//controlling the master volume using the slider

		public var sTransform:SoundTransform = new SoundTransform();// variable for the cound transsform which is going 
																	//to be used for changing the sound volume

		private var imgLoader:Loader;		//this are the loader variables
		private var cSlide:int;				//which will be used for the sound wave images loaded to the stage
		private var initNumChildren:int;


		
		public var xmlLoader:URLLoader = new URLLoader();	// variables for the xml
		public var mySongList:XML;							
		
		public var song1Sound:Sound;
		public var song2Sound:Sound;				//these are variables for the sounds that are loaded using xml
		public var song3Sound:Sound;				//and also below are the soundchannels for these songs

		public var song1Channel:SoundChannel;
		public var song2Channel:SoundChannel;
		public var song3Channel:SoundChannel;
		
		public var dragging:Boolean=false;    						//this if the variable forthe bounding box which is a wrappoer for
        public var boundingBox:Rectangle = new Rectangle(0,0,100,0);//the custom slider I created
		


		public function FinalBeatMaker()
		{
			// constructor code

/*Here I will be creating six arrays for each track and then I will pass all of the buttons which are contained in the track symbol 
into the arrays, so later I could loop through the track array and check if the button oppacity is set to alpha
and if it is then it will play the sound*/

			trackArray1 = new Array(tomTrack.tom_1, tomTrack.tom_2, tomTrack.tom_3, tomTrack.tom_4,	
			tomTrack.tom_5, tomTrack.tom_6, tomTrack.tom_7, tomTrack.tom_8,
			tomTrack.tom_9, tomTrack.tom_10, tomTrack.tom_11,tomTrack.tom_12,
			tomTrack.tom_13, tomTrack.tom_14, tomTrack.tom_15, tomTrack.tom_16);					

			trackArray2 = new Array(crashTrack.crash_1, crashTrack.crash_2, crashTrack.crash_3, crashTrack.crash_4,
			crashTrack.crash_5, crashTrack.crash_6, crashTrack.crash_7, crashTrack.crash_8,
			crashTrack.crash_9, crashTrack.crash_10, crashTrack.crash_11, crashTrack.crash_12,
			crashTrack.crash_13, crashTrack.crash_14, crashTrack.crash_15, crashTrack.crash_16);

			trackArray3 = new Array(snareTrack.snare_1, snareTrack.snare_2, snareTrack.snare_3, snareTrack.snare_4,
			snareTrack.snare_5, snareTrack.snare_6, snareTrack.snare_7, snareTrack.snare_8,
			snareTrack.snare_9, snareTrack.snare_10, snareTrack.snare_11, snareTrack.snare_12,
			snareTrack.snare_13,snareTrack.snare_14,snareTrack.snare_15, snareTrack.snare_16);

			trackArray4 = new Array(openHTrack.openH_1, openHTrack.openH_2, openHTrack.openH_3, openHTrack.openH_4,
			openHTrack.openH_5, openHTrack.openH_6, openHTrack.openH_7, openHTrack.openH_8,
			openHTrack.openH_9, openHTrack.openH_10, openHTrack.openH_11, openHTrack.openH_12,
			openHTrack.openH_13, openHTrack.openH_14, openHTrack.openH_15, openHTrack.openH_16);

			trackArray5 = new Array(closeHTrack.closeH_1,closeHTrack.closeH_2, closeHTrack.closeH_3, closeHTrack.closeH_4,
			closeHTrack.closeH_5, closeHTrack.closeH_6, closeHTrack.closeH_7, closeHTrack.closeH_8,
			closeHTrack.closeH_9, closeHTrack.closeH_10, closeHTrack.closeH_11, closeHTrack.closeH_12,
			closeHTrack.closeH_13, closeHTrack.closeH_14,closeHTrack.closeH_15, closeHTrack.closeH_16);

			trackArray6 = new Array(clapTrack.clap_1, clapTrack.clap_2, clapTrack.clap_3, clapTrack.clap_4,
			clapTrack.clap_5, clapTrack.clap_6, clapTrack.clap_7, clapTrack.clap_8,
			clapTrack.clap_9, clapTrack.clap_10, clapTrack.clap_11, clapTrack.clap_12,
			clapTrack.clap_13, clapTrack.clap_14, clapTrack.clap_15, clapTrack.clap_16);
/*this is the end of creating six arrays for the six tracks that contain the buttons*/



			allTracksArray = new Array(trackArray1,trackArray2,trackArray3,trackArray4,trackArray5,trackArray6);
			//all trackarray is will be used for looping through tracksArrays and also I will loop through each tracks array 
			//to check for the button alpha (looping througn array of arrays)

			

			playBeatButton.addEventListener(MouseEvent.CLICK, kickTimer);	//event listener for the master play button
			stopPlay.addEventListener(MouseEvent.CLICK, stopSequencer);		//event listener for the master stop button
			pauseBtn.addEventListener(MouseEvent.CLICK, pausePlay);			//event listener for the master pause button

			loopBtnOn.addEventListener(MouseEvent.CLICK, loopTimer);		//event listener for the master loopOn button
			loopBtnOff.addEventListener(MouseEvent.CLICK, loopOff);			//event listener for the master loopOff button

			selMusic.addEventListener(MouseEvent.CLICK, musicSelection);	//event listener for the music selection button

			stepTimer.addEventListener(TimerEvent.TIMER, timerStep);		//event listener on the timer for the steps

			popUp.s1.addEventListener(MouseEvent.CLICK, playS1);		//event listener for music 1 button
			popUp.s2.addEventListener(MouseEvent.CLICK, playS2);		//event listener for music 2 button
			popUp.s3.addEventListener(MouseEvent.CLICK, playS3);		//event listener for music 3 button

			imgLoader = new Loader();
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,imageLoaded);

			pauseBtn.visible = false;
			playBeatButton.visible = true;
			popUp.visible = false;
			loopBtnOff.visible = false;
			volume_value.text = "50";

			cSlide = 1;
			initNumChildren = this.numChildren;

			xmlLoader.addEventListener(Event.COMPLETE, fileLoaded);
			popUp.s1.addEventListener(MouseEvent.CLICK, playSong1);
			popUp.s2.addEventListener(MouseEvent.CLICK, playSong2);
			popUp.s3.addEventListener(MouseEvent.CLICK, playSong3);
			mute.addEventListener(MouseEvent.CLICK, muteTrack);

			var fileURL:URLRequest = new URLRequest("playlist.xml");	// url request to tolad the xml playlist
			xmlLoader.load(fileURL);
			
			
			slider_mc.knob_mc.addEventListener(MouseEvent.MOUSE_DOWN, dragKnob);    
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseKnob);    
			slider_mc.knob_mc.buttonMode=true;    

			NativeApplication.nativeApplication.addEventListener( Event.EXITING, handleDeactivate );
}



		public function handleDeactivate(event:Event):void
		{
			event.stopImmediatePropagation();
			NativeApplication.nativeApplication.exit();
		}

		function fileLoaded(e:Event):void
		{
			// Load up the XML
			var theXML:XML = new XML(e.target.data);	// new variable to store the xml data form the xml file

			mySongList = theXML;			//passing the xml into the songlist variable

			// Let's trace out some of it
			trace(theXML);
			trace("-------------------");
			trace(theXML.song[0].@artist);
			trace("-------------------");
			trace(theXML.song[1].@artist);
			trace("-------------------");
			trace(theXML.song[2].@artist);

			trace("-------------------");
			//trace(theXML.song[0]);
		}
		
		function playSong1(event:MouseEvent):void
		{
			/*this is the function for the first music button firstly it changes the step 
			timer delay property so the timer will match the tempo of the melody selected
			then it is getting the song at first position in the xml file and get the name of the song and
			passes it into the myTitle variable, also it is getting the song artist and url and passing it into its own variables.
			
			the next step is to display the name of the song and the artist in the artist name and song title dynamic fields
			
			the last step is to load the sound and passing it into the song 1 variable. To load get the path I am using the url variable
			that holds the path form the xml file.
			
			Also the step timer is stopped when the song is loaded so you will have to press master play again in order
			to start the timer
			
			the same method will apply to the following two functions for music2 and music3*/
			stepTimer.delay = 290;
			var myTitle = mySongList.song[0]. @ songName;
			var myArtist = mySongList.song[0]. @ artist;
			var myURL = mySongList.song[0]. @ url;
			
			artist_name.text = myArtist;
			song_title.text = myTitle;
			

			song1Sound = new Sound();
			song1Sound.load(new URLRequest(myURL));
			stepTimer.stop();
		}

		function playSong2(event:MouseEvent):void
		{
			stepTimer.delay = 270;

			var myTitle = mySongList.song[1]. @ songName;
			var myArtist = mySongList.song[1]. @ artist;
			var myURL = mySongList.song[1]. @ url;
			
			artist_name.text = myArtist;
			song_title.text = myTitle;
	
			
			song2Sound = new Sound();
			song2Sound.load(new URLRequest(myURL));
			stepTimer.stop();
		}

		function playSong3(event:MouseEvent):void
		{
			stepTimer.delay = 350;

			var myTitle = mySongList.song[2]. @ songName;
			var myArtist = mySongList.song[2]. @ artist;
			var myURL = mySongList.song[2]. @ url;
			
			artist_name.text = myArtist;
			song_title.text = myTitle;

			
			song3Sound = new Sound();
			song3Sound.load(new URLRequest(myURL));
			stepTimer.stop();
		}

		function pausePlay(event:MouseEvent):void
		{
			/*this function pauses the timer and also checking if any of the 3 sounchannels for the background music are playing
			and if they are playing it will stop them form playing*/
			playBeatButton.visible = true;
			pauseBtn.visible = false;
			stepTimer.stop();
			
			if (song1Channel)
			{
				song1Channel.stop();
			}

			if (song2Channel)
			{
				song2Channel.stop();
			}

			if (song3Channel)
			{
				song3Channel.stop();
			}			
		}

		function kickTimer(event:MouseEvent):void
		{
			/*kick timer function is for the play button so it starts the step timer and also checks if anny of 
			the 3 music songs are loaded from xml and if any one of the songs is loaded it will play the song
			.play(0,100) - 100 value is a value that will loop the song 100 times. I had to use it because the music I used 
			if a short sample and it has to constantly play untill the pause or stop button is pressed or another song is loaded.*/
			stepTimer.start();
			pauseBtn.visible = true;


			if(artist_name.text == "Tupac feat. Dr.Dre" )
			{
				song1Channel = song1Sound.play(0,100);
				stepTimer.start();
			}	
			
			if(artist_name.text == "Dr.Dre" )
			{
				song2Channel = song2Sound.play(0,100);
				stepTimer.start();
			}
					
			if(artist_name.text == "Unknown Artist" )
			{
				song3Channel = song3Sound.play(0,100);
				stepTimer.start();
			}
		}
		
		function loopTimer(event:MouseEvent):void
		{
			/*this function is use to chenge the visibility of all the buttons below and the alpha of the loop 
			button off that will become visible when the loop button on is pressed,
			also when the loop button is pressed it will check the music in the background for playing
			anf if the music is playing it will stop it*/
			loopBtnOn.visible = false;
			loopBtnOff.visible = true;
			loopBtnOff.alpha = 0.6;
			pauseBtn.visible = false;
			playBeatButton.visible = true;
							
							if(song1Channel)
							{
							song1Channel.stop();
							}
							
							if(song2Channel)
							{
							song2Channel.stop();
							}
							
							if(song3Channel)
							{
							song3Channel.stop();
							}
		}
		
		function loopOff(event:MouseEvent):void
		{
			/*when you press the loop button off to turn off the loop of the timer it will make loop button on visible,
			loop button off invisible and set its alpha to 0.9*/
			loopBtnOn.visible = true;
			loopBtnOff.visible = false;
			loopBtnOff.alpha = 0.9;	
		}

		function timerStep(event:TimerEvent):void
		{
			/*this is the timer function that will increment the current step based on the timer runs*/
			currentStep++;
			trace("Timer" + currentStep);

/*this if statements are used for the playhead, so in the design I have dots for each step and for each 
step the dot at the current step will change its alpha to 0.2 and if the current step increments by one it changes the alpha of 
that dot back to 1   */
			if (stepTimer.currentCount == 1)
			{
				indi_16.alpha = 1;
				indi_1.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 2)
			{
				indi_1.alpha = 1;
				indi_2.alpha = 0.2;
			}
			
			if (stepTimer.currentCount == 3)
			{
				indi_2.alpha = 1;
				indi_3.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 4)
			{
				indi_3.alpha = 1;
				indi_4.alpha = 0.2;
			}
			
			if (stepTimer.currentCount == 5)
			{
				indi_4.alpha = 1;
				indi_5.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 6)
			{
				indi_5.alpha = 1;
				indi_6.alpha = 0.2;
			}
			
			if (stepTimer.currentCount == 7)
			{
				indi_6.alpha = 1;
				indi_7.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 8)
			{
				indi_7.alpha = 1;
				indi_8.alpha = 0.2;
			}
			
			if (stepTimer.currentCount == 9)
			{
				indi_8.alpha = 1;
				indi_9.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 10)
			{
				indi_9.alpha = 1;
				indi_10.alpha = 0.2;
			}
			
			if (stepTimer.currentCount == 11)
			{
				indi_10.alpha = 1;
				indi_11.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 12)
			{
				indi_11.alpha = 1;
				indi_12.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 13)
			{
				indi_12.alpha = 1;
				indi_13.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 14)
			{
				indi_13.alpha = 1;
				indi_14.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 15)
			{
				indi_14.alpha = 1;
				indi_15.alpha = 0.2;
			}
			
			else if (stepTimer.currentCount == 16 )
			{
				indi_15.alpha = 1;
				indi_16.alpha = 0.2;
			}

/*here is the for loop that loops throug the array of arrays and checks for the alpha of the button and also
checks the current step of the step timer.

variable a has only one track array and I had to make it 0 and less than 1 to get only the first track and loop through it.

so first line is looping through the first track array which is inside all tracks array and then the if 
statement is used to loop through all tracksarray and get the first 
track array, then it is checking the timer current count to check at which step the timer is and also it is checking
the alpha value of the buttons that are inside the first track array. and if the alpha value is less than 1
it will pass the sound that is embeded in the button class into the tomSoundChannel and it will play that sound.

the same logic applies to the next 6 for loops
*/
			for (var a =0; a < 1; a++)
			{
				if (allTracksArray[a][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play tom " + stepTimer.currentCount);
					tomSoundChannel = allTracksArray[a][stepTimer.currentCount - 1].tomSoundArray[0].play();
				}
			}

			for (var b =1; b < 2; b++)
			{
				if (allTracksArray[b][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play crash " + stepTimer.currentCount);
					crashSoundChannel = allTracksArray[b][stepTimer.currentCount - 1].crashSoundArray[0].play();
				}
			}

			for (var c =2; c < 3; c++)
			{
				if (allTracksArray[c][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play crash " + stepTimer.currentCount);
					snareSoundChannel = allTracksArray[c][stepTimer.currentCount - 1].snareSoundArray[0].play();
				}
			}
			
			for (var d =3; d < 4; d++)
			{
				if (allTracksArray[d][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play crash " + stepTimer.currentCount);
					openHSoundChannel = allTracksArray[d][stepTimer.currentCount - 1].openHSoundArray[0].play();
				}
			}
			
			for (var e =4; e < 5; e++)
			{
				if (allTracksArray[e][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play crash " + stepTimer.currentCount);
					closeHSoundChannel = allTracksArray[e][stepTimer.currentCount - 1].closeHSoundArray[0].play();
				}
			}
			
			for (var f =5; f < 6; f++)
			{
				if (allTracksArray[f][stepTimer.currentCount - 1].alpha < 1)
				{
					trace("play crash " + stepTimer.currentCount);
					clapSoundChannel = allTracksArray[f][stepTimer.currentCount - 1].clapSoundArray[0].play();
				}
			}
			
			
			if (currentStep == 16 && loopBtnOff.visible == true)		//if statement used to check if the current step is 16 and if
			{															//the loop button off is visible the timer will reset
				trace('reset');											//and start again in order to loop
				stepTimer.reset();
				currentStep = 0;
				stepTimer.start();
				indi_16.alpha = 0.2;
			}
			
			else if (currentStep == 16 && loopBtnOn.alpha == 1)			//but if the loop button on alpha is 1 and the current step is 16 it will
			{															//not loop
				stepTimer.reset();
				currentStep = 0;
				trace('only reset');
			}
		}

		function playS1(event:MouseEvent)
		{
			trace("song1");
			popUp.s1.alpha = 0.6;
			popUp.s2.alpha = 1;
			popUp.s3.alpha = 1;

			selMusic.alpha = 1;
			popUp.visible = false;
			loadImg1();
			
			playBeatButton.visible = true;
			pauseBtn.visible = false;


			if (song2Channel)
			{
				song2Channel.stop();
			}
			
			if (song3Channel)
			{
				song3Channel.stop();
			}
		}
		
		function playS2(event:MouseEvent)
		{
			trace("song2");
			popUp.s1.alpha = 1;
			popUp.s2.alpha = 0.6;
			popUp.s3.alpha = 1;

			selMusic.alpha = 1;
			popUp.visible = false;
			loadImg2();
			
			playBeatButton.visible = true;
			pauseBtn.visible = false;

			
			if (song1Channel)
			{
				song1Channel.stop();
			}
			
			if (song3Channel)
			{
				song3Channel.stop();
			}
		}
		
		function playS3(event:MouseEvent)
		{
			trace("song3");
			popUp.s1.alpha = 1;
			popUp.s2.alpha = 1;
			popUp.s3.alpha = 0.6;

			selMusic.alpha = 1;
			popUp.visible = false;
			loadImg3();
			
			playBeatButton.visible = true;
			pauseBtn.visible = false;

			
			if (song1Channel)
			{
				song1Channel.stop();
			}
			
			if (song2Channel)
			{
				song2Channel.stop();
			}
		}

		function musicSelection(event:MouseEvent):void
		{
			selMusic.alpha = 0.6;
			popUp.visible = true;
		}


/*load image functions are used for loading the sound waves images for every music */
		function loadImg1()
		{
			var imgReq1:URLRequest = new URLRequest("waves/1.jpg");
			imgLoader.load(imgReq1);
		}
		
		function loadImg2()
		{
			var imgReq2:URLRequest = new URLRequest("waves/2.jpg");
			imgLoader.load(imgReq2);
		}
		
		function loadImg3()
		{
			var imgReq3:URLRequest = new URLRequest("waves/3.jpg");
			imgLoader.load(imgReq3);
		}

		function imageLoaded(e:Event):void
		{
			var image1:Bitmap = imgLoader.contentLoaderInfo.content as Bitmap;
			imgCont.addChild(image1);//image container which is on the stage and i am adding child which is an image

			var image2:Bitmap = imgLoader.contentLoaderInfo.content as Bitmap;
			imgCont.addChild(image2);//image container which is on the stage and i am adding child which is an image

			var image3:Bitmap = imgLoader.contentLoaderInfo.content as Bitmap;
			imgCont.addChild(image3);//image container which is on the stage and i am adding child which is an image
		}
		
		function muteTrack (event:MouseEvent):void 
		{
				 if(mute.alpha == 1)//checking if mute button alpha value is 1
				{//if it is then for of 3 songs sound channel if is playing set the volume to 1 so it is the full volume
					if(song1Channel)
					{
				    	var transform1:SoundTransform = song1Channel.soundTransform; 	//creating var transform1 of type sound transform 
				    	transform1.volume = 1;											// which will transform the audio(volume)
				   		song1Channel.soundTransform = transform1;						//then setting volume number to 1
					}																	//and for selected song channel transform the volume
					
					if(song2Channel)
					{
						var transform2:SoundTransform = song2Channel.soundTransform;
						transform2.volume = 1;
						song2Channel.soundTransform = transform2;
					}
					
					if(song3Channel)
					{
						var transform3:SoundTransform = song3Channel.soundTransform;
						transform3.volume = 1;
						song3Channel.soundTransform = transform3;
					}
				}
				
				else if(mute.alpha == 0.5) //but if the button was pressed and the alpha value is 0.5
			
				{//then set the volume to 0 for every channel that is playing
					if(song1Channel)
					{
						var transform4:SoundTransform = song1Channel.soundTransform;
				    	transform4.volume = 0;
				    	song1Channel.soundTransform = transform4;
				}
					
					if(song2Channel)
					{
						var transform5:SoundTransform = song2Channel.soundTransform;
						transform5.volume = 0;
						song2Channel.soundTransform = transform5;
					}
										
					if(song3Channel)
					{
							var transform6:SoundTransform = song3Channel.soundTransform;
						transform6.volume = 0;
						song3Channel.soundTransform = transform6;
					}
				}
			}
	
	
	
	/*next 3 functions are for the slider and here is the explanation
	
	The startDrag method takes two arguments (the parameters
	inside the parentheses). The first controls the whether the cursor stays locked to the center of 
	the dragged movie clip (true) or to the point where the click 
	initially happened (false), The second argument specifies the 
	bounding area of the drag and takes an instance of a rectangle 
	object to do that. I created the rectangle earlier called boundingBox 

	I also changed the value of "dragging" to true the reason we do this will become clear in the next function.

a new event listener is added to the knob. This listener is an ENTER_FRAME 
listener, which means it runs every frame while the dragKnob unction is running.
Basically for every frame in which the knob is being dragged, the adjustVolume function is called.*/
	function dragKnob(event:MouseEvent):void 
	{ 
    	slider_mc.knob_mc.startDrag(false, boundingBox); 
    	dragging=true; 
    	slider_mc.knob_mc.addEventListener(Event.ENTER_FRAME, adjustVolume);    
		slider_mc.knob_mc.x = 50;
		/*this is the function for the slider
		because it is a custom made slider i had to use start drag method on the knob which is the controller*/
	}    

	function releaseKnob(event:MouseEvent):void 
	{ 
   		 if (dragging) 
		 { 
        	slider_mc.knob_mc.stopDrag(); 
        	dragging=false; 
    }    
}    

/*I creates a variable called myVolume 
and fill it with a number from zero to 1.
That number is generated by dividing the x 
position of the knob by mySliderLength 
(the width of the bounding box and the maximum possible amount for x*/

	function adjustVolume(event:Event):void 
	{
	    var myVolume:Number=slider_mc.knob_mc.x/100; 
		volume_value.text = slider_mc.knob_mc.x;

		sTransform.volume = myVolume;
		SoundMixer.soundTransform = sTransform;
	}

	function stopSequencer(event:MouseEvent):void
	{
		
		/*in this last function which stops the sequencer I am resetiing the alpha values of all step indicators
		when the stop button is pressed
		
		then I am checking if any of 3 possible background music is playing, and if it is I am stopping the sound playing
		
		then reseting all the button visibility, alpha etc. to what it was at the start when the ap was open first, I am also stopping the timer 
		so it doesn't play the step sound anymore
		
		finally I am looping through the all track array to check if the button alpha value in each track is les than 1
		and if it is I am reseting it back to 1*/
			indi_1.alpha = 1;	indi_2.alpha = 1;	indi_3.alpha = 1;	indi_4.alpha = 1;	indi_5.alpha = 1;	
			indi_6.alpha = 1;	indi_7.alpha = 1;	indi_8.alpha = 1;	indi_9.alpha = 1;	indi_10.alpha = 1;
			indi_11.alpha = 1;	indi_12.alpha = 1;	indi_13.alpha = 1;	indi_14.alpha = 1;	indi_15.alpha = 1;
			indi_16.alpha = 1;
	
	
							if(song1Channel)
							{
								song1Channel.stop();
							}
							
							if(song2Channel)
							{
								song2Channel.stop();
							}
							
							if(song3Channel)
							{
								song3Channel.stop();
							}
							
							
			playBeatButton.visible = true;
			pauseBtn.visible = false;
			loopBtnOn.alpha = 1;
			mute.alpha = 1;
			stepTimer.stop();
			stepTimer.reset();
			currentStep = 0;

			for (var row:int =0; row < 6; row++)
			{
				for (var col:int = 0; col<16; col++)
				{
					if (allTracksArray[row][col].alpha < 1)
					{
						trace("reset alpha");
						allTracksArray[row][col].alpha = 1;
					}
				}
			}
		}
	}
}