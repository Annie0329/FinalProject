package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

class MenuState extends FlxState
{
	override public function create()
	{
		// 加開始按鈕
		var playButton:FlxButton;
		playButton = new FlxButton(0, 0, "Play開始遊戲", clickPlay);
		add(playButton);
		playButton.screenCenter();

		// 加說明按鈕
		var guideButton:FlxButton;
		guideButton = new FlxButton(100, 150, "about關於", clickAbout);
		add(guideButton);
		guideButton.screenCenter(FlxAxes.X);

		// 我自己加的超大說明
		var guide:FlxText;
		guide = new FlxText(10, 10, "方向鍵操控遊戲\n按enter也可以開始遊戲喔", 20);
		add(guide);

		super.create();
	}

	function Enter()
	{
		var enter:Bool = false;
		enter = FlxG.keys.anyPressed([ENTER]);
		if (enter == true)
			clickPlay();
	}

	// 開始按鈕被按下就會啟動這個程式：它會把場景換到PlayState去
	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function clickAbout()
	{
		FlxG.switchState(new AboutState());
	}

	override public function update(elapsed:Float)
	{
		Enter();
		super.update(elapsed);
	}
}
