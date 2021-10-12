package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class OpeningState extends FlxState
{
	var guide:FlxText;
	var openingAnimation:FlxSprite;

	override public function create()
	{
		guide = new FlxText(0, 0, 400, "操作說明：\nENTER、SPACE、Z：調查、對話換行、確定\nX、SHIFT：取消\nC：查看持有物品", 20, true);
		guide.font = AssetPaths.font__ttf;
		guide.screenCenter();
		add(guide);

		// 開場動畫
		openingAnimation = new FlxSprite();
		openingAnimation.loadGraphic(AssetPaths.openingAnimation__png, true, 480, 360);
		openingAnimation.animation.add("oa", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 0.5, false);
		add(openingAnimation);

		openingAnimation.animation.play("oa");

		FlxG.mouse.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var x = FlxG.keys.anyJustReleased([ANY]);
		if (x)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
		if (openingAnimation.animation.finished)
		{
			openingAnimation.visible = false;
		}
	}
}
