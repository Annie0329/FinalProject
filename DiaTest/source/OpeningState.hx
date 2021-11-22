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
		guide = new FlxText(0, 0, 400, "操作說明：\nENTER、SPACE、Z：調查、對話換行、確定\nX、SHIFT：取消\nC：查看持有物品", 28, true);
		guide.font = AssetPaths.silver__ttf;
		guide.screenCenter();
		guide.visible = false;
		add(guide);

		// 開場動畫
		openingAnimation = new FlxSprite().loadGraphic(AssetPaths.openingAnimation__png, true, 480, 360);
		openingAnimation.setGraphicSize(360, 270);
		openingAnimation.updateHitbox();
		openingAnimation.screenCenter(FlxAxes.X);
		add(openingAnimation);
		openingAnimation.animation.frameIndex = i;

		// 商店的字
		openText = new FlxTypeText(openingAnimation.x, openingAnimation.height + 10, 360, "text", 28, true);
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
		if (!openingAnimation.visible && any || x)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new PlayState(false));
			});
		}
		else if (enter && textRunDone)
		{
			if (i > 10)
			{
				FlxG.camera.fade(0xffFFFDE4, 1, false, function()
				{
					openingAnimation.visible = false;
					FlxG.camera.fade(0xffFFFDE4, 1, true, function()
					{
						FlxG.switchState(new PlayState(false));
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
