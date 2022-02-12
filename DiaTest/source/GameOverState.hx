package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class GameOverState extends FlxState
{
	var gameOverTitle:FlxText;
	var continueText:FlxTypeText;
	var yes:FlxText;
	var no:FlxText;
	var gameOverCho:Array<String> = ["YES", "NO"];
	var pointer:Pointer;
	var save:FlxSave;
	var loadsave:Bool = false;

	override public function create()
	{
		gameOverTitle = new FlxText(0, 0,0, "GameOver", 44);
		gameOverTitle.screenCenter(FlxAxes.X);
		add(gameOverTitle);

		continueText = new FlxTypeText(0, gameOverTitle.y + gameOverTitle.height + 100, 200, "continue?", 20);
		continueText.screenCenter(FlxAxes.X);
		add(continueText);

		yes = new FlxText(FlxG.width / 4, FlxG.height / 4 * 3,0, "YES", 20);
		add(yes);
		yes.visible = false;

		no = new FlxText(yes.x + FlxG.width / 2, yes.y,0, "NO", 20);
		add(no);
		no.visible = false;

		pointer = new Pointer();
		pointer.setPointer(yes.x - 20, yes.y + yes.height / 2 - 10, Std.int(no.x - yes.x), gameOverCho, "lr");
		add(pointer);
		pointer.visible = false;

		save = new FlxSave();
		save.bind("DiaTest");

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true, function()
		{
			continueText.start(0.1, false, false, function()
			{
				pointer.visible = true;
				yes.visible = true;
				no.visible = true;
			});
		});
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEsc();
		var enter = FlxG.keys.anyJustReleased([ENTER]);
		if (enter)
		{
			switch (pointer.selected)
			{
				// 繼續遊戲就回存檔點
				case "YES":
					if (save.data.bananaValue != null)
						FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
						{
							loadsave = true;
							if (save.data.place == "miner")
								FlxG.switchState(new MinerState());
							else if (save.data.place == "monument")
								FlxG.switchState(new PlayState(loadsave));
							else if (save.data.place == "street")
								FlxG.switchState(new StreetState());
						});
					// 沒有存檔點就回到一開始
					else
					{
						loadsave = false;
						FlxG.switchState(new PlayState(loadsave));
					}

				// 不繼續就回主選單
				case "NO":
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						FlxG.switchState(new MenuState());
					});
			}
		}
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
