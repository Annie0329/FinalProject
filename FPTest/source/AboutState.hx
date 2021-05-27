package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

class AboutState extends FlxState
{
	var i:Int = 0;
	var dilog_boxes:Array<String> = openfl.Assets.getText(AssetPaths.dialogue__txt).split(":");
	var about:FlxText;

	override public function create()
	{
		var backButton:FlxButton;
		backButton = new FlxButton(0, 200, "Back返回", clickBack);
		add(backButton);
		backButton.screenCenter(FlxAxes.X);

		about = new FlxText(10, 10, "oui=", 20);
		add(about);

		var nextButton:FlxButton;
		nextButton = new FlxButton(0, 200, "Next", clickNext);
		add(nextButton);

		super.create();
	}

	function clickBack()
	{
		FlxG.switchState(new MenuState());
	}

	function Dia(i)
	{
		about.text = "" + dilog_boxes[i + 1];
		if ((i + 1) == dilog_boxes.length)
			FlxG.switchState(new MenuState());
	}

	function clickNext()
	{
		Dia(i);
		i++;
	}

	function Enter()
	{
		var enter:Bool = false;
		enter = FlxG.keys.anyJustReleased([ENTER]);
		if (enter == true)
		{
			Dia(i);
			i++;
		}
	}

	override public function update(elapsed:Float)
	{
		Enter();
		super.update(elapsed);
	}
}
