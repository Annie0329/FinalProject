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

	var enemiesStart:Int = 280;
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
				loadGraphic(AssetPaths.shibaCoin__png);
			case cloudMiner:
				loadGraphic(AssetPaths.cloudMiner__png);
			case nft:
				loadGraphic(AssetPaths.nft__png, true, 56, 64);
				animation.frameIndex = 1;
			case spartanMiner:
				loadGraphic(AssetPaths.spartanMiner__png);
				elasticity = 1;
				immovable = true;
		}
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
					FlxTween.tween(this, {x: enemiesEnd}, 3);
				else if (x == enemiesEnd)
					FlxTween.tween(this, {x: enemiesStart}, 3);
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
					if (type == spartanMiner)
						velocity.set(SPEED * 1.5, 0);
					else
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
		if (this.isFlickering())
			return;
		brain.update(elapsed);
		super.update(elapsed);
	}
}
