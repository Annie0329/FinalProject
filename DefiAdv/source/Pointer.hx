package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;

class Pointer extends FlxSprite
{
	var move:FlxSound;

	public var start:Float = 0;
	public var anoPos:Float = 0;
	public var bar:Int = 0;
	public var cho:Array<String> = ["oui1", "oui2", "oui3"];
	public var choNum:Int = 0;
	public var dir:String = "none";
	public var order:Int = 1;
	public var selected:String = "none";

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.pointer__png);
		move = FlxG.sound.load(AssetPaths.movePointer__wav);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		movePointer();

		// 判斷選了哪一個選項
		if (dir == "ud")
			order = Std.int((y - start) / bar);
		else
			order = Std.int((x - start) / bar);
		selected = cho[order];
	}

	public function setPointer(pointerX, pointerY, pointerBar, pointerCho, pointerDir)
	{
		x = pointerX;
		y = pointerY;
		bar = pointerBar;

		cho = [];
		cho = cho.concat(pointerCho);

		choNum = cho.length - 1;
		dir = pointerDir;
		if (dir == "ud")
		{
			anoPos = x;
			start = y;
		}
		else
		{
			start = x;
			anoPos = y;
		}
	}

	// 移動箭頭
	public function movePointer()
	{
		var up = FlxG.keys.anyJustReleased([UP, W]);
		var down = FlxG.keys.anyJustReleased([DOWN, S]);
		var left = FlxG.keys.anyJustReleased([LEFT, A]);
		var right = FlxG.keys.anyJustReleased([RIGHT, D]);

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
					move.play(true);
				}
				if (down)
				{
					if (y == start + bar * choNum)
						y = start;
					else
						y += bar;
					move.play(true);
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
					move.play(true);
				}
				if (left)
				{
					if (x == start)
						x = start + bar * choNum;
					else
						x -= bar;
					move.play(true);
				}
			}
		}
	}
}
