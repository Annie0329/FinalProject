package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	// 玩家
	var player:Player;
	var bag:Bag;
	var playerPoint:FlxPoint;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var txt:Bool = true;
	var talkYes:Bool = false;
	var talkId:Int;

	// 香蕉和他的變數
	var banana:FlxTypedGroup<FlxSprite> = null;
	var bananaSound:FlxSound;

	// 其他角色
	var doge:FlxSprite;
	var lake:FlxSprite;
	var monument:FlxSprite;

	var ming:FlxSprite;

	var sbGreen:FlxSprite;
	var sbRed:FlxSprite;
	var sbBlue:FlxSprite;

	var enemies:FlxTypedGroup<Enemy>;
	var health:Int = 3;
	var inCombat:Bool = false;
	var combatHud:CombatHUD;

	var shop:FlxSprite;
	var minerDoor:FlxSprite;
	var minerOpen:Bool = false;
	var saveStone:FlxTypedGroup<FlxSprite> = null;
	var saveStoneId:Int = 19;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var loadsave:Bool;

	var talk:String = "none";
	var getBag:Bool = false;

	// 之後記得存起來
	var getMing:Bool = false;
	var mingFinish:Bool = false;

	// 除錯ufo
	var ufo:FlxText;

	var save:FlxSave;

	/**
		*來自MenuState的呼喚，我們到底要不要用存檔檔案
		*@param loadsave
	 */
	public function new(loadsave:Bool)
	{
		super();
		this.loadsave = loadsave; // 這個loadsave等於那個loadsave(咒語)
	}

	// 加好加滿
	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.monumentMap__json);

		// 地面
		ground = map.loadTilemap(AssetPaths.mtSmall__png, "ground");
		ground.follow();
		add(ground);

		// 路
		road = map.loadTilemap(AssetPaths.mtSmall__png, "road");
		road.follow();
		add(road);

		// 牆
		walls = map.loadTilemap(AssetPaths.mtSmall__png, "wall");
		walls.follow();
		add(walls);

		// 香蕉
		banana = new FlxTypedGroup<FlxSprite>();
		add(banana);
		bananaSound = FlxG.sound.load(AssetPaths.getBanana__wav);

		// 湖
		lake = new FlxSprite().makeGraphic(80, 160, FlxColor.TRANSPARENT);
		lake.immovable = true;
		add(lake);

		// 紀念碑
		monument = new FlxSprite(AssetPaths.monument__png);
		monument.immovable = true;
		add(monument);

		// 存檔點
		saveStone = new FlxTypedGroup<FlxSprite>();
		add(saveStone);

		// 礦場門
		minerDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 160, 80);
		minerDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		minerDoor.immovable = true;
		minerDoor.setSize(40, 20);
		minerDoor.offset.set(60, 30);
		add(minerDoor);
		minerDoor.animation.play("glow");

		// 商店
		shop = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// Doge
		doge = new FlxSprite(AssetPaths.doge__png);
		doge.immovable = true;
		add(doge);

		// 阿明
		ming = new FlxSprite(0, 0).makeGraphic(80, 80, FlxColor.PURPLE);
		ming.immovable = true;
		add(ming);

		sbRed = new FlxSprite(AssetPaths.sbRed__png);
		sbRed.immovable = true;
		add(sbRed);

		sbBlue = new FlxSprite(AssetPaths.sbBlue__png);
		sbBlue.immovable = true;
		add(sbBlue);

		sbGreen = new FlxSprite(AssetPaths.sbGreen__png);
		sbGreen.immovable = true;
		add(sbGreen);

		// 敵人
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		// 地圖在前面的物件
		through = map.loadTilemap(AssetPaths.mtSmall__png, "through");
		through.follow();
		add(through);

		// 打人介面
		combatHud = new CombatHUD();
		add(combatHud);

		// 對話框
		dia = new Dia();
		add(dia);

		// 包包介面
		bag = new Bag();
		add(bag);

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 除錯ufo
		ufo = new FlxText(0, 0, 200, "ufo", 20);
		ufo.color = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		// 儲存資料的元件
		save = new FlxSave();
		save.bind("DiaTest");
		if (loadsave)
		{
			if (save.data.bananaValue != null && save.data.diamondValue != null)
			{
				bag.bananaCounter = save.data.bananaValue;
				bag.diamondCounter = save.data.diamondValue;
				bag.updateBag();
			}
			if (save.data.playerBag != null)
			{
				player.playerBag = save.data.playerBag;
				if (player.playerBag)
					player.playerBagPic();
			}
			if (save.data.playerPos != null && save.data.place != null)
			{
				if (save.data.place == "menu")
					player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				else if (save.data.place == "miner")
				{
					player.setPosition(minerDoor.x - 100, minerDoor.y + 32);
					save.data.bananaValue = bag.bananaCounter;
					save.data.diamondValue = bag.diamondCounter;
					save.data.playerBag = player.playerBag;
					save.data.playerPos = player.getPosition();
					save.data.place = "monument";
					save.flush();
				}
			}
		}
		else
		{
			name = AssetPaths.c1Opening__txt;
			getBag = true;
			playerUpDown();
			dia.show(name, true);
		}

		FlxG.mouse.visible = false;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	// 設位置
	public function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y + 32);

			case "guy":
				doge.setPosition(x, y);

			case "ming":
				ming.setPosition(x, y);

			case "sbRed":
				sbRed.setPosition(x, y);

			case "sbBlue":
				sbBlue.setPosition(x, y);

			case "sbGreen":
				sbGreen.setPosition(x, y);

			// 把敵人移到地磚水平中心
			case "enemy":
				enemies.add(new Enemy(x + 4, y, REGULAR));
			case "boss":
				enemies.add(new Enemy(x + 4, y, BOSS));

			case "banana":
				var b = new FlxSprite(x + 20, y + 20).loadGraphic(AssetPaths.banana__png, true, 40, 40);
				b.animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5, true);
				b.animation.play("spin");
				b.immovable = true;
				banana.add(b);

			case "lake":
				lake.setPosition(x, y);

			case "monument":
				monument.setPosition(x, y);

			case "saveStone":
				var ss = new FlxSprite(x, y).loadGraphic(AssetPaths.saveStone__png, true, 80, 80);
				ss.animation.add("shine", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 10, true);
				ss.animation.play("shine");
				ss.immovable = true;
				saveStone.add(ss);

			case "minerDoor":
				minerDoor.setPosition(x, y);

			case "shop":
				shop.setPosition(x, y);
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// 除錯大隊
		ufo.text = Std.string(FlxG.mouse.screenX) + "," + Std.string(FlxG.mouse.screenY);
		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			// ufo.visible = true;
			// save.erase();
		}
		if (inCombat)
		{
			if (!combatHud.visible)
			{
				health = combatHud.playerHealth;

				// 如果被打死就扣錢
				if (combatHud.outcome == DEFEAT)
				{
					combatHud.enemy.kill();
					if (combatHud.enemy.type == BOSS)
					{
						bag.diamondCounter -= 100;
						name = ":N:你失去了100元。";
					}
					else if (combatHud.enemy.type == REGULAR)
					{
						bag.diamondCounter -= 50;
						name = ":N:你失去了50元。";
					}

					txt = false;
					playerUpDown();
					dia.show(name, txt);
				}
				else if (combatHud.outcome == VICTORY)
				{
					combatHud.enemy.kill();
					if (combatHud.enemy.type == BOSS)
					{
						bag.diamondCounter += 200;
						name = ":N:你獲得了200元！";
					}
					else if (combatHud.enemy.type == REGULAR)
					{
						bag.diamondCounter += 100;
						name = ":N:你獲得了100元！";
					}
					txt = false;
					playerUpDown();
					dia.show(name, txt);
				}
				else
				{
					combatHud.enemy.flicker();
				}

				inCombat = false;
				player.active = true;
				enemies.active = true;
				bag.updateBag();
			}
		}
		else
		{
			updateWhenDiaInvisible();
			updateTalking();
			updateEsc();
			updateC();
			// 碰撞爆
			FlxG.overlap(player, ground);
			FlxG.overlap(player, road);
			FlxG.collide(player, walls);
			FlxG.overlap(player, through);

			FlxG.collide(player, doge, ultimateTalk);
			FlxG.collide(player, ming, ultimateTalk);
			FlxG.collide(player, sbRed, ultimateTalk);
			FlxG.collide(player, sbBlue, ultimateTalk);
			FlxG.collide(player, sbGreen, ultimateTalk);

			FlxG.collide(player, lake, ultimateTalk);
			FlxG.collide(player, monument, ultimateTalk);
			FlxG.collide(player, saveStone, saveFile);
			FlxG.overlap(player, banana, getBanana);

			FlxG.collide(player, shop, shopOpen);
			FlxG.collide(player, minerDoor, goToMiner);

			FlxG.collide(enemies, walls);
			FlxG.collide(enemies, road);
			enemies.forEachAlive(checkEnemyVision);
			FlxG.overlap(player, enemies, playerTouchEnemy);
		}
	}

	function playerTouchEnemy(player:Player, enemy:Enemy)
	{
		if (player.alive && player.exists && enemy.alive && enemy.exists && !enemy.isFlickering())
		{
			startCombat(enemy);
		}
	}

	function startCombat(enemy:Enemy)
	{
		inCombat = true;
		player.active = false;
		enemies.active = false;
		combatHud.initCombat(health, enemy);
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

	// 終極對話！
	function ultimateTalk(player:Player, sprite:FlxSprite)
	{
		talkYes = true;
		talkId = sprite.ID;
	}

	// Kris get the banana
	function getBanana(player:Player, banana:FlxSprite)
	{
		banana.kill();
		bananaSound.play(true);
		bag.bananaCounter++;
		bag.updateBag();
	}

	// 存檔
	function saveFile(player:Player, saveStone:FlxSprite)
	{
		talkYes = true;
		talkId = saveStoneId;
	}

	// 去礦場
	function goToMiner(player:Player, minerDoor:FlxSprite)
	{
		if (bag.diamondCounter >= 1)
		{
			name = ":N:跟你收1元過路費。:N:你給了傳送門1元。";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
			bag.diamondCounter--;
			bag.updateBag();
			minerOpen = true;
		}
		else
		{
			name = ":N:你沒有1元過路費。";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 商店開門
	function shopOpen(player:Player, shop:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			bag.buyAndSell();
		});
	}

	// 對話大滿貫
	function updateTalking()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);

		// 如果玩家離開就不能對話
		if (FlxG.keys.anyJustPressed([A, S, W, D, UP, DOWN, LEFT, RIGHT]))
			talkYes = false;

		// 如果按enter就對話
		if (talkYes && enter && !bag.visible)
		{
			talkYes = false;
			if (talkId == doge.ID)
			{
				if (getMing)
				{
					name = ":D:昨天的交易？嗯，我借給小綠20元。";
					txt = false;
				}
				else
				{
					name = AssetPaths.forestMission__txt;
					txt = true;
				}
			}
			if (talkId == lake.ID)
			{
				name = AssetPaths.lakeTalking__txt;
				txt = true;
			}
			if (talkId == monument.ID)
			{
				name = ":N:裡面似乎有毀壞的記帳本。";
				txt = false;
			}

			if (talkId == ming.ID)
			{
				if (getMing)
				{
					name = AssetPaths.mingClue__txt;
					dia.getPointer("ming");
					txt = true;
				}
				else
				{
					name = AssetPaths.mingTalking__txt;
					getMing = true;
					txt = true;
				}
			}
			if (talkId == sbRed.ID)
			{
				if (getMing)
					name = ":SR:我昨天忙翻了！交易？記不太清楚，但我確定沒借錢給Doge。";
				else
					name = ":SR:你好呀。";
				txt = false;
			}
			if (talkId == sbBlue.ID)
			{
				if (getMing)
					name = ":SB:交易...我記得我沒有借給小紅錢。";
				else
					name = ":SB:今天天氣真好。";
				txt = false;
			}
			if (talkId == sbGreen.ID)
			{
				if (getMing)
					name = ":SG:交易啊？我借給小藍30元喔。";
				else
					name = ":SG:汪汪。";
				txt = false;
			}
			// 存檔點
			if (talkId == saveStoneId)
			{
				save.data.bananaValue = bag.bananaCounter;
				save.data.diamondValue = bag.diamondCounter;
				save.data.playerBag = player.playerBag;
				save.data.playerPos = player.getPosition();
				save.data.place = "monument";
				health = 3;
				save.flush();
				name = ":N:存檔成功！";
				txt = false;
			}
			talkId = 0;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.visible)
		{
			player.active = false;
			enemies.active = false;
		}
		else
		{
			player.active = true;
			enemies.active = true;
		}

		// 對話結束時要做什麼合集
		if (!dia.visible)
		{
			if (getBag)
			{
				player.playerBagPic();
				getBag = false;
			}
			// 答對誰是謊報者的題目
			if (dia.mingWin && !mingFinish)
			{
				bag.diamondCounter += 50;
				bag.updateBag();
				dia.mingWin = false;
				mingFinish = true;
			}
			// 有錢就開礦場門
			if (minerOpen)
			{
				minerOpen = false;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
				{
					save.data.bananaValue = bag.bananaCounter;
					save.data.diamondValue = bag.diamondCounter;
					save.data.playerBag = player.playerBag;
					save.data.place = "monument";
					save.flush();
					FlxG.switchState(new MinerState(true));
				});
			}
		}
	}

	// 如果玩家在螢幕上方，對話框就放到下方
	function playerUpDown()
	{
		// 這串偉大的公式是把玩家的世界座標轉成螢幕座標，感謝Kino大大
		// https://kinocreates.io/tutorials/haxeflixel-screen-vs-world-position/
		if (player.y - player.height / 2 - (FlxG.camera.scroll.y * player.scrollFactor.y) > FlxG.height / 2)
			dia.diaUpDown = "up";
		else
			dia.diaUpDown = "down";
	}

	// 如果按esc鍵就回選單
	function updateEsc()
	{
		var esc = FlxG.keys.anyJustReleased([ESCAPE]);
		if (esc && !dia.visible)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}

	// 按C開啟包包
	function updateC()
	{
		var c = FlxG.keys.anyJustReleased([C]);
		if (c && !dia.visible && player.playerBag && !bag.visible)
		{
			bag.bagUi();
		}
	}
}
