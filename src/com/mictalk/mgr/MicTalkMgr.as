package com.mictalk.mgr
{
	import flash.media.Microphone;

	/**
	 * 使用方法：MicTalkMgr.instance.init();
	 */
	public class MicTalkMgr
	{
		private static var _instance:MicTalkMgr;
		private var _mic:Microphone;
		public function MicTalkMgr()
		{
		}

		public static function get instance():MicTalkMgr
		{
			if(_instance == null)
			{
				_instance = new MicTalkMgr();
			}
			return _instance;
		}
		
		public function init():void
		{
			var idx:int;
			for(var i:int = 0; i < Microphone.names.length; i++)
			{
				if(Microphone.names[i] != null)
				{
					idx = i;
					break;
				}
			}
			
			_mic = Microphone.getMicrophone(idx);
			if(_mic)
			{
				trace("有麦克风");
				_mic.rate = 8;
				_mic.setSilenceLevel(0,10000);
				_mic.gain = 100;
			}
			else
			{
				trace("麦克风不存在");
				throw new Error("no mic");
			}
		}
		
		public function get mic():Microphone
		{
			return _mic;
		}

	}
}