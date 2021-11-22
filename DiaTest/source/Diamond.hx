package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class Diamond extends FlxTypedGroup<FlxSprite>
{
	public var diamondText:FlxText;

	var diamondIcon:FlxSprite;

	public function new()
	{
		super();
		diamondIcon = new FlxSprite(10, 10).loadGraphic(AssetPaths.diamondIcon__png);
		add(diamondIcon);

		diamondText = new FlxText(diamondIcon.x + 40, diamondIcon.y + 5, "0", 20);
		diamondText.color = 0xff2D5925;
		add(diamondText);

		forEach(function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
