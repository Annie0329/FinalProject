package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var i:Int = 1;
	var dilog_boxes:Array<String>;
	var text:FlxText;
	var background:FlxSprite;
	var name:String;

	public function new()
	{
		super();

		background = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		background.setPosition(0, 10);
		background.screenCenter(FlxAxes.X);
		add(background);

		text = new FlxText(10, 10, FlxG.width-20,"", 20);
		add(text);

		visible = false;

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	public function show(name)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 1;
		text.text = dilog_boxes[i];
		visible = true;
		active = true;
	}

	override public function update(elapsed:Float)
	{
		Enter();
		super.update(elapsed);
	}

	function Enter()
	{
		var enter:Bool = false;
		enter = FlxG.keys.anyJustReleased([ENTER]);
		if (enter == true)
		{
			i++;
			if (i != dilog_boxes.length)
			{
				text.text = dilog_boxes[i];
			}
			else
			{
				visible = false;
				active = false;
			}
		}
	}
}
