package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	// 跑多快
	var SPEED:Float = 200;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.ape__png, true, 50, 64);
		// 面向右邊時使用鏡像的左邊圖片
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		// 走路動畫
		animation.add("lr", [3, 4, 3, 5, 6, 7, 6, 5], 6, false);
		animation.add("u", [9, 8, 10, 8], 6, false);
		animation.add("d", [1, 0, 2, 0], 6, false);
		setSize(50, 32);
		offset.set(0, 32);
		immovable = false;
	}

	public function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// 如果有按方向鍵這些數值就會變成真
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		// 如果上下或左右同時被按就不要動
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			var newAngle:Float = 0;

			// 指定各種情況的角度
			// 他們改圖書館了！！facing寫法改了(FlxObject.UP->UP)！！大笨蛋！！
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = RIGHT;
			}

			// 設定玩家的速度和方向。玩家永遠都往前進，只是角度一直改
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);

			if (velocity.x != 0 || velocity.y != 0)
			{
				// 什麼時候臉該面向哪邊
				switch (facing)
				{
					case LEFT, RIGHT:
						animation.play("lr");
					case UP:
						animation.play("u");
					case DOWN:
						animation.play("d");
					case _:
				}
			}
		}
		else
			velocity.set(0, 0);
	}

	// 更新啦
	override function update(elapsed:Float)
	{
		updateMovement();
		var shift = FlxG.keys.anyPressed([SHIFT]);
		if (shift)
			SPEED = 400;
		else
			SPEED = 200;
		super.update(elapsed);
	}
}
