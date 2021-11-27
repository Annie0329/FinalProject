package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameOverState extends FlxState
{
	var gameOverTitle:FlxText;

	override public function create()
	{
		gameOverTitle = new FlxText(0, 0, "GameOver", 44);
		gameOverTitle.screenCenter();
		add(gameOverTitle);

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEsc();
	}

	// 如果按esc鍵就回選單
	function updateEsc()
	{
		var esc = FlxG.keys.anyJustReleased([ESCAPE]);
		if (esc)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
