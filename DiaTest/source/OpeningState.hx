package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class OpeningState extends FlxState
{
	var openingAnimation:FlxSprite;

	override public function create()
	{
		// 開場動畫
		openingAnimation = new FlxSprite();
		openingAnimation.loadGraphic(AssetPaths.openingAnimation__png, true, 480, 360);
		openingAnimation.animation.add("oa", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 1, false);
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
		if (x || openingAnimation.animation.finished)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
