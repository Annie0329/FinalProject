package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

class MinerState extends FlxState
{
	// 玩家
	var player:Player;
	var bag:Bag;

	// 各關目標
	var stoneGoal:Int = 5;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var txt:Bool = true;
	var talkYes:Bool = false;

	// 敵人
	var enemies:FlxTypedGroup<Enemy>;
	var inCombat:Bool = false;
	var combatHud:CombatHUD;
	var enemyFlicker:Bool = false;

	// 其他角色
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;

	var shop:FlxSprite;
	var monumentDoor:FlxSprite;
	var streetDoor:FlxSprite;
	var minerGate:FlxSprite;

	// 箱子
	var box:FlxSprite;
	var roadStart:Int = 800;
	var roadEnd:Int = 1440;
	var boxPos:Float;

	// 石頭
	var stone:FlxTypedGroup<FlxSprite> = null;
	var stoneCounter:Int = 0;
	var stoneCounterText:FlxText;
	var stoneCounterIcon:FlxSprite;
	var stoneYes:Bool = false;
	var minerTimerText:FlxText;
	var minerTimerIcon:FlxSprite;
	var timer:FlxTimer;
	var minerTimeSet:Int = 60;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var torch:FlxTypedGroup<FlxSprite> = null;

	// 除錯ufo
	var ufo:FlxText;
	var save:FlxSave;

	// 加好加滿
	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.minerMap__json);

		// 地面
		ground = map.loadTilemap(AssetPaths.mtSmall__png, "ground");
		ground.follow();
		add(ground);

		// 路
		road = map.loadTilemap(AssetPaths.mtSmall__png, "road");
		road.follow();
		add(road);

		// 礦場大門
		minerGate = new FlxSprite(AssetPaths.minerGate__png);
		minerGate.immovable = true;
		add(minerGate);

		// 牆
		walls = map.loadTilemap(AssetPaths.mtSmall__png, "wall");
		walls.follow();
		add(walls);

		// 火把
		torch = new FlxTypedGroup<FlxSprite>();
		add(torch);

		// 紀念碑傳送門
		monumentDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 104, 160);
		monumentDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		monumentDoor.setSize(104, 40);
		monumentDoor.offset.set(0, 120);
		monumentDoor.immovable = true;
		add(monumentDoor);
		monumentDoor.animation.play("glow");

		// defi街傳送門
		streetDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 104, 160);
		streetDoor.animation.add("glowStreet", [0, 1, 2, 3], 3, true);
		streetDoor.setSize(104, 40);
		streetDoor.offset.set(0, 120);
		streetDoor.immovable = true;
		add(streetDoor);
		streetDoor.animation.play("glowStreet");

		// 商店
		shop = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// 石頭
		stone = new FlxTypedGroup<FlxSprite>();
		add(stone);

		// 箱子
		box = new FlxSprite(AssetPaths.boxEmpty__png);
		box.immovable = true;
		add(box);

		// 敵人
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		npc = new FlxTypedGroup<NPC>();
		add(npc);

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		// 地圖在前面的物件
		through = map.loadTilemap(AssetPaths.mtSmall__png, "through");
		through.follow();
		add(through);

		// 包包介面
		bag = new Bag();
		add(bag);

		// 打人介面
		combatHud = new CombatHUD();
		add(combatHud);

		// 對話框
		dia = new Dia();
		add(dia);

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 石頭圖示
		stoneCounterIcon = new FlxSprite(FlxG.width - 109, 10).loadGraphic(AssetPaths.stoneIcon__png);
		stoneCounterIcon.scrollFactor.set(0, 0);
		add(stoneCounterIcon);
		stoneCounterIcon.visible = false;

		// 石頭數目
		stoneCounterText = new FlxText(stoneCounterIcon.x + 45, stoneCounterIcon.y + stoneCounterIcon.height / 2 - 13, "0", 20);
		stoneCounterText.scrollFactor.set(0, 0);
		stoneCounterText.color = FlxColor.BLACK;
		add(stoneCounterText);
		stoneCounterText.visible = false;

		// 計時器
		minerTimerIcon = new FlxSprite(stoneCounterIcon.x, stoneCounterIcon.y + stoneCounterIcon.height + 10, AssetPaths.minerTimerIcon__png);
		minerTimerIcon.scrollFactor.set(0, 0);
		add(minerTimerIcon);
		minerTimerIcon.visible = false;

		minerTimerText = new FlxText(minerTimerIcon.x, minerTimerIcon.y + 25, minerTimerIcon.width, "0", 20);
		minerTimerText.color = FlxColor.BLACK;
		minerTimerText.alignment = CENTER;
		minerTimerText.scrollFactor.set(0, 0);
		add(minerTimerText);
		minerTimerText.visible = false;

		// 除錯ufo
		ufo = new FlxText(0, 0, 200, "ufo", 20);
		// ufo.color = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		// 儲存資料的能量幣件
		save = new FlxSave();
		save.bind("DiaTest");

		loadFile();

		// 播音樂
		// 最終上傳記得消除註解
		// if (FlxG.sound.music == null)
		// 	FlxG.sound.playMusic(AssetPaths.gameTheme__mp3, 1, true);

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
				player.setPosition(x, y);
			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "shop":
				shop.setPosition(x, y);
			case "monumentDoor":
				monumentDoor.setPosition(x + 28, y);
			case "streetDoor":
				streetDoor.setPosition(x + 28, y);
			case "minerGate":
				minerGate.setPosition(x, y);

			case "spartan":
				npc.add(new NPC(x, y, spartan));

			case "stone":
				var s = new FlxSprite(x, y, AssetPaths.stone__png);
				stone.add(s);

			case "box":
				box.setPosition(x - 2, y);
				boxPos = box.y;

			case "spartanMiner":
				enemies.add(new Enemy(x, y, spartanMiner));
			case "starter":
				enemies.add(new Enemy(x, y, starter));

			case "torch":
				var t = new FlxSprite(x, y).loadGraphic(AssetPaths.torch__png, true, 40, 80);
				t.animation.add("burn", [0, 1, 2, 3, 4], 6, true);
				t.animation.play("burn");
				t.immovable = true;
				torch.add(t);
		}
	}

	// 讀檔啦
	function loadFile()
	{
		// 一樣的
		// 包包
		bag.diamondUi.visible = true;
		bag.bananaCounter = save.data.bananaValue;
		bag.diamondCounter = save.data.diamondValue;
		bag.shibaInvest = save.data.shibaInvest;
		bag.shibaWave = save.data.shibaWave;
		bag.bananaCoin = save.data.bananaCoin;
		bag.appleCoin = save.data.appleCoin;
		bag.updateBag();

		if (bag.shibaInvest != 0)
			bag.countShibaWave();
		else
			bag.shibaUi.visible = false;
		dia.saveStoneIntro = save.data.saveStoneIntro;

		// 不一樣的
		dia.stoneTextYes = save.data.stoneTextYes;
		combatHud.touchStarter = save.data.touchStarter;
		if (save.data.playerPos != null && save.data.place != null)
		{
			if (save.data.place == "miner")
				player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
			else if (save.data.place == "monument")
			{
				player.setPosition(monumentDoor.x + (monumentDoor.width - player.width) / 2, monumentDoor.y - 20);
				saveFile();
			}
			else if (save.data.place == "street")
			{
				player.setPosition(streetDoor.x + (streetDoor.width - player.width) / 2, streetDoor.y - 20);
				saveFile();
			}
		}
	}

	// 存檔啦
	function saveFile()
	{
		// 一樣的
		// 能量幣和香蕉數目
		save.data.bananaValue = bag.bananaCounter;
		save.data.diamondValue = bag.diamondCounter;
		save.data.shibaInvest = bag.shibaInvest;
		save.data.shibaWave = bag.shibaWave;
		save.data.bananaCoin = bag.bananaCoin;
		save.data.appleCoin = bag.appleCoin;
		// 跟誰講過話
		save.data.saveStoneIntro = dia.saveStoneIntro;

		// 玩家位置
		save.data.playerPos = player.getPosition();

		// 不一樣的
		save.data.stoneTextYes = dia.stoneTextYes;
		save.data.place = "miner";
		save.data.touchStarter = combatHud.touchStarter;
		save.flush();
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateInCombat();
		updateTalking();
		updateEsc();
		updateC();
		updateTimer();

		// 除錯大隊
		// ufo.text = Std.string(player.getPosition());
		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			ufo.visible = true;
			// save.erase();
		}

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);
		FlxG.collide(player, minerGate);

		FlxG.collide(player, npc, npcTalk);

		FlxG.collide(player, shop, shopOpen);
		FlxG.collide(player, monumentDoor, goToMonument);
		FlxG.collide(player, streetDoor, goToStreet);

		FlxG.overlap(player, stone, playerGotStone);
		FlxG.collide(player, box, stoneInsideBox);
		FlxG.collide(player, enemies, touchEnemy);

		FlxG.collide(enemies, walls);
		FlxG.overlap(enemies, stone, enemyGotStone);
		FlxG.collide(enemies);
		FlxG.collide(enemies, npc);

		FlxG.collide(stone);
		FlxG.collide(stone, walls);

		FlxG.collide(box, walls);
	}

	// NPC對話
	function npcTalk(player:Player, npc:NPC)
	{
		talkYes = true;
		npcType = npc.type;
	}

	// 去紀念碑
	function goToMonument(player:Player, monumentDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			saveFile();
			FlxG.switchState(new PlayState(true));
		});
	}

	// 去defi街
	function goToStreet(player:Player, streetDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			saveFile();
			FlxG.switchState(new StreetState());
		});
	}

	// 玩家收集到石頭了
	function playerGotStone(player:Player, stone:FlxSprite)
	{
		stoneCounter++;
		stoneCounterText.text = Std.string(stoneCounter);
		stone.kill();
		if (stoneCounter >= stoneGoal)
			stoneCounterText.color = FlxColor.RED;
		else
			stoneCounterText.color = FlxColor.BLACK;
		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			stone.revive();
		});
	}

	// 敵人收集到石頭了
	function enemyGotStone(enemy:Enemy, stone:FlxSprite)
	{
		stone.kill();
		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			stone.revive();
		});
	}

	// 如果你碰了敵人代表敵人碰了你
	function touchEnemy(player:Player, enemy:Enemy)
	{
		if (enemy.type == spartanMiner)
		{
			FlxG.camera.shake(0.01, 0.1, function()
			{
				stoneCounter--;
				stoneCounterText.text = Std.string(stoneCounter);
				if (stoneCounter >= stoneGoal)
					stoneCounterText.color = FlxColor.RED;
				else
					stoneCounterText.color = FlxColor.BLACK;
			});
		}
		else if ((enemy.type == rod && bag.bananaCoin >= 5) || (enemy.type == starter && bag.diamondCounter >= 5))
		{
			inCombat = true;
			player.active = false;
			enemies.active = false;
			combatHud.initCombat(bag.diamondCounter, bag.diamondText, bag.bananaCoin, bag.appleCoin, enemy);
		}
		else
		{
			if (enemy.type == rod)
				name = ":N:你沒有足夠的香蕉幣！你需要至少 5 香蕉幣！";
			else if (enemy.type == starter)
				name = ":N:你沒有足夠的能量幣！你需要至少 5 能量幣！";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
			combatHud.enemy = enemy;
			enemyFlicker = true;
		}
	}

	// 打架結束囉
	function updateInCombat()
	{
		if (inCombat && !combatHud.visible)
		{
			if (combatHud.enemy.type == starter)
			{
				combatHud.enemy.kill();
				if (combatHud.outcome == WIN)
					name = ":D:你投資了APESTARTER啊！";
				else
					name = ":D:下次可以試試看投資APESTARTER喔。";
			}

			bag.diamondCounter = combatHud.diamond;
			bag.bananaCoin = combatHud.bananaCoin;
			bag.appleCoin = combatHud.appleCoin;
			bag.updateBag();
			inCombat = false;

			txt = false;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 石頭放到車子裡了
	function stoneInsideBox(player:Player, box:FlxSprite)
	{
		if (stoneCounter >= stoneGoal)
		{
			var car = Std.int(stoneCounter / stoneGoal);
			bag.diamondCounter += Std.int(car * 10);
			stoneCounter = stoneCounter % stoneGoal;
			stoneCounterText.text = Std.string(stoneCounter);
			stoneCounterText.color = FlxColor.BLACK;
			box.loadGraphic(AssetPaths.boxFull__png);

			bag.updateBag();

			FlxTween.tween(box, {y: roadEnd}, 2, {
				onComplete: function(_)
				{
					box.y = roadStart;
					box.loadGraphic(AssetPaths.boxEmpty__png);
					FlxTween.tween(box, {y: boxPos}, 2);
				}
			});
		}
	}

	// 計時開始
	function updateTimer()
	{
		// 計時開始時要做的事
		if (minerTimerIcon.visible)
		{
			// 只剩5秒字就變紅色
			minerTimerText.text = Std.string(Std.int(timer.timeLeft));
			if (Std.int(timer.timeLeft) <= 5)
				minerTimerText.color = FlxColor.RED;
			else
				minerTimerText.color = FlxColor.BLACK;
			// 時間到玩家就不准動
			if (timer.finished)
				player.active = false;
		}
			// 如果玩家經過門就啟動計時
		// 用else if是為了避免重複計時(看不見計時器才開始計時)
		else if (player.y < minerGate.y - 40 && player.x < minerGate.x + minerGate.width)
		{
			minerGate.x -= minerGate.width;
			timer = new FlxTimer().start(minerTimeSet, function(timer:FlxTimer)
			{
				minerTimerText.visible = false;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
				{
					player.setPosition(minerGate.x, minerGate.y + 200);

					minerTimerIcon.visible = false;
					stoneCounterIcon.visible = false;
					stoneCounterText.visible = false;
					stoneCounter = 0;
					stoneCounterText.text = Std.string(stoneCounter);

					FlxG.camera.fade(FlxColor.BLACK, 0.33, true, function() {});
				});
			});
			minerTimerText.visible = true;
			minerTimerIcon.visible = true;
			stoneCounterIcon.visible = true;
			stoneCounterText.visible = true;
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
		if (talkYes && enter && !bag.bagUi.visible && !bag.shopUi.visible)
		{
			talkYes = false;
			playerUpDown();

			// 存檔點
			if (npcType == saveStone)
			{
				saveFile();
			}
			else if (npcType == spartan)
			{
				stoneYes = true;
			}

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.shopUi.visible || bag.bagUi.visible || combatHud.visible)
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
			// 礦場大門打開
			if (stoneYes)
			{
				FlxTween.tween(minerGate, {x: minerGate.x + minerGate.width}, 0.5);
				stoneYes = false;
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
		if (c && !dia.visible && (!bag.bagUi.visible && !bag.shopUi.visible))
		{
			bag.bagUiShow();
		}
	}
}
