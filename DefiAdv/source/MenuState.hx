package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class MenuState extends FlxState
{
	var menuBackground:FlxSprite;
	var about:FlxSprite;
	var aboutText:FlxText;

	// 聲音組
	var check:FlxSound;
	var cancel:FlxSound;
	var noNoise:FlxSound;

	// 箭頭和它的變數
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
		menuBackground = new FlxSprite(0, 0, AssetPaths.menuMainNew__png);
		add(menuBackground);

		// 箭頭
		pointer = new Pointer();
		pointer.color = 0xffCC9709;
		add(pointer);
		pointer.setPointer(pointerX, pointerY, pointerBar, pointerCho, pointerDir);

		// 聲音組
		check = FlxG.sound.load(AssetPaths.check__wav);
		cancel = FlxG.sound.load(AssetPaths.cancel__wav);
		noNoise = FlxG.sound.load(AssetPaths.no__wav);

		// 關於背景
		about = new FlxSprite(0, 0, AssetPaths.menuAbout__png);
		about.screenCenter();
		add(about);
		about.visible = false;

		// 關於的字
		aboutText = new FlxText(0, about.y + 150, 480, "操作說明：\n方向鍵：移動\n方向鍵+按住Shift：跑步\nENTER、SPACE、Z：調查、對話換行、確定\nX、esc：取消\nF4：回主選單\nC：查看持有物品", 60);
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

		// 有存檔紀錄
		if (save.data.bananaValue != null)
		{
			pointer.y = pointerY;
			menuBackground.loadGraphic(AssetPaths.menuMain__png);
		}
		else
		{
			pointer.y = pointerY + pointerBar;
			menuBackground.loadGraphic(AssetPaths.menuMainNew__png);
		}

		if (save.data.place != null)
		{
			this.save.data.place = save.data.place;
		}

		// 播音樂
		// 最終上傳記得消除註解
		FlxG.sound.playMusic(AssetPaths.menuTheme__wav, 0.3, true);

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
		var x = FlxG.keys.anyJustReleased([X, ESCAPE]);

		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			ufo.visible = true;
			// save.erase();
			// FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
			// {
			// 	FlxG.switchState(new OpeningState(false));
			// });
		}

		// 主選單功能
		if (enter && !about.visible)
		{
			switch (pointer.selected)
			{
				// 繼續遊戲
				case "continue":
					if (save.data.bananaValue != null)
					{
						check.play();
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
					}
					else
						noNoise.play(true);

				// 重新開始
				case "restart":
					check.play();
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						save.erase();
						FlxG.switchState(new OpeningState(true));
					});

				// 關於
				case "about":
					check.play();
					about.visible = true;
					aboutText.visible = true;
			}
		}

		// 回主選單
		if (x && about.visible)
		{
			cancel.play(true);
			about.visible = false;
			aboutText.visible = false;
		}
	}
}
