package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class StreetState extends FlxState
{
	// 玩家
	var player:Player;
	var tip:Tip;
	var bag:Bag;
	var getDaMis:Bool = false;

	// 聲音組
	var cancel:FlxSound;
	var touchEnemy:FlxSound;
	var openBag:FlxSound;
	var doorTele:FlxSound;

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
	var enemyFlicker:Bool = false;

	// 其他角色
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;
	var minerDoor:FlxSprite;
	var homeDoor:FlxSprite;
	var shop:FlxSprite;
	var airdrop:FlxSprite;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var sea:FlxTypedGroup<FlxSprite> = null;

	// 房間
	var house1:FlxSprite;
	var house1Door:FlxSprite;
	var house2:FlxSprite;
	var house2Door:FlxSprite;
	var house3:FlxSprite;
	var house3Door:FlxSprite;
	var house4:FlxSprite;
	var house4Door:FlxSprite;
	var houseDis:Int = 0;

	var p1Talk:Bool = false;
	var p2Talk:Bool = false;
	var p3Talk:Bool = false;

	// 除錯ufo
	var ufo:FlxText;
	var save:FlxSave;

	var firstLoan:Bool = false;

	// 加好加滿
	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.deFiMap__ogmo, AssetPaths.streetMap__json);

		// 聲音組
		cancel = FlxG.sound.load(AssetPaths.cancel__mp3);
		touchEnemy = FlxG.sound.load(AssetPaths.touchEnemy__mp3);
		openBag = FlxG.sound.load(AssetPaths.openBag__mp3);
		doorTele = FlxG.sound.load(AssetPaths.doorTele__mp3);

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

		sea = new FlxTypedGroup<FlxSprite>();
		add(sea);

		// 礦場傳送門
		minerDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 360, 480);
		minerDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		minerDoor.setSize(360, 120);
		minerDoor.offset.set(0, 360);
		minerDoor.immovable = true;
		add(minerDoor);
		minerDoor.animation.play("glow");

		// 過關送門
		homeDoor = new FlxSprite().loadGraphic(AssetPaths.homeDoor__png, true, 432, 480);
		homeDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		homeDoor.setSize(432, 180);
		homeDoor.offset.set(0, 300);
		homeDoor.immovable = true;
		add(homeDoor);
		homeDoor.animation.play("glow");

		// 各種房間，有加door的是房間內的門
		house1 = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house1.immovable = true;
		add(house1);

		house1Door = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house1Door.immovable = true;
		add(house1Door);

		house2 = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house2.immovable = true;
		add(house2);

		house2Door = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house2Door.immovable = true;
		add(house2Door);

		house3 = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house3.immovable = true;
		add(house3);

		house3Door = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house3Door.immovable = true;
		add(house3Door);

		house4 = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house4.immovable = true;
		add(house4);

		house4Door = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		house4Door.immovable = true;
		add(house4Door);

		// 商店
		shop = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// 敵人
		enemy = new FlxTypedGroup<Enemy>();
		add(enemy);

		npc = new FlxTypedGroup<NPC>();
		add(npc);

		// 空投
		airdrop = new FlxSprite(AssetPaths.airdrop__png);
		airdrop.visible = false;
		add(airdrop);

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

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 除錯ufo
		ufo = new FlxText(0, 0, 600, "ufo", 60);
		// ufo.color = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		// 儲存資料的能量幣件
		save = new FlxSave();
		save.bind("DefiAdv");

		loadFile();

		// 播音樂
		// 最終上傳記得消除註解
		FlxG.sound.playMusic(AssetPaths.streetTheme__mp3, 0.3, true);

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
			case "signDefi":
				npc.add(new NPC(x + 60, y, signDefi));
			case "signApple":
				npc.add(new NPC(x + 60, y, signApple));

			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "minerDoor":
				minerDoor.setPosition(x + 84, y);
			case "homeDoor":
				homeDoor.setPosition(x + 36, y);

			case "house1":
				house1.setPosition(x, y);

			case "house1Door":
				house1Door.setPosition(x, y);

			case "house2":
				house2.setPosition(x, y);

			case "house2Door":
				house2Door.setPosition(x, y);

			case "house3":
				house3.setPosition(x, y);

			case "house3Door":
				house3Door.setPosition(x, y);

			case "house4":
				house4.setPosition(x, y);

			case "house4Door":
				house4Door.setPosition(x, y);
				houseDis = Std.int(house4Door.y - house4.y);

			case "shop":
				shop.setPosition(x, y);
			case "house1Sign":
				npc.add(new NPC(x, y, house1Sign));
			case "p1":
				npc.add(new NPC(x, y, p1));
			case "mathChart":
				npc.add(new NPC(x, y, mathChart));
			case "p1BaToCoMach":
				npc.add(new NPC(x, y, p1BaToCoMach));
			case "p1CoToApMach":
				npc.add(new NPC(x, y, p1CoToApMach));
			case "p1ApToCoMach":
				npc.add(new NPC(x, y, p1ApToCoMach));
			case "p1CoToDeMach":
				npc.add(new NPC(x, y, p1CoToDeMach));
			case "p1DeToCoMach":
				npc.add(new NPC(x, y, p1DeToCoMach));
			case "house2Sign":
				npc.add(new NPC(x, y, house2Sign));
			case "p2":
				npc.add(new NPC(x, y, p2));
			case "p2Mach":
				npc.add(new NPC(x, y, p2Mach));
			case "house3Sign":
				npc.add(new NPC(x, y, house3Sign));
			case "p3":
				npc.add(new NPC(x, y, p3));
			case "dexNews":
				npc.add(new NPC(x, y, dexNews));
			case "p3Mach":
				npc.add(new NPC(x, y, p3Mach));
			case "house4Sign":
				npc.add(new NPC(x, y, house4Sign));
			case "rod":
				enemy.add(new Enemy(x, y, rod));
			case "starter":
				enemy.add(new Enemy(x, y, starter));
			case "airdrop":
				airdrop.setPosition(x, y);
			case "sea":
				var s = new FlxSprite(x, y).loadGraphic(AssetPaths.sea__png, true, 480, 240);
				s.flipX = true;
				s.animation.add("oui", [0, 1, 2, 3], 2.5, true);
				s.animation.play("oui");
				s.immovable = true;
				sea.add(s);
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
		save.data.saveStoneIntro = true;

		// 玩家位置
		save.data.playerPos = player.getPosition();

		// 不一樣的
		save.data.place = "street";
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
		combatHud.buyStarter = save.data.buyStarter;
		if (save.data.playerPos != null && save.data.place != null)
		{
			if (save.data.place == "street")
			{
				player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				tip.missionGetText(exploreStreet);
			}
			else if (save.data.place == "miner")
			{
				player.setPosition(minerDoor.x + (minerDoor.width - player.width) / 2, minerDoor.y - 60);
				tip.missionGetText(exploreStreet);
				tip.tipGetText(streetSign);
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
		updateC();
		updateF4();

		// 除錯大隊
		ufo.text = Std.string(save.data.place) + "," + Std.string(FlxG.mouse.screenY);
		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			FlxG.mouse.visible = true;
			ufo.visible = true;
			bag.diamondCounter += 1000;
			bag.updateBag();
		}

		if (dia.readDaSign && !dia.visible && !getDaMis)
		{
			getDaMis = true;
			tip.missionGetText(streetFin);
		}
		// 開始借貸算利息
		if (dia.loan && !firstLoan && !dia.visible)
		{
			firstLoan = true;
			dia.loan = false;
			new FlxTimer().start(10, function(timer:FlxTimer)
			{
				bag.diamondCounter += dia.loanGain * dia.interest;
				bag.diamondText.text = Std.string(FlxMath.roundDecimal(bag.diamondCounter, 2));
				bag.updateBag();
			}, 0);
		}

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);

		FlxG.collide(player, npc, npcTalk);

		FlxG.collide(player, minerDoor, goToMiner);
		FlxG.collide(player, homeDoor, goHome);
		FlxG.collide(player, shop, shopOpen);

		FlxG.collide(player, house1, houseIn);
		FlxG.collide(player, house2, houseIn);
		FlxG.collide(player, house3, houseIn);
		FlxG.collide(player, house4, houseIn);

		FlxG.collide(player, house1Door, houseOut);
		FlxG.collide(player, house2Door, houseOut);
		FlxG.collide(player, house3Door, houseOut);
		FlxG.collide(player, house4Door, houseOut);

		FlxG.collide(player, enemy, playerTouchEnemy);
		FlxG.overlap(player, airdrop, airdropMoney);

		FlxG.collide(enemy, walls);
		FlxG.collide(enemy, road);
		FlxG.collide(enemy);
		FlxG.collide(enemy, npc);
	}

	// NPC對話
	function npcTalk(player:Player, npc:NPC)
	{
		talkYes = true;
		npcType = npc.type;
	}

	// 去礦場
	function goToMiner(player:Player, minerDoor:FlxSprite)
	{
		doorTele.play();
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			saveFile();
			FlxG.switchState(new MinerState());
		});
	}

	// 遊戲結束
	function goHome(player:Player, homeDoor:FlxSprite)
	{
		if (bag.diamondCounter >= 888)
		{
			name = ":N:你有888能量幣了，確定要離開DeFi島嗎？\n  是\n  否";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
			dia.getPointer("winGame");
		}
		else
		{
			name = ":N:你需要888能量幣才能通過此傳送點。";
			txt = false;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 進房子
	function houseIn(player:Player, house:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			player.setPosition(house.x + (house.width - player.width) / 2, house.y + houseDis - 120);
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
			if (house == house1 && !p1Talk)
			{
				p1Talk = true;
				name = AssetPaths.house1Talk__txt;
				playerUpDown();
				dia.show(name, true);
			}
			else if (house == house2 && !p2Talk)
			{
				p2Talk = true;
				name = AssetPaths.house2Talk__txt;
				playerUpDown();
				dia.show(name, true);
			}
			else if (house == house3 && !p3Talk)
			{
				p3Talk = true;
				name = AssetPaths.house3Talk__txt;
				playerUpDown();
				dia.show(name, true);
			}
		});
	}

	// 出房子
	function houseOut(player:Player, houseDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			player.setPosition(houseDoor.x + (houseDoor.width - player.width) / 2, houseDoor.y - houseDis + 240);
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
			if (houseDoor == house3Door && !firstLoan)
				tip.tipGetText(loan);
			else
			{
				airdrop.visible = true;
				FlxTween.tween(airdrop, {x: 6840, y: 2160}, 1);
			}
		});
	}

	// 如果你碰了敵人，就代表敵人碰了你
	function playerTouchEnemy(player:Player, enemy:Enemy)
	{
		if (player.alive && player.exists && enemy.alive && enemy.exists && enemy.alpha != 0.5)
		{
			if ((enemy.type == rod && bag.bananaCoin >= 5) || (enemy.type == starter && bag.diamondCounter >= 5))
			{
				// 我們是在迪拜街碰到ApeStarter的
				if (enemy.type == starter)
					combatHud.starterInStreet = true;
				touchEnemy.play();
				inCombat = true;
				player.active = false;
				enemy.active = false;
				combatHud.initCombat(bag.diamondCounter, bag.diamondText, bag.bananaCoin, bag.appleCoin, bag.dexCoin, enemy);
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
				combatHud.enemy.alpha = 0.5;
				enemyFlicker = true;
			}
		}
	}

	// 打架結束囉
	function updateInCombat()
	{
		if (inCombat && !combatHud.visible)
		{
			combatHud.enemy.alpha = 0.5;
			enemyFlicker = true;
			bag.diamondCounter = combatHud.diamond;
			bag.bananaCoin = combatHud.bananaCoin;
			bag.appleCoin = combatHud.appleCoin;
			bag.dexCoin = combatHud.dexCoin;
			bag.updateBag();
			inCombat = false;
			// 槓桿設置
			if (combatHud.enemy.type == rod && combatHud.outcome == WIN)
			{
				bag.rodInvest += combatHud.investNum;
				bag.rodWave += bag.rodInvest;
				bag.rodNum = combatHud.rodNum;
				if (!bag.rodUi.visible)
				{
					bag.rodUi.visible = true;
					bag.countRodWave();
				}
			}
		}
	}

	// 接收空投
	function airdropMoney(player:Player, airdrop:FlxSprite)
	{
		if (airdrop.visible)
		{
			airdrop.kill();
			name = AssetPaths.airdropTalk__txt;
			txt = true;
			playerUpDown();
			dia.show(name, txt);
			bag.dexCoin = 500;
			bag.dexCoinText.text = Std.string(bag.dexCoin);
		}
	}

	// 商店開門
	function shopOpen(player:Player, shop:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			bag.buyAndSell();
			FlxG.sound.playMusic(AssetPaths.shopTheme__mp3, 0.3, true);
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
		if (talkYes && enter && !bag.itemUi.visible && !bag.dealUi.visible && !bag.shopUi.visible)
		{
			talkYes = false;
			playerUpDown();

			// 存檔點
			if (npcType == saveStone)
				saveFile();
			else if (npcType == p1ApToCoMach)
			{
				if (bag.rodUi.visible)
					bag.rodTimer.active = false;
			}

			// 準備小屋交易
			if (npcType == p1BaToCoMach || npcType == p1CoToApMach || npcType == p1ApToCoMach || npcType == p1CoToDeMach || npcType == p1DeToCoMach
				|| npcType == p2Mach || npcType == p3Mach)
				dia.getDiamond(bag.diamondCounter, bag.diamondText, bag.bananaCoin, bag.appleCoin, bag.rodWave, bag.dexCoin);

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
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
			// 贏了！
			if (dia.win)
			{
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
				{
					doorTele.play();
					FlxG.switchState(new WinState());
				});
			}
			// 更新包包
			if (dia.updateDiamond)
			{
				dia.updateDiamond = false;
				bag.diamondCounter = dia.diamond;
				bag.bananaCoin = FlxMath.roundDecimal(dia.bananaCoin, 2);
				bag.bananaCoinText.text = Std.string(bag.bananaCoin);
				bag.appleCoin = FlxMath.roundDecimal(dia.appleCoin, 2);
				bag.appleCoinText.text = Std.string(bag.appleCoin + bag.rodWave);
				bag.dexCoin = FlxMath.roundDecimal(dia.dexCoin, 2);
				bag.dexCoinText.text = Std.string(bag.dexCoin);
				bag.rodWave = dia.rodWave;
				// 如果槓桿沒被賣掉那計時繼續
				if (bag.rodUi.visible)
				{
					if (bag.rodWave > 0)
						bag.rodTimer.active = true;
					else
					{
						bag.rodUi.visible = false;
						bag.rodTimer.cancel();
					}
				}

				bag.updateBag();
			}
			// 敵人暫時變透明
			if (enemyFlicker)
			{
				new FlxTimer().start(5, function(timer:FlxTimer)
				{
					combatHud.enemy.alpha = 1;
				});
				enemyFlicker = false;
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
