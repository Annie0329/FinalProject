package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class MenuState extends FlxState
{
	var menuBackground:FlxSprite;
	var about:FlxSprite;
	var aboutText:FlxText;

	var pointerX:Int = 780;
	var pointerY:Int = 630;
	var pointerBar:Int = 150;
	var pointerChoNum:Int = 3;
	var pointerDir:String = "ud";
	var pointerCho:Array<String> = ["continue", "restart", "about"];
	var pointer:Pointer;

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
		pointer.color = 0xffCC9709;
		add(pointer);
		pointer.setPointer(pointerX, pointerY, pointerBar, pointerCho, pointerDir);

		// 關於背景
		about = new FlxSprite(0, 0, AssetPaths.menuAbout__png);
		about.screenCenter();
		add(about);
		about.visible = false;

		// 關於的字
		aboutText = new FlxText(0, about.y + 150, 480, "操作說明：\nENTER、SPACE、Z：調查、對話換行、確定\nX、SHIFT：取消\nC：查看持有物品\nMusic: https://www.bensound.com", 60);
		aboutText.borderColor = FlxColor.BLACK;
		aboutText.font = AssetPaths.silver__ttf;
		aboutText.color = FlxColor.BLACK;
		aboutText.screenCenter(FlxAxes.X);
		add(aboutText);
		aboutText.visible = false;

		// 除錯ufo
		ufo = new FlxText(0, 0, 0, "ufo", 60);
		ufo.borderColor = FlxColor.BLACK;
		ufo.borderSize = 1;
		ufo.color = FlxColor.BLACK;
		add(ufo);
		ufo.visible = false;

		// 存檔元件
		save = new FlxSave();
		save.bind("DefiAdv");

		if (save.data.bananaValue != null)
			pointer.y = pointerY;
		else
			pointer.y = pointerY + pointerBar;
		if (save.data.place != null)
		{
			this.save.data.place = save.data.place;
		}

		FlxG.mouse.visible = false;

		// 淡入效果，true是淡入
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ufo.text = Std.string(pointer.selected);

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

		// 主選單功能
		if (enter && !about.visible)
		{
			switch (pointer.selected)
			{
				// 繼續遊戲
				case "continue":
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

				// 重新開始
				case "restart":
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						save.erase();
						FlxG.switchState(new OpeningState());
					});

				// 關於
				case "about":
					about.visible = true;
					aboutText.visible = true;
			}
		}

		// 回主選單
		if (x && about.visible)
		{
			about.visible = false;
			aboutText.visible = false;
		}
	}
}