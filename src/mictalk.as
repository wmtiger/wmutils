package
{
	import com.mictalk.mgr.MicTalkMgr;
	import com.mictalk.views.MicUI;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class mictalk extends Sprite
	{
		public function mictalk()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			MicTalkMgr.instance.init();
			var ui:MicUI = new MicUI();
			addChild(ui);
		}
	}
}