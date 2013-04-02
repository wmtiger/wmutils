package com.mictalk.views
{
	import com.mictalk.logic.MicTalk;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MicUI extends Sprite
	{
		private var startRecord:Sprite;//start to record
		private var stopRecord:Sprite;//stop to record
		private var playFile:Sprite;//play the sound file
		private var stopFile:Sprite;//stop the sound file
		private var saveFile:Sprite;//save the sound file
		private var loadFile:Sprite;//load the sound file
		private var micTalk:MicTalk;
		public function MicUI()
		{
			super();
			init();
		}
		
		private function init():void
		{
			micTalk = new MicTalk();
			
			startRecord = createBtn(0xff0000,"开始录音");
			addChild(startRecord);
			startRecord.x = 0;
			startRecord.addEventListener(MouseEvent.CLICK, onClickStartRecord);
			stopRecord = createBtn(0x00ff00,"停止录音");
			addChild(stopRecord);
			stopRecord.x = 150;
			stopRecord.addEventListener(MouseEvent.CLICK, onClickStopRecord);
			playFile = createBtn(0x0000ff,"播放");
			addChild(playFile);
			playFile.x = 300;
			playFile.addEventListener(MouseEvent.CLICK, onClickPlayFile);
			stopFile = createBtn(0x00ff00,"停止播放");
			addChild(stopFile);
			stopFile.x = 450;
			stopFile.addEventListener(MouseEvent.CLICK, onClickStopFile);
			saveFile = createBtn(0x00ffff,"存储录音");
			addChild(saveFile);
			saveFile.x = 600;
			saveFile.addEventListener(MouseEvent.CLICK, onClickSaveFile);
			loadFile = createBtn(0x00ffff,"加载录音");
			addChild(loadFile);
			loadFile.x = 750;
			loadFile.addEventListener(MouseEvent.CLICK, onClickLoadFile);
		}
		
		protected function onClickLoadFile(event:MouseEvent):void
		{
			micTalk.loadRecordAndPlay();
		}
		
		protected function onClickSaveFile(event:MouseEvent):void
		{
			micTalk.saveRecord();
		}
		
		protected function onClickStopFile(event:MouseEvent):void
		{
			micTalk.stopFile();
		}
		
		protected function onClickPlayFile(event:MouseEvent):void
		{
			micTalk.playFile();
		}
		
		protected function onClickStopRecord(event:MouseEvent):void
		{
			micTalk.stopRecord();
		}
		
		protected function onClickStartRecord(event:MouseEvent):void
		{
			micTalk.startRecord();
		}
		
		private function createBtn(color:uint,name:String = ""):Sprite
		{
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(color);
			btn.graphics.drawRect(0,0,100, 100);
			btn.graphics.endFill();
			var txt:TextField = new TextField();
			txt.text = name;
			btn.addChild(txt);
			btn.mouseChildren = false;
			return btn;
		}
	}
}