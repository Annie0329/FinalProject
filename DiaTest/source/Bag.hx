package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Bag extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var bananaCounter:FlxText;
	var bananaIcon:FlxSprite;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(10, 10).makeGraphic(FlxG.width - 20, FlxG.height - 20, FlxColor.BLACK);
		add(background);

		// 香蕉圖示
		bananaIcon = new FlxSprite(background.x+10, background.y+10).loadGraphic(AssetPaths.banana__png);
		add(bananaIcon);

		// 香蕉數目
		bananaCounter = new FlxText(bananaIcon.x + bananaIcon.width, bananaIcon.y, 0, "0", 20);
		add(bananaCounter);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));

		visible = false;
		active = false;
	}

	public function updateBag(bananaValue)
	{
		bananaCounter.text = Std.string(bananaValue);
	}

	override function update(elapsed:Float)
	{
		if (visible)
		{
			var x = FlxG.keys.anyJustReleased([X]);
			if (x)
			{
				visible = false;
				active = false;
			}
		}
		super.update(elapsed);
	}
}
