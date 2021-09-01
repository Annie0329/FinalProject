package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var background:FlxSprite;
	var playButton:FlxButton;
	var menuPointer:FlxSprite;

	override public function create()
	{
		// 主選單
		background = new FlxSprite(0, 0, AssetPaths.menuMain__png);
		add(background);

		// 臨時按鈕
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.screenCenter();
		add(playButton);

		// 箭頭
		menuPointer = new FlxSprite(100, 100, AssetPaths.menuPointer__png);
		add(menuPointer);

		// 淡入效果
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	// 開始遊戲
	function clickPlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
