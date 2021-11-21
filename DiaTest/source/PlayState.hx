package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

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

	// 香蕉和他的變數
	var banana:FlxTypedGroup<FlxSprite> = null;

	// 敵人
	var enemies:FlxTypedGroup<Enemy>;
	var inCombat:Bool = false;
	var combatHud:CombatHUD;

	// NPC
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;

	var shop:FlxSprite;
	var minerDoor:FlxSprite;
	var minerOpen:Bool = false;
	var minerYes:Bool = false;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var loadsave:Bool;

	var getBag:Bool = false;

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

		// 礦場門
		minerDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 104, 160);
		minerDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		minerDoor.immovable = true;
		minerDoor.setSize(104, 40);
		minerDoor.offset.set(0, 120);
		add(minerDoor);
		minerDoor.animation.play("glow");

		// 商店
		shop = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		npc = new FlxTypedGroup<NPC>();
		add(npc);

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
		// ufo.color = FlxColor.BLACK;
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
				if (save.data.place == "monument")
					player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				else if (save.data.place == "miner")
				{
					minerYes = true;
					dia.saveStoneIntro = true;
					player.setPosition(minerDoor.x, minerDoor.y);
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
			player.active = false;
			new FlxTimer().start(1.5, function(timer:FlxTimer)
			{
				name = AssetPaths.c1Opening__txt;
				getBag = true;
				playerUpDown();
				dia.show(name, true);
			});
		}

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(AssetPaths.gameTheme__mp3, 1, true);

		FlxG.mouse.visible = false;
		if (loadsave)
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		else
			FlxG.camera.fade(0xffFFFDE4, 1, true);

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
				npc.add(new NPC(x, y, doge));

			case "ming":
				npc.add(new NPC(x, y, ming));

			case "sbRed":
				npc.add(new NPC(x, y, sbRed));

			case "sbBlue":
				npc.add(new NPC(x, y, sbBlue));

			case "sbGreen":
				npc.add(new NPC(x, y, sbGreen));

			// 敵人
			case "shibaCoin":
				enemies.add(new Enemy(x, y, shibaCoin));

			case "cloudMiner":
				enemies.add(new Enemy(x, y, cloudMiner));
			case "nft":
				enemies.add(new Enemy(x, y, nft));

			case "banana":
				var b = new FlxSprite(x + 20, y + 20).loadGraphic(AssetPaths.banana__png, true, 40, 40);
				b.animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5, true);
				b.animation.play("spin");
				b.immovable = true;
				banana.add(b);

			case "lake":
				npc.add(new NPC(x, y, lake));

			case "monument":
				npc.add(new NPC(x, y, monument));

			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

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
			ufo.visible = true;
			FlxG.mouse.visible = true;
		}
		updateInCombat();
		updateWhenDiaInvisible();
		updateTalking();
		updateEsc();
		updateC();

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);

		FlxG.collide(player, npc, npcTalk);

		FlxG.overlap(player, banana, getBanana);

		FlxG.collide(player, shop, shopOpen);
		FlxG.collide(player, minerDoor, goToMiner);

		FlxG.collide(enemies, walls);
		FlxG.collide(enemies, road);
		enemies.forEachAlive(checkEnemyVision);
		FlxG.collide(player, enemies, playerTouchEnemy);
	}

	// 打架結束囉
	function updateInCombat()
	{
		if (inCombat && !combatHud.visible)
		{
			bag.diamondCounter = combatHud.diamond;
			bag.updateBag();
			inCombat = false;
			switch (combatHud.outcome)
			{
				case WIN, FLEE:
					combatHud.enemy.kill();
				case LOSE:
					combatHud.enemy.enemyFire();
			}
			switch (combatHud.enemy.type)
			{
				case shibaCoin:
					if (combatHud.outcome == WIN)
						name = ":D:恭喜你賺到錢了！";
					else if (combatHud.outcome == LOSE)
						name = ":D:哎呀，真可惜！";
					else
						name = ":D:柴犬幣很好賺呢，下次試試看跟他們交涉吧！";

				case cloudMiner:
					if (combatHud.outcome == FLEE)
						name = ":D:你躲過詐騙了呢！";
					else
						name = ":D:這是詐騙喔！";

				case nft:
					if (combatHud.outcome == WIN)
						name = ":D:你真幸運，買到時下流行的NFT花樣。";
					else if (combatHud.outcome == LOSE)
						name = ":D:沒有關係，流行趨勢本來就是瞬息萬變的。";
					else
						name = ":D:NFT還不錯，下次試試看吧。";
				case spartanMiner:
			}
			txt = false;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 如果你碰了敵人，就代表敵人碰了你
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
		combatHud.initCombat(bag.diamondCounter, enemy);
	}

	// 檢查敵人視野
	function checkEnemyVision(enemy:Enemy)
	{
		if (enemy.alive && walls.ray(enemy.getMidpoint(), player.getMidpoint()) && road.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.seesPlayer = true;
			// ！！是在這裡定位玩家位置的！
			enemy.playerPosition = player.getMidpoint();
		}
		else
			enemy.seesPlayer = false;
	}

	function npcTalk(player:Player, npc:NPC)
	{
		talkYes = true;
		npcType = npc.type;
	}

	// Kris get the banana
	function getBanana(player:Player, banana:FlxSprite)
	{
		banana.kill();
		bag.bananaCounter++;
		bag.updateBag();
	}

	// 去礦場
	function goToMiner(player:Player, minerDoor:FlxSprite)
	{
		if (minerYes)
		{
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
		else
		{
			if (bag.diamondCounter >= 1)
			{
				name = ":N:跟你收100能量幣過路費。:N:你給了傳送門100能量幣。";
				txt = false;
				playerUpDown();
				dia.show(name, txt);
				minerOpen = true;
			}
			else
			{
				name = ":N:你沒有100能量幣過路費。";
				txt = false;
				playerUpDown();
				dia.show(name, txt);
			}
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
			playerUpDown();

			// 存檔點
			if (npcType == saveStone)
			{
				save.data.bananaValue = bag.bananaCounter;
				save.data.diamondValue = bag.diamondCounter;
				save.data.playerBag = player.playerBag;
				save.data.playerPos = player.getPosition();
				save.data.place = "monument";
				save.flush();
			}

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.visible || combatHud.visible)
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
			// 有錢就開礦場門
			if (minerOpen)
			{
				minerOpen = false;
				minerYes = true;
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
