package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

// 定義敵人的類型
enum EnemyType
{
	shibaCoin;
	cloudMiner;
	nft;
	spartanMiner;
	rod;
	starter;
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

	var enemyStart:Int = 240;
	var enemyEnd:Int = 2760;

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
		drag.x = drag.y = 30;

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
				loadGraphic(AssetPaths.shibaCoin__png, true, 168, 192);
				// 走路動畫
				animation.add("lr", [3, 4, 5, 4], 6, false);
				animation.add("u", [6, 7, 8, 7], 6, false);
				animation.add("d", [0, 1, 2, 1], 6, false);
			case cloudMiner:
				loadGraphic(AssetPaths.cloudMiner__png);
			case nft:
				loadGraphic(AssetPaths.nft__png, true, 168, 192);
				animation.frameIndex = 0;

			case spartanMiner:
				loadGraphic(AssetPaths.spartanMiner__png, true, 192, 192);
				animation.add("lrSpartan", [0, 1, 2, 3], 6, false);
				immovable = true;
			case rod:
				loadGraphic(AssetPaths.rod__png);

			case starter:
				loadGraphic(AssetPaths.apeStarter__png);
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
		loadGraphic(AssetPaths.ponziFire__png, true, 192, 192);
		animation.add("fire", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10, false);
		animation.play("fire");
	}

	// 閒閒狀態
	function idle(elapsed:Float)
	{
		if (idleTimer <= 0)
		{
			switch (type)
			{
				case spartanMiner:
					if (x == enemyStart)
					{
						FlxTween.tween(this, {x: enemyEnd}, 3);
						facing = RIGHT;
					}
					else if (x == enemyEnd)
					{
						FlxTween.tween(this, {x: enemyStart}, 3);
						facing = LEFT;
					}
					animation.play("lrSpartan");
				case shibaCoin, cloudMiner, nft, rod:
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
				case starter:
			}
		}
		else
			idleTimer -= elapsed;
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
				case cloudMiner, nft, spartanMiner, rod, starter:
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
			}
		}

		if (this.alpha == 0.5)
			return;
		brain.update(elapsed);
		super.update(elapsed);
	}
}
