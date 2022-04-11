package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class WinState extends FlxState
{
	var dia:Dia;
	var creditText:FlxText;
	var thankYouText:FlxText;

	var name:String;
	var end:Bool = false;

	override public function create()
	{
		// 對話框
		dia = new Dia();
		add(dia);

		// 演職員表
		creditText = new FlxText(0, FlxG.height + 10, 600, "程式設計/Annie\n美術-人物設計/味噌丸\n美術-場景製作/Penguin\n區塊鏈知識顧問/貢丸", 60);
		creditText.screenCenter(FlxAxes.X);
		creditText.font = AssetPaths.silver__ttf;
		creditText.alignment = CENTER;
		add(creditText);
		creditText.visible = false;

		// 感謝你字幕
		thankYouText = new FlxText(0, 0, FlxG.width, "感謝遊玩！", 200);
		thankYouText.screenCenter();
		thankYouText.font = AssetPaths.silver__ttf;
		thankYouText.alignment = CENTER;
		add(thankYouText);
		thankYouText.visible = false;

		// 進來就出現Doge對話
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true, function()
		{
			name = AssetPaths.endingTalk__txt;
			dia.diaUpDown = "down";
			dia.show(name, true);
			end = true;
		});
		// 播音樂
		FlxG.sound.playMusic(AssetPaths.creditTheme__mp3, 0.3, true);
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
		if (creditText.y < -creditText.height + 10 && !thankYouText.visible)
		{
			thankYouText.visible = true;
			creditText.velocity.y = 0;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		}
	}

	// 如果按enter鍵就回選單
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		if (enter && thankYouText.visible)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
