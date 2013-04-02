package com.mictalk.logic
{
	import com.mictalk.mgr.MicTalkMgr;
	
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;

	public class MicTalk
	{
		private static const BYTES_PER_SAMPLE:int = 1024;
		private var _mic:Microphone;
		private var _recordBytes:ByteArray;
		private var _snd:Sound;
		private var _sc:SoundChannel;
		private var _file:File;
		
		public function MicTalk()
		{
			_mic = MicTalkMgr.instance.mic;
			_recordBytes = new ByteArray();
			_file = File.documentsDirectory.resolvePath("mic_talk");
		}
		
		public function startRecord():void
		{
			trace("start record");
			_recordBytes.clear();
			_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);
		}
		
		protected function onSampleDataHandler(event:SampleDataEvent):void
		{
			while(event.data.bytesAvailable)
			{
				var smp:Number = event.data.readFloat();
				_recordBytes.writeFloat(smp);
			}
		}
		
		public function stopRecord():void
		{
			trace("stop record");
			_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);
		}
		
		public function playFile(bytes:ByteArray = null):void
		{
			trace("play file");
			if(bytes != null)
			{
				_recordBytes.clear();
				_recordBytes = bytes;
			}
			_snd = new Sound();
			_recordBytes.position = 0;
			_snd.addEventListener(SampleDataEvent.SAMPLE_DATA, onPlayBack);
			_sc = _snd.play();
			_sc.addEventListener(Event.SOUND_COMPLETE, onPlayBackComplete);
		}
		
		protected function onPlayBackComplete(event:Event):void
		{
			_sc.removeEventListener(Event.SOUND_COMPLETE, onPlayBackComplete);
			_snd.removeEventListener(SampleDataEvent.SAMPLE_DATA, onPlayBack);
		}
		
		protected function onPlayBack(event:SampleDataEvent):void
		{
			if(_recordBytes.bytesAvailable <= 0)
				return;
			var i:int;
			var j:int;
			for(i = 0; i < BYTES_PER_SAMPLE; i++)
			{
				if(_recordBytes.position < _recordBytes.length)
				{
					var smp:Number = _recordBytes.readFloat();
					for(j = 0; j < 12; j++)
					{
						event.data.writeFloat(smp);
					}
				}
			}
		}
		
		public function stopFile():void
		{
			trace("stop file");
		}
		
		public function saveRecord():void
		{
			try{
				_recordBytes.deflate();
				var file:File = _file.resolvePath("test.snd");
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.WRITE);
				fs.writeBytes(_recordBytes);
				fs.close();
			}
			catch(e:Error)
			{
				
			}
		}
		
		public function loadRecordAndPlay():void
		{
			var bytes:ByteArray = new ByteArray();
			var file:File = _file.resolvePath("test.snd");
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			fs.readBytes(bytes);
			fs.close();
			bytes.inflate();
			playFile(bytes);
		}
		
		public function dispose():void
		{
			if(_mic)
			{
				_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleDataHandler);
				_mic = null;
			}
			if(_recordBytes)
			{
				_recordBytes.clear();
				_recordBytes = null;
			}
			if(_snd)
			{
				_snd.removeEventListener(SampleDataEvent.SAMPLE_DATA, onPlayBack);
				_snd = null;
			}
			if(_sc)
			{
				_sc.removeEventListener(Event.SOUND_COMPLETE, onPlayBackComplete);
				_sc = null;
			}
			_file = null;
		}
	}
}