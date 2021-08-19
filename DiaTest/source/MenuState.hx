package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var background:FlxSprite;
	var name:String;
	var dia:Dia;

	override public function create()
	{
		background = new FlxSprite(0, 0, AssetPaths.mainMenu__png);
		add(background);

		var playButton:FlxButton;
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.screenCenter();
		add(playButton);

		dia = new Dia();
		add(dia);

		super.create();
	}

	function clickPlay()
	{
		dia.begin = "1";
		dia.beginTitle.text = dia.begin;
		stateSwitch();
	}

	function stateSwitch()
		FlxG.switchState(new PlayState());
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
