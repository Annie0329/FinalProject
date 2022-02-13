package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class OpeningState extends FlxState
{
	var guide:FlxText;
	var openingAnimation:FlxSprite;
	var i:Int = 0;
	var openText:FlxTypeText;
	var dilog_boxes:Array<String>;
	var textRunDone:Bool = false;

	var name = AssetPaths.openText__txt;

	override public function create()
	{
		// 操作說明
		guide = new FlxText(0, 0, 1200, "操作說明：\nENTER、SPACE、Z：調查、對話換行、確定\nX、SHIFT：取消\nC：查看持有物品", 84, true);
		guide.font = AssetPaths.silver__ttf;
		guide.screenCenter();
		guide.visible = false;
		add(guide);

		// 開場動畫
		openingAnimation = new FlxSprite().loadGraphic(AssetPaths.openingAnimation__png, true, 1440, 1080);
		openingAnimation.setGraphicSize(1080, 810);
		openingAnimation.updateHitbox();
		openingAnimation.screenCenter(FlxAxes.X);
		add(openingAnimation);
		openingAnimation.animation.frameIndex = i;

		// 開場字幕
		openText = new FlxTypeText(openingAnimation.x, openingAnimation.height + 30, 1080, "text", 84, true);
		openText.delay = 0.05;
		openText.skipKeys = ["X", "SHIFT"];
		openText.font = AssetPaths.silver__ttf;
		add(openText);

		dilog_boxes = openfl.Assets.getText(name).split(":");
		textRunDone = false;
		openText.resetText(dilog_boxes[i + 1]);
		openText.start(false, false, function()
		{
			textRunDone = true;
		});

		FlxG.mouse.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var any = FlxG.keys.anyJustReleased([ANY]);
		var x = FlxG.keys.anyJustReleased([X]);
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);

		// 跳過動畫
		if (!openingAnimation.visible && any || x)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new PlayState(false));
			});
		}
		// 換下一頁
		else if (enter && textRunDone)
		{
			if (i > 9)
			{
				FlxG.camera.fade(0xffFFFDE4, 1, false, function()
				{
					openingAnimation.visible = false;
					openText.visible = false;
					FlxG.camera.fade(0xffFFFDE4, 1, true, function()
					{
						FlxG.switchState(new PlayState(false));
					});
				});
			}
			// 動畫結束轉場
			else
			{
				i++;
				textRunDone = false;
				openText.resetText(dilog_boxes[i + 1]);
				openText.start(false, false, function()
				{
					textRunDone = true;
				});
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
