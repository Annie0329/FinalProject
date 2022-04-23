package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class MinerState extends FlxState
{
	// 玩家
	var player:Player;
	var tip:Tip;
	var bag:Bag;

	// 聲音組
	var cancel:FlxSound;
	var minerPunch:FlxSound;
	var gateSlide:FlxSound;
	var touchEnemy:FlxSound;
	var openBag:FlxSound;
	var doorTele:FlxSound;
	var saveNoise:FlxSound;

	// 各關目標
	var stoneGoal:Int = 5;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var txt:Bool = true;
	var talkYes:Bool = false;

	// 敵人
	var enemy:FlxTypedGroup<Enemy>;
	var inCombat:Bool = false;
	var combatHud:CombatHUD;

	// 其他角色
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;
	var meetStarter:Bool = false;

	var shop:FlxSprite;
	var monumentDoor:FlxSprite;
	var streetDoor:FlxSprite;
	var minerGate:FlxSprite;
	var minerGateX:Float = 0;
	var streetOpen:Bool = false;
	var streetYes:Bool = false;

	// 箱子
	var box:FlxSprite;
	var roadStart:Int = 2400;
	var roadEnd:Int = 4320;
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
	var stoneSound:FlxSound;
	var finalScore:Int = 0;

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
		map = new FlxOgmo3Loader(AssetPaths.deFiMap__ogmo, AssetPaths.minerMap__json);

		// 聲音組
		cancel = FlxG.sound.load(AssetPaths.cancel__ogg);
		minerPunch = FlxG.sound.load(AssetPaths.minerPunch__ogg);
		gateSlide = FlxG.sound.load(AssetPaths.gateSlide__ogg);
		touchEnemy = FlxG.sound.load(AssetPaths.touchEnemy__ogg);
		openBag = FlxG.sound.load(AssetPaths.openBag__ogg);
		doorTele = FlxG.sound.load(AssetPaths.doorTele__ogg);
		saveNoise = FlxG.sound.load(AssetPaths.save__ogg);

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
		// 礦場大門
		minerGate = new FlxSprite(AssetPaths.minerGate__png);
		minerGate.immovable = true;
		add(minerGate);
		// 火把
		torch = new FlxTypedGroup<FlxSprite>();
		add(torch);

		// 紀念碑傳送門
		monumentDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 360, 480);
		monumentDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		monumentDoor.setSize(360, 120);
		monumentDoor.offset.set(0, 360);
		monumentDoor.immovable = true;
		add(monumentDoor);
		monumentDoor.animation.play("glow");

		// defi街傳送門
		streetDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 360, 480);
		streetDoor.animation.add("glowStreet", [0, 1, 2, 3], 3, true);
		streetDoor.setSize(360, 120);
		streetDoor.offset.set(0, 360);
		streetDoor.immovable = true;
		add(streetDoor);
		streetDoor.animation.play("glowStreet");

		// 商店
		shop = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// 石頭
		stone = new FlxTypedGroup<FlxSprite>();
		stoneSound = FlxG.sound.load(AssetPaths.pickUp__ogg);
		add(stone);

		// 箱子
		box = new FlxSprite(AssetPaths.boxEmpty__png);
		box.immovable = true;
		add(box);

		// 敵人
		enemy = new FlxTypedGroup<Enemy>();
		add(enemy);

		npc = new FlxTypedGroup<NPC>();
		add(npc);

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN_TIGHT, 1);

		// 地圖在前面的物件
		through = map.loadTilemap(AssetPaths.mtSmall__png, "through");
		through.follow();
		add(through);

		// 小紙條
		tip = new Tip();
		add(tip);

		// 包包介面
		bag = new Bag();
		add(bag);

		// 打人介面
		combatHud = new CombatHUD();
		add(combatHud);

		// 對話框
		dia = new Dia();
		add(dia);

		// 石頭圖示
		stoneCounterIcon = new FlxSprite(FlxG.width - 327, 30).loadGraphic(AssetPaths.stoneIcon__png);
		stoneCounterIcon.scrollFactor.set(0, 0);
		add(stoneCounterIcon);
		stoneCounterIcon.visible = false;

		// 石頭數目
		stoneCounterText = new FlxText(stoneCounterIcon.x + 135, stoneCounterIcon.y + stoneCounterIcon.height / 2 - 39, 0, "0/5", 60);
		stoneCounterText.scrollFactor.set(0, 0);
		stoneCounterText.color = FlxColor.BLACK;
		add(stoneCounterText);
		stoneCounterText.visible = false;

		// 計時器
		minerTimerIcon = new FlxSprite(stoneCounterIcon.x, stoneCounterIcon.y + stoneCounterIcon.height + 30, AssetPaths.minerTimerIcon__png);
		minerTimerIcon.scrollFactor.set(0, 0);
		add(minerTimerIcon);
		minerTimerIcon.visible = false;

		minerTimerText = new FlxText(minerTimerIcon.x, minerTimerIcon.y + 75, minerTimerIcon.width, "0", 60);
		minerTimerText.color = FlxColor.BLACK;
		minerTimerText.alignment = CENTER;
		minerTimerText.scrollFactor.set(0, 0);
		add(minerTimerText);
		minerTimerText.visible = false;

		// 除錯ufo
		ufo = new FlxText(0, 0, 600, "ufo", 60);
		// ufo.color = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		// 儲存資料的元件
		save = new FlxSave();
		save.bind("DefiAdv");

		loadFile();

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 播音樂
		// 最終上傳記得消除註解
		FlxG.sound.playMusic(AssetPaths.minerTheme__ogg, 0.3, true);

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
			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "shop":
				shop.setPosition(x, y);
			case "monumentDoor":
				monumentDoor.setPosition(x + 84, y);
			case "streetDoor":
				streetDoor.setPosition(x + 84, y);
			case "minerGate":
				minerGate.setPosition(x, y);
				minerGateX = minerGate.x;

			case "spartan":
				npc.add(new NPC(x, y, spartan));
			case "minerSign":
				npc.add(new NPC(x, y, minerSign));

			case "stone":
				var s = new FlxSprite(x, y, AssetPaths.stone__png);
				stone.add(s);

			case "box":
				box.setPosition(x - 6, y);
				boxPos = box.y;

			case "spartanMiner":
				enemy.add(new Enemy(x, y, spartanMiner));

			case "starter":
				if (!meetStarter)
					enemy.add(new Enemy(x, y, starter));

			case "torch":
				var t = new FlxSprite(x, y).loadGraphic(AssetPaths.torch__png, true, 120, 240);
				t.animation.add("burn", [0, 1, 2, 3, 4], 6, true);
				t.animation.play("burn");
				t.immovable = true;
				torch.add(t);
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

		save.data.nftInvest = bag.nftInvest;
		save.data.nftWave = bag.nftWave;
		save.data.nftStyle = combatHud.nftStyleNum;

		save.data.bananaCoin = bag.bananaCoin;
		save.data.appleCoin = bag.appleCoin;

		// 跟誰講過話
		save.data.saveStoneIntro = dia.saveStoneIntro;

		// 玩家位置
		save.data.playerPos = player.getPosition();

		// 不一樣的
		save.data.meetStarter = meetStarter;
		save.data.streetYes = streetYes;
		save.data.stoneTextYes = dia.stoneTextYes;
		save.data.place = "miner";
		save.data.buyStarter = combatHud.buyStarter;

		save.flush();
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

		bag.nftInvest = save.data.nftInvest;
		bag.nftWave = save.data.nftWave;
		combatHud.nftStyleNum = save.data.nftStyle;

		bag.bananaCoin = save.data.bananaCoin;
		bag.appleCoin = save.data.appleCoin;
		bag.updateBag();
		tip.visible = true;
		tip.active = true;

		// 狗狗幣
		if (bag.shibaInvest != 0)
		{
			bag.firstShiba = true;
			bag.shibaNotifText.text = "done";
			bag.countShibaWave();
		}
		else
			bag.shibaUi.visible = false;

		// nft
		if (bag.nftInvest != 0)
		{
			bag.firstNft = true;
			bag.nftNotifText.text = "done";
			bag.countNftWave(combatHud.nftStyleNum);
		}
		else
			bag.nftUi.visible = false;

		dia.saveStoneIntro = save.data.saveStoneIntro;

		// 不一樣的
		meetStarter = save.data.meetStarter;
		streetYes = save.data.streetYes;
		dia.stoneTextYes = save.data.stoneTextYes;
		combatHud.buyStarter = save.data.buyStarter;
		if (save.data.playerPos != null && save.data.place != null)
		{
			if (save.data.place == "miner")
			{
				player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				tip.missionGetText(exploreMiner);
			}
			else if (save.data.place == "monument")
			{
				// 公式：minerDoor.x + 189,minerDoor.y - 60
				player.setPosition(429, 6060);
				tip.missionGetText(exploreMiner);
				saveFile();
			}
			else if (save.data.place == "street")
			{
				player.setPosition(4629, 6060);
				tip.missionGetText(minerFin);
				saveFile();
			}
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateInCombat();
		updateTalking();
		updateF4();
		updateC();
		updateTimer();

		// 除錯大隊
		ufo.text = Std.string(save.data.place);
		var e = FlxG.keys.anyJustReleased([E]);
		// if (e)
		// {
		// 	bag.diamondCounter += 300;
		// 	bag.updateBag();
		// ufo.visible = true;
		// }

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);
		FlxG.collide(player, minerGate, timeToStop);

		FlxG.collide(player, npc, npcTalk);

		FlxG.collide(player, shop, shopOpen);
		FlxG.collide(player, monumentDoor, goToMonument);
		FlxG.collide(player, streetDoor, goToStreet);

		FlxG.overlap(player, stone, playerGotStone);
		FlxG.collide(player, box, stoneInsideBox);
		FlxG.collide(player, enemy, touchMiner);

		FlxG.collide(enemy, walls);
		FlxG.collide(enemy, road);
		FlxG.overlap(enemy, stone, enemyGotStone);
		FlxG.collide(enemy);
		FlxG.collide(enemy, npc);

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
		doorTele.play();
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			saveFile();
			FlxG.switchState(new PlayState(true));
		});
	}

	// 去defi街
	function goToStreet(player:Player, streetDoor:FlxSprite)
	{
		if (streetYes)
		{
			doorTele.play();
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				saveFile();
				FlxG.switchState(new StreetState());
			});
		}
		else
		{
			if (bag.diamondCounter >= 300)
			{
				name = ":N:你有300能量幣了，歡迎通過此傳送點，進入下一關！";
				txt = false;
				playerUpDown();
				dia.show(name, txt);
				streetOpen = true;
			}
			else
			{
				name = ":N:你需要300能量幣才能通過此傳送點。";
				txt = false;
				playerUpDown();
				dia.show(name, txt);
			}
		}
	}

	// 離開礦場就停止計時
	function timeToStop(player:Player, minerGate:FlxSprite)
	{
		if (player.y <= minerGate.y)
		{
			minerTimerText.visible = false;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, minerGameOver);
		}
		else if (minerGate.x == minerGateX)
		{
			gateSlide.play();
			FlxTween.tween(minerGate, {x: minerGate.x + minerGate.width}, 2);
		}
	}

	// 玩家收集到石頭了
	function playerGotStone(player:Player, stone:FlxSprite)
	{
		stoneCounter++;
		stoneSound.play(true);
		stoneCounterText.text = Std.string(stoneCounter) + "/5";
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
	function touchMiner(player:Player, enemy:Enemy)
	{
		if (enemy.type == spartanMiner)
		{
			if (stoneCounter > 0)
				FlxG.camera.shake(0.01, 0.1, function()
				{
					stoneCounter--;
					minerPunch.play(true);
					stoneCounterText.text = Std.string(stoneCounter) + "/5";
					if (stoneCounter >= stoneGoal)
						stoneCounterText.color = FlxColor.RED;
					else
						stoneCounterText.color = FlxColor.BLACK;
				});
		}
		// 遇到ApeStarter而且有錢(礦工跟starter是礦廠唯二的敵人)
		else if (bag.diamondCounter >= 5)
		{
			touchEnemy.play();
			inCombat = true;
			player.active = false;
			enemy.active = false;
			combatHud.initCombat(bag.diamondCounter, bag.diamondText, bag.bananaCoin, bag.appleCoin, bag.dexCoin, enemy);
		}
		else
		{
			name = ":N:你沒有足夠的能量幣！你需要至少5能量幣！";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
			combatHud.enemy = enemy;
		}
	}

	// 打架結束囉
	function updateInCombat()
	{
		if (inCombat && !combatHud.visible)
		{
			if (combatHud.enemy.type == starter)
			{
				meetStarter = true;
				combatHud.enemy.kill();
			}

			bag.diamondCounter = combatHud.diamond;
			bag.bananaCoin = combatHud.bananaCoin;
			bag.appleCoin = combatHud.appleCoin;
			bag.dexCoin = combatHud.dexCoin;
			bag.updateBag();
			inCombat = false;
		}
	}

	// 石頭放到車子裡了
	function stoneInsideBox(player:Player, box:FlxSprite)
	{
		if (stoneCounter >= stoneGoal)
		{
			var car = Std.int(stoneCounter / stoneGoal);
			bag.diamondCounter += Std.int(car * 50);
			finalScore += car;
			stoneCounter = stoneCounter % stoneGoal;
			stoneCounterText.text = Std.string(stoneCounter) + "/5";
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

		// 玩家經過門就啟動計時，用else if是為了避免重複計時(看不見計時器才開始計時)
		else if (player.y <= minerGate.y - 150 && player.x < minerGate.x + minerGate.width && minerGate.x == minerGateX + minerGate.width)
		{
			tip.tipGetText(miner);
			minerGate.x = minerGateX;
			timer = new FlxTimer().start(minerTimeSet, function(timer:FlxTimer)
			{
				minerTimerText.visible = false;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, minerGameOver);
			});
			minerTimerText.visible = true;
			minerTimerIcon.visible = true;
			stoneCounterIcon.visible = true;
			stoneCounterText.visible = true;
		}
	}

	// 礦場遊戲結束了
	function minerGameOver()
	{
		player.setPosition(minerGate.x, minerGate.y + 600);
		minerTimerIcon.visible = false;
		stoneCounterIcon.visible = false;
		stoneCounterText.visible = false;
		name = ":N:恭喜你總共打包了" + Std.string(finalScore * 5) + "顆小石頭，賺了" + Std.string(finalScore * 50) + "能量幣！";
		playerUpDown();
		dia.show(name, false);
		stoneCounter = 0;
		finalScore = 0;
		stoneCounterText.text = Std.string(stoneCounter) + "/5";
		timer.cancel();
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	// 商店開門
	function shopOpen(player:Player, shop:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			bag.buyAndSell();
			FlxG.sound.playMusic(AssetPaths.shopTheme__ogg, 0.3, true);
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
		if (talkYes && enter && !bag.dealUi.visible && !bag.itemUi.visible && !bag.shopUi.visible)
		{
			talkYes = false;
			playerUpDown();

			// 存檔點
			if (npcType == saveStone)
			{
				saveFile();
				dia.saveShowTime(bag.diamondCounter, "礦場");
				if (dia.saveStoneIntro)
					saveNoise.play();
			}
			else if (npcType == spartan)
				stoneYes = true;

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.shopUi.visible || bag.dealUi.visible || bag.itemUi.visible || combatHud.visible)
		{
			player.active = false;
			enemy.active = false;
		}
		else
		{
			player.active = true;
			enemy.active = true;
		}

		// 對話結束時要做什麼合集
		if (!dia.visible)
		{
			// 跟布布講完話了
			if (stoneYes)
			{
				tip.tipGetText(minerSign);
				tip.missionGetText(minerFin);
				stoneYes = false;
			}
			// 有錢就開迪拜街門
			if (streetOpen)
			{
				streetOpen = false;
				streetYes = true;

				doorTele.play();
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
				{
					saveFile();
					FlxG.switchState(new StreetState());
				});
			}
			// 第一次對話完後呼叫存檔聲音
			if (dia.saveStoneYes)
			{
				dia.saveStoneYes = false;
				name = ':N:猩猩  礦場  ' + bag.diamondCounter + '能量幣\n存檔成功！';
				saveNoise.play();
				dia.show(name, false);
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

	// 如果按F4鍵就回選單
	function updateF4()
	{
		var f4 = FlxG.keys.anyJustReleased([F4]);
		if (f4 && !dia.visible)
		{
			cancel.play(true);
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
		if (c && !dia.visible && !bag.dealUi.visible && !bag.itemUi.visible && !bag.shopUi.visible)
		{
			openBag.play();
			bag.bagUiShow();
		}
	}
}
