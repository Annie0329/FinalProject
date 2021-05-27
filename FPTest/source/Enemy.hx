package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

// 定義敵人的類型
enum EnemyType
{
	REGULAR;
	BOSS;
}

class Enemy extends FlxSprite
{
	// 跑多快
	static inline var SPEED:Float = 100;

	var type:EnemyType;

	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;

	public function new(x:Float, y:Float, type:EnemyType)
	{
		super(x, y);
		this.type = type;

		// 呼叫敵人或魔王的圖片
		var graphic = if (type == BOSS) AssetPaths.boss__png else AssetPaths.enemy__png;
		loadGraphic(graphic, true, 64, 64);

		// 面向右邊時使用鏡像的左邊圖片
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		// 走路動畫
		animation.add("lr", [4, 3, 5, 3], 6, false);
		animation.add("u", [7, 6, 8, 6], 6, false);
		animation.add("d", [1, 0, 2, 0], 6, false);

		// 滑壘強度
		drag.x = drag.y = 10;

		width = 32;
		height = 32;
		offset.x = 16;
		offset.y = 16;

		brain = new FSM(idle);
		idleTimer = 0;
		playerPosition = FlxPoint.get();
	}

	// 閒閒狀態
	function idle(elapsed:Float)
	{
		// 如果看見玩家就變成追趕狀態
		if (seesPlayer)
			brain.activeState = chase;
		else if (idleTimer <= 0)
		{
			// 如果隨機選到1的話就不動
			if (FlxG.random.bool(1))
			{
				moveDirection = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				// 隨機選角度移動
				moveDirection = FlxG.random.int(0, 8) * 45;

				if (type == BOSS)
					velocity.set(SPEED, 0);
				else
					velocity.set(SPEED * 0.5, 0);
				velocity.rotate(FlxPoint.weak(), moveDirection);
			}
			// 隨機選個數
			idleTimer = FlxG.random.int(1, 4);
		}
		else
			idleTimer -= elapsed;
	}

	// 追趕玩家狀態
	function chase(elapsed:Float)
	{
		// 如果沒看見玩家就變閒閒狀態
		if (!seesPlayer)
			brain.activeState = idle;
		else
		{
			// 我自己加的:D，魔王的速度會比囉囉快
			if (type == BOSS)
				FlxVelocity.moveTowardsPoint(this, playerPosition, Std.int(SPEED * 1.5));
			else
				FlxVelocity.moveTowardsPoint(this, playerPosition, Std.int(SPEED));
		}
	}

	override function update(elapsed:Float)
	{
		// 什麼時候臉該面向哪邊，以x、y的速度方向判斷
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = FlxObject.LEFT;
				else
					facing = FlxObject.RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					facing = FlxObject.UP;
				else
					facing = FlxObject.DOWN;
			}
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
		brain.update(elapsed);
		super.update(elapsed);
	}
}
