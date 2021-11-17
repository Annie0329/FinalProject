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
		guide = new FlxText(0, 0, 400, "操作說明：\nENTER、SPACE、Z：調查、對話換行、確定\nX、SHIFT：取消\nC：查看持有物品", 20, true);
		guide.font = AssetPaths.font__ttf;
		guide.screenCenter();
		guide.visible = false;
		add(guide);

		// 開場動畫
		openingAnimation = new FlxSprite();
		openingAnimation.loadGraphic(AssetPaths.openingAnimation__png, true, 480, 360);
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

		var x = FlxG.keys.anyJustReleased([ANY]);
		var enter = FlxG.keys.anyJustReleased([ENTER]);
		if (!openingAnimation.visible && x)
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
				openingAnimation.visible = false;
				guide.visible = true;
			}
			else
			{
				i++;
				textRunDone = false;
				openingAnimation.animation.frameIndex = i;
				openText.resetText(dilog_boxes[i + 1]);
				openText.start(false, false, function()
				{
					textRunDone = true;
				});
			}
		}
	}
}
