package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;

using flixel.util.FlxSpriteUtil;

// 定義敵人的類型
enum EnemyType
{
	REGULAR;
	BOSS;
	shibaCoin;
}

class Enemy extends FlxSprite
{
	// 跑多快
	static inline var SPEED:Float = 100;

	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public var type(default, null):EnemyType;
	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;
	public var onFire:Bool = false;

	public function new(x:Float, y:Float, type:EnemyType)
	{
		super(x, y);
		this.type = type;

		// 呼叫敵人或魔王的圖片
		var graphic:String;
		switch (type)
		{
			case REGULAR:
				graphic = AssetPaths.ponzi__png;
			case BOSS:
				graphic = AssetPaths.ponziBad__png;
			case shibaCoin:
				graphic = AssetPaths.shibaCoin__png;
		}
		loadGraphic(graphic);

		// // 面向右邊時使用鏡像的左邊圖片
		// setFacingFlip(FlxObject.LEFT, false, false);
		// setFacingFlip(FlxObject.RIGHT, true, false);

		// // 走路動畫
		// animation.add("lr", [4, 3, 5, 3], 6, false);
		// animation.add("u", [7, 6, 8, 6], 6, false);
		// animation.add("d", [1, 0, 2, 0], 6, false);

		// 滑壘強度
		drag.x = drag.y = 10;

		// width = 8;
		// height = 14;
		// offset.x = 4;
		// offset.y = 2;

		// 腦
		brain = new FSM(idle);
		idleTimer = 0;
		playerPosition = FlxPoint.get();
	}

	// 燃燒的錢
	public function enemyFire()
	{
		onFire = true;
		alive = false;
		loadGraphic(AssetPaths.ponziFire__png, true, 64, 64);
		animation.add("fire", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10, false);
		animation.play("fire");
	}

	// 閒閒狀態
	function idle(elapsed:Float)
	{
		// 如果看見玩家就變成追趕狀態
		if (seesPlayer && alive)
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

	public function changeType(type:EnemyType)
	{
		if (this.type != type)
		{
			this.type = type;
			var graphic:String;
			switch (type)
			{
				case REGULAR:
					graphic = AssetPaths.ponzi__png;
				case BOSS:
					graphic = AssetPaths.ponziBad__png;
				case shibaCoin:
					graphic = AssetPaths.shibaCoin__png;
			}
			loadGraphic(graphic, true, 64, 64);
		}
	}

	override function update(elapsed:Float)
	{
		// 如果敵人在動的話
		/*if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				// 什麼時候臉該面向哪邊，以x、y的速度方向判斷
				if (Math.abs(velocity.x) > Math.abs(velocity.y))
				{
					if (velocity.x < 0)
						facing = LEFT;
					else
						facing = RIGHT;
				}
				else
				{
					if (velocity.y < 0)
						facing = UP;
					else
						facing = DOWN;
				}
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
		}*/
		if (onFire && animation.finished)
		{
			exists = false;
		}
		if (this.isFlickering())
			return;
		brain.update(elapsed);
		super.update(elapsed);
	}
}
