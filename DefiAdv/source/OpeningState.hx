package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class OpeningState extends FlxState
{
	var next:FlxSound;

	var openAni:Bool = true;
	var guide:FlxText;
	var openingAnimation:FlxSprite;
	var enterCur:FlxSprite;

	var dia:Dia;
	var i:Int = 0;
	var openText:FlxTypeText;
	var dilog_boxes:Array<String>;
	var textRunDone:Bool = false;

	var name = AssetPaths.openText__txt;
	var diaName = AssetPaths.closeText__txt;
	// 除錯ufo
	var ufo:FlxText;

	/**
		*來自MenuState的呼喚，我們到底要不要用存檔檔案
		*@param animationType
	 */
	public function new(openAni)
	{
		super();
		this.openAni = openAni; // 這個openAni等於那個openAni(咒語)
	}

	override public function create()
	{
		// 翻頁聲音
		next = FlxG.sound.load(AssetPaths.next__ogg);

		// 操作說明
		guide = new FlxText(FlxG.width - 400, FlxG.height - 100, "Enter或Space 下一頁", 60, true);
		guide.font = AssetPaths.silver__ttf;
		guide.visible = false;
		add(guide);

		// 開場動畫
		openingAnimation = new FlxSprite();
		if (openAni)
			openingAnimation.loadGraphic(AssetPaths.openingAnimation__png, true, 1440, 1080);
		else
			openingAnimation.loadGraphic(AssetPaths.closingAnimation__png, true, 1440, 1080);
		openingAnimation.setGraphicSize(1080, 810);
		openingAnimation.updateHitbox();
		openingAnimation.screenCenter(FlxAxes.X);
		add(openingAnimation);
		openingAnimation.animation.frameIndex = i;

		// 指示你可以跳行的箭頭
		enterCur = new FlxSprite(0, FlxG.height - 70, AssetPaths.pointer__png);
		enterCur.angle = 90;
		enterCur.screenCenter(FlxAxes.X);
		add(enterCur);
		enterCur.visible = false;

		// 開場字幕
		openText = new FlxTypeText(openingAnimation.x, openingAnimation.height + 30, 1080, "text", 84, true);
		openText.delay = 0.05;
		openText.skipKeys = ["X", "SHIFT"];
		openText.font = AssetPaths.silver__ttf;
		// openText.sounds = [FlxG.sound.load(AssetPaths.typing__ogg)];
		// openText.finishSounds = true;
		add(openText);

		if (openAni)
			dilog_boxes = openfl.Assets.getText(name).split(":");
		else
			dilog_boxes = openfl.Assets.getText(diaName).split(":");
		i = 0;

		// 對話框
		dia = new Dia();
		add(dia);

		// 除錯ufo
		ufo = new FlxText(0, 0, 600, "ufo", 60);
		ufo.scrollFactor.set(0, 0);
		ufo.color = FlxColor.WHITE;
		add(ufo);
		ufo.visible = false;

		FlxG.mouse.visible = false;

		openText.visible = true;
		textRunDone = false;
		openText.resetText(dilog_boxes[i + 1]);
		openText.start(false, false, function()
		{
			textRunDone = true;
			enterCur.visible = true;
			enterCur.flicker(0, 0.5);
		});

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// 除錯大隊

		var e = FlxG.keys.anyJustReleased([E]);
		// if (e)
		// {
		//	ufo.visible = true;
		// }
		var x = FlxG.keys.anyJustReleased([X, ESCAPE]);
		var any = FlxG.keys.anyJustReleased([ANY]);
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);

		ufo.text = Std.string(textRunDone) + Std.string(enter);
		// 跳過動畫
		if (!openingAnimation.visible && any || x)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new PlayState(false));
			});
		}

		// 換下一頁
		if (enter && textRunDone)
		{
			enterCur.stopFlickering();
			enterCur.visible = false;
			next.play();
			// 動畫結束轉場
			if (openAni && i > 9)
			{
				FlxG.camera.fade(0xffFFFDE4, 1, false, function()
				{
					openingAnimation.visible = false;
					openText.visible = false;
					guide.visible = false;
					FlxG.camera.fade(0xffFFFDE4, 1, true, function()
					{
						FlxG.switchState(new PlayState(false));
					});
				});
			}
			else if (!openAni && i > 6)
			{
				FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
				{
					openingAnimation.visible = false;
					openText.visible = false;
					guide.visible = false;
					FlxG.camera.fade(FlxColor.BLACK, 1, true, function()
					{
						FlxG.switchState(new MenuState());
					});
				});
			}
			else
			{
				i++;
				textRunDone = false;
				openText.resetText(dilog_boxes[i + 1]);
				openText.start(false, false, function()
				{
					textRunDone = true;
					enterCur.visible = true;
					enterCur.flicker(0, 0.5);
				});

				if (!openAni && i == 3)
					openingAnimation.animation.frameIndex = i;
				else
					FlxTween.tween(openingAnimation, {alpha: 0}, .33, {
						onComplete: function(_)
						{
							openingAnimation.animation.frameIndex = i;
							FlxTween.tween(openingAnimation, {alpha: 1}, .33);
						}
					});
			}
		}
	}
}
