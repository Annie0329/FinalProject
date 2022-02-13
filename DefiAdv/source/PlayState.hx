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

	// 香蕉
	var banana:FlxTypedGroup<FlxSprite> = null;

	// 敵人
	var enemies:FlxTypedGroup<Enemy>;
	var inCombat:Bool = false;
	var combatHud:CombatHUD;
	var enemyFlicker:Bool = false;
	var shibaYes:Bool = false;
	var nftYes:Bool = false;

	// NPC
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;
	var dogeYes:FlxSprite;
	var srYes:FlxSprite;
	var sgYes:FlxSprite;
	var sbYes:FlxSprite;
	var mingYes:FlxSprite;

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
	var sea:FlxTypedGroup<FlxSprite> = null;
	var treeBar:FlxSprite;

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
		map = new FlxOgmo3Loader(AssetPaths.deFiMap__ogmo, AssetPaths.monumentMap__json);

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

		// 海
		sea = new FlxTypedGroup<FlxSprite>();
		add(sea);

		// 樹牆
		treeBar = new FlxSprite(AssetPaths.treeBar__png);
		treeBar.immovable = true;
		add(treeBar);

		// 香蕉
		banana = new FlxTypedGroup<FlxSprite>();
		add(banana);

		// 礦場門
		minerDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 360, 480);
		minerDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		minerDoor.immovable = true;
		minerDoor.setSize(360, 120);
		minerDoor.offset.set(0, 360);
		add(minerDoor);
		minerDoor.animation.play("glow");

		// 商店
		shop = new FlxSprite().makeGraphic(240, 240, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// NPC
		npc = new FlxTypedGroup<NPC>();
		add(npc);

		// 敵人
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		// 玩家
		player = new Player();
		add(player);

		// 驚嘆號
		FlxG.camera.follow(player, TOPDOWN, 1);
		dogeYes = new FlxSprite().makeGraphic(120, 120, FlxColor.BROWN);
		dogeYes.visible = false;
		add(dogeYes);

		srYes = new FlxSprite().makeGraphic(120, 120, FlxColor.RED);
		srYes.visible = false;
		add(srYes);

		sgYes = new FlxSprite().makeGraphic(120, 120, FlxColor.GREEN);
		sgYes.visible = false;
		add(sgYes);

		sbYes = new FlxSprite().makeGraphic(120, 120, FlxColor.BLUE);
		sbYes.visible = false;
		add(sbYes);

		mingYes = new FlxSprite().makeGraphic(120, 120, FlxColor.BLUE);
		mingYes.visible = false;
		add(mingYes);

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

		// 除錯ufo
		ufo = new FlxText(0, 0, 600, "ufo", 60);
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		// 儲存資料的元件
		save = new FlxSave();
		save.bind("DefiAdv");

		// 一般轉場
		if (loadsave)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, true);
			loadFile();
		}
		// 重新開始遊戲轉場
		else
		{
			player.animation.frameIndex = 11;
			FlxG.camera.fade(FlxColor.BLACK, 1, true, function()
			{
				name = AssetPaths.c1Opening__txt;
				getBag = true;
				playerUpDown();
				dia.show(name, true);
			});
		}

		// 播音樂
		// 最終上傳記得消除註解
		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(AssetPaths.gameTheme__mp3, 1, true);

		// 滑鼠退散
		FlxG.mouse.visible = false;
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
				player.setPosition(x, y + 96);
			case "guy":
				npc.add(new NPC(x, y, doge));
			case "dogeYes":
				dogeYes.setPosition(x, y);
			case "ming":
				npc.add(new NPC(x, y, ming));
			case "sbRed":
				npc.add(new NPC(x, y, sbRed));
			case "srYes":
				srYes.setPosition(x, y);
			case "sbGreen":
				npc.add(new NPC(x, y, sbGreen));
			case "sgYes":
				sgYes.setPosition(x, y);
			case "sbBlue":
				npc.add(new NPC(x, y, sbBlue));
			case "sbYes":
				sbYes.setPosition(x, y);
			case "mingYes":
				mingYes.setPosition(x, y);
			// 敵人
			case "shibaCoin":
				enemies.add(new Enemy(x, y, shibaCoin));
			case "cloudMiner":
				enemies.add(new Enemy(x, y, cloudMiner));
			case "nft":
				enemies.add(new Enemy(x, y, nft));

			case "banana":
				var b = new FlxSprite(x, y).loadGraphic(AssetPaths.banana__png, true, 120, 240);
				b.animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 5, true);
				b.animation.play("spin");
				b.immovable = true;
				banana.add(b);

			case "sea":
				var s = new FlxSprite(x, y).loadGraphic(AssetPaths.sea__png, true, 480, 240);
				s.animation.add("oui", [0, 1, 2, 3], 2.5, true);
				s.animation.play("oui");
				s.immovable = true;
				sea.add(s);
			case "treeBar":
				treeBar.setPosition(x, y);

			case "lake":
				npc.add(new NPC(x, y, lake));
			case "monument":
				npc.add(new NPC(x, y, monument));

			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "minerDoor":
				minerDoor.setPosition(x + 84, y);

			case "shop":
				shop.setPosition(x, y);
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
		save.data.minerYes = minerYes;
		save.data.place = "monument";
		save.data.talkDone = dia.talkDone;

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
		minerYes = save.data.minerYes;
		dia.talkDone = save.data.talkDone;
		if (save.data.playerPos != null && save.data.place != null)
		{
			if (save.data.place == "monument")
				player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
			else if (save.data.place == "miner")
			{
				player.setPosition(minerDoor.x + (minerDoor.width - player.width) / 2, minerDoor.y - 60);
				saveFile();
			}
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// 除錯大隊
		ufo.text = Std.string(bag.nftNotifText.text); // Std.string(FlxG.mouse.screenX) + "," + Std.string(FlxG.mouse.screenY);
		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			ufo.visible = true;
			FlxG.mouse.visible = true;
		}

		// 達成葉子目標
		if (bag.bananaCounter >= 10 && !dia.leafYes && !dia.talkDone)
		{
			dia.leafYes = true;
			dogeYes.visible = true;
		}
		// 跟Doge回報完葉子就可以跟島民說話
		if (dia.leafYes && !dia.talkMiss && !dogeYes.visible)
		{
			dia.talkMiss = true;
			srYes.visible = true;
			sgYes.visible = true;
			sbYes.visible = true;
			mingYes.visible = true;
		}
		if (dia.talkMiss && !srYes.visible && !sgYes.visible && !sbYes.visible && !mingYes.visible && !dia.talkDone)
		{
			dia.talkDone = true;
			dogeYes.visible = true;
		}
		if (dia.talkDone && !dogeYes.visible)
			treeBar.kill();

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
		FlxG.collide(player, treeBar);

		FlxG.collide(player, npc, npcTalk);

		FlxG.overlap(player, banana, getBanana);

		FlxG.collide(player, shop, shopOpen);
		FlxG.collide(player, minerDoor, goToMiner);

		FlxG.collide(enemies, walls);
		FlxG.collide(enemies, road);
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
			// 敵人的下場
			switch (combatHud.outcome)
			{
				case WIN, FLEE:
					combatHud.enemy.kill();
				case LOSE:
					combatHud.enemy.enemyFire();
			}

			// Doge的反應
			switch (combatHud.enemy.type)
			{
				case shibaCoin:
					if (combatHud.outcome == WIN)
					{
						name = ":D:你買了狗狗幣啊！你可以在左邊看到你買的狗狗幣漲或跌了多少。:D:隨時注意出現的新聞快報！它會影響到你狗狗幣的漲跌。";
						bag.shibaInvest += combatHud.investNum;
						bag.shibaWave += bag.shibaInvest;
						if (!bag.shibaUi.visible)
						{
							bag.shibaUi.visible = true;
							shibaYes = true;
						}
					}
					else
						name = ":D:狗狗幣很好賺呢，下次試試看跟他們交涉吧！";

				case cloudMiner:
					if (combatHud.outcome == FLEE)
						name = ":D:你躲過詐騙了呢！";
					else
						name = ":D:這是詐騙喔！";

				case nft:
					if (combatHud.outcome == WIN)
					{
						name = ":D:你買了NFT啊！你可以在左邊看到你買的NFT漲或跌了多少。";
						bag.nftInvest += combatHud.investNum;
						bag.nftWave += bag.nftInvest;
						bag.nft.animation.frameIndex = combatHud.nftStyleNum;
						if (!bag.nftUi.visible)
						{
							bag.nftUi.visible = true;
							nftYes = true;
						}
					}
					else
						name = ":D:NFT還不錯，下次試試看吧。";

				case rod, spartanMiner, starter:
			}
			txt = false;
			playerUpDown();
			dia.show(name, txt);
		}
	}

	// 如果你碰了敵人，就代表敵人碰了你
	function playerTouchEnemy(player:Player, enemy:Enemy)
	{
		if (player.alive && player.exists && enemy.alive && enemy.exists && enemy.alpha != 0.5)
		{
			if (bag.diamondCounter >= 20)
			{
				inCombat = true;
				player.active = false;
				enemies.active = false;
				combatHud.initCombat(bag.diamondCounter, bag.diamondText, bag.bananaCoin, bag.appleCoin, enemy);
			}
			else
			{
				name = ":N:你沒有足夠的能量幣！你需要至少20能量幣！";
				txt = false;
				playerUpDown();
				dia.show(name, txt);
				combatHud.enemy = enemy;
				combatHud.enemy.alpha = 0.5;
				enemyFlicker = true;
			}
		}
	}

	// 跟NPC講話
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
				saveFile();
				FlxG.switchState(new MinerState());
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
		if (talkYes && enter && !bag.bagUi.visible && !bag.shopUi.visible)
		{
			talkYes = false;
			playerUpDown();

			// 消除頭上的驚嘆號
			if (npcType == doge && dogeYes.visible)
				dogeYes.visible = false;
			if (npcType == sbRed && srYes.visible)
				srYes.visible = false;
			if (npcType == sbGreen && sgYes.visible)
				sgYes.visible = false;
			if (npcType == sbBlue && sbYes.visible)
				sbYes.visible = false;
			if (npcType == ming && mingYes.visible)
				mingYes.visible = false;
			// 存檔點
			if (npcType == saveStone)
				saveFile();

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
			// 拿到背包
			if (getBag)
			{
				player.animation.frameIndex = 0;
				bag.diamondUi.visible = true;
				getBag = false;
			}
			// 啟動狗狗幣計時器
			if (shibaYes)
			{
				bag.countShibaWave();
				shibaYes = false;
			}
			// 啟動nft計時器
			if (nftYes)
			{
				bag.countNftWave(combatHud.nftStyleNum);
				nftYes = false;
			}
			// 有錢就開礦場門
			if (minerOpen)
			{
				minerOpen = false;
				minerYes = true;

				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
				{
					bag.diamondCounter--;
					bag.updateBag();
					saveFile();
					FlxG.switchState(new MinerState());
				});
			}
			if (enemyFlicker)
			{
				new FlxTimer().start(1, function(timer:FlxTimer)
				{
					combatHud.enemy.alpha = 1;
					enemyFlicker = false;
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
		if (c && !dia.visible && (!bag.bagUi.visible && !bag.shopUi.visible))
		{
			bag.bagUiShow();
		}
	}
}
