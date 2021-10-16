package;

import flixel.FlxG;
import flixel.FlxSprite;

class Pointer extends FlxSprite
{
	public var start:Float = 0;
	public var anoPos:Float = 0;
	public var bar:Int = 0;
	public var choNum:Int = 0;
	public var dir:String = "none";

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.menuPointer__png);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		movePointer();
	}

	public function setPointer(pointerStart, pointerAnoPos, pointerBar, pointerChoNum, pointerDir)
	{
		start = pointerStart;
		anoPos = pointerAnoPos;
		bar = pointerBar;
		choNum = pointerChoNum - 1;
		dir = pointerDir;
		if (dir == "ud")
		{
			x = anoPos;
			y = start;
		}
		else
		{
			x = start;
			y = anoPos;
		}
	}

	// 移動箭頭
	public function movePointer()
	{
		var up = FlxG.keys.anyJustReleased([UP, W]);
		var down = FlxG.keys.anyJustReleased([DOWN, S]);
		var left = FlxG.keys.anyJustReleased([LEFT, A]);
		var right = FlxG.keys.anyJustReleased([RIGHT, D]);
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);

		if (visible)
		{
			// 上下選擇
			if (dir == "ud")
			{
				if (up)
				{
					if (y == start)
						y = start + bar * choNum;
					else
						y -= bar;
				}
				if (down)
				{
					if (y == start + bar * choNum)
						y = start;
					else
						y += bar;
				}
			}

			// 左右選擇
			if (dir == "lr")
			{
				if (right)
				{
					if (x == start + bar * choNum)
						x = start;
					else
						x += bar;
				}
				if (left)
				{
					if (x == start)
						x = start + bar * choNum;
					else
						x -= bar;
				}
			}
		}
	}
}