package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	// 跑多快
	static inline var SPEED:Float = 192;

	public var picsize:Int = 64;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		// 叫玩家的圖片檔
		loadGraphic(AssetPaths.player__png, true, picsize, picsize);

		// 面向右邊時使用鏡像的左邊圖片
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		// 走路動畫
		animation.add("lr", [4, 3, 5, 3], 6, false);
		animation.add("u", [7, 6, 8, 6], 6, false);
		animation.add("d", [1, 0, 2, 0], 6, false);

		// 滑壘強度
		drag.x = drag.y = 1600;

		// 變小以免太胖走不過去
		// 這事實上也是調玩家的座標
		setSize(picsize / 2, picsize / 2);
		offset.set(picsize / 4, picsize / 4);
	}

	function updateMovement()
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

		// 指定各種情況的角度
		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = FlxObject.UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = FlxObject.DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = FlxObject.LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = FlxObject.RIGHT;
			}

			// 設定玩家的速度和方向。玩家永遠都往前進，只是角度一直改
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);

			// 什麼時候臉該面向哪邊
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");
					case FlxObject.UP:
						animation.play("u");
					case FlxObject.DOWN:
						animation.play("d");
				}
			}
		}
	}

	// 更新啦
	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
