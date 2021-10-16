package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class MenuState extends FlxState
{
	var menuBackground:FlxSprite;

	var pointerStart:Int = 215;
	var pointerAnoPos:Int = 170;
	var pointerBar:Int = 50;
	var pointerChoNum:Int = 3;
	var pointerDir:String = "ud";
	var pointer:Pointer;

	var menu:String = "main";
	var loadsave:Bool;


	var ufo:FlxText;

	var save:FlxSave;

	override public function create()
	{
		// 主選單
		menuBackground = new FlxSprite(0, 0, AssetPaths.menuMain__png);
		add(menuBackground);

		// 箭頭
		pointer = new Pointer();
		add(pointer);
		pointer.setPointer(215, 170, 50, 3, "ud");

		// 除錯ufo
		ufo = new FlxText(0, 0, "ufo", 20);
		ufo.borderColor = FlxColor.BLACK;
		ufo.borderSize = 1;
		ufo.scrollFactor.set(0, 0);
		ufo.color = FlxColor.BLACK;
		add(ufo);
		ufo.visible = false;

		// 存檔元件
		save = new FlxSave();
		save.bind("DiaTest");

		if (save.data.bananaValue != null)
			pointer.y = pointerStart;
		else
			pointer.y = pointerStart + pointerBar;

		FlxG.mouse.visible = false;

		// 淡入效果，true是淡入
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ufo.text = "oui";

		var up = FlxG.keys.anyJustReleased([UP, W]);
		var down = FlxG.keys.anyJustReleased([DOWN, S]);
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		var x = FlxG.keys.anyJustReleased([X]);

		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			ufo.visible = true;
			save.erase();
		}

		// 確認
		if (enter)
		{
			// 主選單功能
			if (menu == "main")
			{
				// 繼續遊戲
				if (pointer.y == pointer.start)
				{
					if (save.data.bananaValue != null)
						FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
						{
							loadsave = true;
							if (save.data.place == "miner")
								FlxG.switchState(new MinerState(loadsave));
							else
								FlxG.switchState(new PlayState(loadsave));
							save.data.place = "menu";
							save.flush();
						});
				}

				// 重新開始
				else if (pointer.y == pointer.start + pointer.bar)
				{
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						loadsave = false;
						FlxG.switchState(new PlayState(loadsave));
					});
				}

				// 關於
				else
				{
					pointer.visible = false;
					menuBackground.loadGraphic(AssetPaths.menuAbout__png);
					menu = "about";
				}
			}
		}

		// 回主選單
		if (x)
		{
			menuBackground.loadGraphic(AssetPaths.menuMain__png);
			pointer.visible = true;
			pointerBar = 50;
			pointerStart = 215;

			pointer.y = pointerStart + pointerBar * 2;

			menu = "main";
		}
	}
}
