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

	// var diamond:Diamond;
	// 各關目標
	var stoneGoal:Int = 3;
	var boxGoal:Int = 1;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var txt:Bool = true;
	var talkYes:Bool = false;

	// 其他角色
	var enemies:FlxTypedGroup<Enemy>;
	var npc:FlxTypedGroup<NPC>;
	var npcType:NPC.NpcType;
	var monumentDoor:FlxSprite;

	// 箱子和石頭
	var box:FlxSprite;
	var boxCounter:Int = 0;
	var stone:FlxTypedGroup<FlxSprite> = null;
	var stoneCounter:Int = 0;
	var roadStart:Int = 800;
	var roadEnd:Int = 1440;
	var boxPos:Float;
	var stoneCounterText:FlxText;
	var stoneCounterIcon:FlxSprite;
	var stoneYes:Bool = false;

	// 地圖組
	var map:FlxOgmo3Loader;
	var mapRoom:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var loadsave:Bool;

	var getBag:Bool = true;

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
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.minerMap__json);

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

		// 礦場門
		monumentDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 104, 160);
		monumentDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		monumentDoor.setSize(104, 40);
		monumentDoor.offset.set(0, 120);
		monumentDoor.immovable = true;
		add(monumentDoor);
		monumentDoor.animation.play("glow");

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

		// 對話框
		dia = new Dia();
		add(dia);

		// diamond = new Diamond();
		// add(diamond);

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

		stoneCounterIcon = new FlxSprite(10, 10).loadGraphic(AssetPaths.stone__png);
		stoneCounterIcon.setGraphicSize(20, 20);
		stoneCounterIcon.updateHitbox();
		stoneCounterIcon.scrollFactor.set(0, 0);
		add(stoneCounterIcon);

		stoneCounterText = new FlxText(stoneCounterIcon.x + stoneCounterIcon.width + 10, stoneCounterIcon.y, 200, "0", 20);
		stoneCounterText.scrollFactor.set(0, 0);
		add(stoneCounterText);

		// 儲存資料的能量幣件
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
				if (save.data.place == "miner")
				{
					player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				}
				else if (save.data.place == "monument")
				{
					player.setPosition(monumentDoor.x, monumentDoor.y);
					save.data.bananaValue = bag.bananaCounter;
					save.data.diamondValue = bag.diamondCounter;
					save.data.playerBag = player.playerBag;
					save.data.playerPos = player.getPosition();
					save.data.place = "miner";
					save.flush();
				}
			}
		}

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(AssetPaths.gameTheme__mp3, 1, true);

		FlxG.mouse.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		dia.saveStoneIntro = true;
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

			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "monumentDoor":
				monumentDoor.setPosition(x, y);

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
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateTalking();
		updateEsc();
		updateC();

		// diamond.diamondText.text = Std.string(bag.diamondCounter);
		// 除錯大隊

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

		FlxG.collide(player, npc, npcTalk);

		FlxG.collide(player, monumentDoor, goToMonument);
		FlxG.overlap(player, stone, playerGotStone);
		FlxG.collide(player, box, stoneInsideBox);
		FlxG.collide(player, enemies);

		FlxG.collide(enemies, walls);
		FlxG.overlap(enemies, stone, enemyGotStone);
		FlxG.collide(enemies);

		FlxG.collide(stone);
		FlxG.collide(stone, walls);

		FlxG.collide(box, walls);
	}

	// 終極對話！
	function npcTalk(player:Player, npc:NPC)
	{
		talkYes = true;
		npcType = npc.type;
	}

	// 去到紀念碑
	function goToMonument(player:Player, monumentDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			save.data.bananaValue = bag.bananaCounter;
			save.data.diamondValue = bag.diamondCounter;
			save.data.playerBag = player.playerBag;
			save.data.place = "miner";
			save.flush();
			FlxG.switchState(new PlayState(true));
		});
	}

	function playerGotStone(player:Player, stone:FlxSprite)
	{
		stoneCounter++;
		stoneCounterText.text = Std.string(stoneCounter);
		stone.kill();
		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			stone.revive();
		});
	}

	function enemyGotStone(enemy:Enemy, stone:FlxSprite)
	{
		stone.kill();
		new FlxTimer().start(3, function(timer:FlxTimer)
		{
			stone.revive();
		});
	}

	// 石頭放到箱子裡了
	function stoneInsideBox(player:Player, box:FlxSprite)
	{
		if (stoneCounter >= stoneGoal)
		{
			bag.diamondCounter += Std.int(stoneCounter / stoneGoal);
			name = ":N:你得到了" + Std.int(stoneCounter / stoneGoal) + "能量幣！";
			stoneCounter = stoneCounter % stoneGoal;
			stoneCounterText.text = Std.string(stoneCounter);
			boxCounter++;
			box.loadGraphic(AssetPaths.boxFull__png);

			bag.updateBag();

			FlxTween.tween(box, {y: roadEnd}, 2, {
				onComplete: function(_)
				{
					box.y = roadStart;
					box.loadGraphic(AssetPaths.boxEmpty__png);
					FlxTween.tween(box, {y: boxPos}, 2, {
						onComplete: function(_)
						{
							playerUpDown();
							txt = false;
							dia.show(name, txt);
						}
					});
				}
			});
		}
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
				save.data.place = "miner";
				save.flush();
			}
			else if (npcType == spartan)
			{
				if (!stoneCounterText.visible)
					stoneYes = true;
			}

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.visible)
			player.active = false;
		else
			player.active = true;

		// 對話結束時要做什麼合集
		if (!dia.visible) {}
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
		if (c && !dia.visible && player.playerBag)
		{
			bag.bagUi();
		}
	}
}
