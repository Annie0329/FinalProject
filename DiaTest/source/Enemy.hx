package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

using flixel.util.FlxSpriteUtil;

// 定義敵人的類型
enum EnemyType
{
	shibaCoin;
	cloudMiner;
	nft;
	spartanMiner;
}

class FSM
{
	public var activeState:Float->Void;

	public function new(initialState:Float->Void)
	{
		activeState = initialState;
	}

	public function update(elapsed:Float)
	{
		activeState(elapsed);
	}
}

class Enemy extends FlxSprite
{
	// 跑多快
	var SPEED:Float = 100;

	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	var enemiesStart:Int = 200;
	var enemiesEnd:Int = 1080;

	public var type(default, null):EnemyType;
	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;
	public var onFire:Bool = false;

	public function new(x:Float, y:Float, type:EnemyType)
	{
		super(x, y);
		this.type = type;

		// 呼叫敵人或魔王的圖片
		switchType(type);
		// 滑壘強度
		drag.x = drag.y = 10;

		// 腦
		brain = new FSM(idle);
		idleTimer = 0;
		playerPosition = FlxPoint.get();
	}

	function switchType(type)
	{
		switch (type)
		{
			case shibaCoin:
				loadGraphic(AssetPaths.shibaCoin__png, true, 64, 64);
				// 走路動畫
				animation.add("lr", [4, 3, 5, 3], 6, false);
				animation.add("u", [7, 6, 8, 6], 6, false);
				animation.add("d", [1, 0, 2, 0], 6, false);

			case cloudMiner:
				loadGraphic(AssetPaths.cloudMiner__png);
			case nft:
				loadGraphic(AssetPaths.nft__png, true, 56, 64);
				animation.frameIndex = 1;
			case spartanMiner:
				loadGraphic(AssetPaths.spartanMiner__png, true, 64, 64);
				animation.add("lrSpartan", [0, 1, 2, 3], 6, false);
				immovable = true;
		}
		// 面向右邊時使用鏡像的左邊圖片
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
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
			if (type == spartanMiner)
			{
				if (x == enemiesStart)
				{
					FlxTween.tween(this, {x: enemiesEnd}, 3);
					facing = RIGHT;
				}
				else if (x == enemiesEnd)
				{
					FlxTween.tween(this, {x: enemiesStart}, 3);
					facing = LEFT;
				}
				animation.play("lrSpartan");
			}
			else
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
					velocity.set(SPEED, 0);

					velocity.rotate(FlxPoint.weak(), moveDirection);
				}
				// 隨機選個數
				idleTimer = FlxG.random.int(1, 4);
			}
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
			FlxVelocity.moveTowardsPoint(this, playerPosition, Std.int(SPEED));
		}
	}

	public function changeType(type:EnemyType)
	{
		if (this.type != type)
		{
			this.type = type;
			switchType(type);
		}
	}

	override function update(elapsed:Float)
	{
		if (onFire && animation.finished)
		{
			exists = false;
		}

		// 如果敵人在動的話
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
		{
			switch (type)
			{
				case cloudMiner, nft:
				case shibaCoin: // 什麼時候臉該面向哪邊，以x、y的速度方向判斷
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
				case spartanMiner:
			}
		}

		if (this.isFlickering())
			return;
		brain.update(elapsed);
		super.update(elapsed);
	}
}
