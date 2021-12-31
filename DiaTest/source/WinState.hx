package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class WinState extends FlxState
{
	var winTitle:FlxText;
	var winText:FlxText;

	override public function create()
	{
		winTitle = new FlxText(0, 0, "Thanks for Playing!", 44);
		winTitle.screenCenter(FlxAxes.X);
		add(winTitle);

		winText = new FlxText(0, winTitle.y + winTitle.height + 100, 200, "按enter鍵回主選單", 20);
		winText.screenCenter(FlxAxes.X);
		winText.font = AssetPaths.silver__ttf;
		winText.alignment = CENTER;
		add(winText);

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();
	}

	// 如果按enter鍵就回選單
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER]);
		if (enter)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
