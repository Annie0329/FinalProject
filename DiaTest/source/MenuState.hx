package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var menuBackground:FlxSprite;

	var menuPointer:FlxSprite;
	var pointerBar:Int = 50;
	var pointerStart:Int = 215;

	var menu:String = "main";

	var ufo:FlxText;

	override public function create()
	{
		// 主選單
		menuBackground = new FlxSprite(0, 0, AssetPaths.menuMain__png);
		add(menuBackground);

		// 箭頭
		menuPointer = new FlxSprite(170, 215, AssetPaths.menuPointer__png);
		add(menuPointer);

		// 除錯ufo
		ufo = new FlxText(0, 0, "ufo", 20);
		ufo.borderColor = FlxColor.BLACK;
		ufo.borderSize = 1;
		ufo.scrollFactor.set(0, 0);
		// ufo.color = FlxColor.BLACK;
		add(ufo);

		// 淡入效果，true是淡入
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ufo.text = Std.string(pointerBar); // Std.string(FlxG.mouse.screenX) + ", " + Std.string(FlxG.mouse.screenY);

		var up = FlxG.keys.anyJustReleased([UP, W]);
		var down = FlxG.keys.anyJustReleased([DOWN, S]);
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		var x = FlxG.keys.anyJustReleased([X]);

		// 移動箭頭
		if (up)
		{
			if (menuPointer.y == pointerStart)
				menuPointer.y = pointerStart + pointerBar * 2;
			else
				menuPointer.y -= pointerBar;
		}
		if (down)
		{
			if (menuPointer.y == pointerStart + pointerBar * 2)
				menuPointer.y = pointerStart;
			else
				menuPointer.y += pointerBar;
		}
		//確認
		if (enter)
		{
			// 主選單功能
			if (menu == "main")
			{
				// 章節選擇
				if (menuPointer.y == pointerStart)
				{
					menuBackground.loadGraphic(AssetPaths.menuChapterSelect__png);
					menu = "chapterSelect";
					pointerBar = 60;
					pointerStart = 110;
					menuPointer.y = pointerStart;
				}

				// 重新開始
				else if (menuPointer.y == pointerStart + pointerBar)
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						FlxG.switchState(new PlayState());
					});

				// 關於
				else
				{
					menuBackground.loadGraphic(AssetPaths.menuAbout__png);
					menuPointer.visible == false;
					menu = "about";
				}
			}

			// 章節選擇功能
			else if (menu == "chapterSelect")
			{
				// 第一章
				if (menuPointer.y == pointerStart)
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						FlxG.switchState(new PlayState());
					});
			}
		}

		// 回主選單
		if (x)
			if (menu != "main")
			{
				menuBackground.loadGraphic(AssetPaths.menuMain__png);
				menuPointer.visible = true;
				menu = "main";
				pointerBar = 50;
				pointerStart = 215;
				menuPointer.y = pointerStart;
			}
	}
}
