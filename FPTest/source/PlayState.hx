package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var coins:FlxTypedGroup<Coin>;
	var enemies:FlxTypedGroup<Enemy>;

	var hud:HUD;
	var money:Int = 0;
	var health:Int = 3;

	override public function create()
	{
		// 加地圖
		map = new FlxOgmo3Loader(AssetPaths.FPTest__ogmo, AssetPaths.room_001__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		// 在這裡規定幾號的地磚可以通過，幾號不行
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(2, FlxObject.ANY);
		add(walls);

		// 加錢
		coins = new FlxTypedGroup<Coin>();
		add(coins);

		// 加敵人
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		// 加玩家
		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);

		// 攝影機跟著我  Camera follow me!
		FlxG.camera.follow(player, TOPDOWN, 1);

		hud = new HUD();
		add(hud);
		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			// 把玩家的x跟y弄得跟地圖設定的一樣
			case "player":
				player.setPosition(x, y);

			// 把錢移到地磚中心
			case "coin":
				coins.add(new Coin(x + 16, y + 16));

			// 把敵人移到地磚水平中心
			case "enemy":
				enemies.add(new Enemy(x, y, REGULAR));
			case "boss":
				enemies.add(new Enemy(x, y, BOSS));
		}
	}

	// 如果玩家跟錢都活著又存在，玩家就可以就蒐集錢
	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			money++;
			hud.updateHUD(health, money);
			coin.kill();
		}
	}

	function checkEnemyVision(enemy:Enemy)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.seesPlayer = true;
			// ！！是在這裡定位玩家位置的！
			enemy.playerPosition = player.getMidpoint();
		}
		else
			enemy.seesPlayer = false;
	}

	override public function update(elapsed:Float)
	{
		// 看看玩家有沒有碰到牆
		FlxG.collide(player, walls);
		// 看看玩家跟錢有沒有重疊
		FlxG.overlap(player, coins, playerTouchCoin);
		FlxG.collide(enemies, walls);
		enemies.forEachAlive(checkEnemyVision);

		super.update(elapsed);
	}
}
