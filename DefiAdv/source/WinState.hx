package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class WinState extends FlxState
{
	var winText:FlxText;
	var dia:Dia;
	var name:String;
	var end:Bool = false;

	override public function create()
	{
		// 對話框
		dia = new Dia();
		add(dia);

		winText = new FlxText(0, 0, 600, "程式設計/Annie\n美術-人物設計/味噌丸\n美術-場景製作/Penguin\n區塊鏈知識顧問/貢丸", 60);
		winText.screenCenter();
		winText.font = AssetPaths.silver__ttf;
		winText.alignment = CENTER;
		add(winText);
		winText.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true, function()
		{
			name = AssetPaths.endingTalk__txt;
			dia.diaUpDown = "down";
			dia.show(name, true);
			end = true;
		});
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();
		if (!dia.visible && end)
		{
			end = false;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				winText.visible = true;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
			});
		}
	}

	// 如果按enter鍵就回選單
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		if (enter && winText.visible)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
