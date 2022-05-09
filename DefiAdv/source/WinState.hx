package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class WinState extends FlxState
{
	var background:FlxSprite;
	var dia:Dia;
	var creditText:FlxSprite;

	var name:String;
	var end:Bool = false;

	override public function create()
	{
		background = new FlxSprite().makeGraphic(1920, 1080, 0xffB2E7FF);
		add(background);

		// 對話框
		dia = new Dia();
		add(dia);

		// 演職員表
		creditText = new FlxSprite(0, FlxG.height + 10).loadGraphic(AssetPaths.credit__png);
		creditText.screenCenter(FlxAxes.X);
		add(creditText);
		creditText.visible = false;

		// 進來就出現Doge對話
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true, function()
		{
			name = AssetPaths.endingTalk__txt;
			dia.diaUpDown = "down";
			dia.show(name, true);
			end = true;
		});
		// 播音樂
		FlxG.sound.playMusic(AssetPaths.creditTheme__ogg, 0.3, true);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();
		// 對話結束就上演職員表
		if (!dia.visible && end)
		{
			end = false;

			creditText.visible = true;
			creditText.velocity.y = -100;
			creditText.moves = true;
		}
		// 演職員表滾完就上感謝你字幕
		if (creditText.y < -creditText.height + 10)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new OpeningState(false));
			});
		}
	}

	// 如果按enter鍵就回選單
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		if (enter && creditText.visible)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new OpeningState(false));
			});
		}
	}
}
