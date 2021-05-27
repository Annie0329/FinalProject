package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		// 把螢幕放大
		addChild(new FlxGame(640, 360, MenuState));

		// 放克夜超酷的FPS計算，讓你知道是你的電腦跑太慢
		addChild(new FPS(10, 40, 0xffffff));
	}
}
