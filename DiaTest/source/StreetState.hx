package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.text.FlxTextField;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class StreetState extends FlxState
{
	// 玩家
	var player:Player;
	var bag:Bag;

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
	var minerDoor:FlxSprite;

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
	var houseDis:Int = 1360;

	// 除錯ufo
	var ufo:FlxText;
	var save:FlxSave;

	// 加好加滿
	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.streetMap__json);

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
		minerDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 104, 160);
		minerDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
		minerDoor.setSize(104, 40);
		minerDoor.offset.set(0, 120);
		minerDoor.immovable = true;
		add(minerDoor);
		minerDoor.animation.play("glow");

		// 各種房間
		house1 = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house1.immovable = true;
		add(house1);

		house1Door = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house1Door.immovable = true;
		add(house1Door);

		house2 = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house2.immovable = true;
		add(house2);

		house2Door = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house2Door.immovable = true;
		add(house2Door);

		house3 = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house3.immovable = true;
		add(house3);

		house3Door = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		house3Door.immovable = true;
		add(house3Door);

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

		// 對話框
		dia = new Dia();
		add(dia);

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

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
			case "saveStone":
				npc.add(new NPC(x, y, saveStone));

			case "minerDoor":
				minerDoor.setPosition(x + 28, y);

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

			case "p1":
				npc.add(new NPC(x, y, p1));
			case "p2":
				npc.add(new NPC(x, y, p2));
			case "p3":
				npc.add(new NPC(x, y, p3));

			case "sea":
				var s = new FlxSprite(x, y).loadGraphic(AssetPaths.sea__png, true, 160, 80);
				s.flipX = true;
				s.animation.add("oui", [0, 1, 2, 3], 12, true);
				s.animation.play("oui");
				s.immovable = true;
				sea.add(s);
		}
	}

	// 讀檔啦
	function loadFile()
	{
		bag.diamondUi.visible = true;
		bag.bananaCounter = save.data.bananaValue;
		bag.diamondCounter = save.data.diamondValue;
		bag.updateBag();

		dia.saveStoneIntro = save.data.saveStoneIntro;

		if (save.data.playerPos != null && save.data.place != null)
		{
			if (save.data.place == "street")
				player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
			else if (save.data.place == "miner")
			{
				player.setPosition(minerDoor.x + (minerDoor.width - player.width) / 2, minerDoor.y - 20);
				saveFile();
			}
		}
	}

	// 存檔啦
	function saveFile()
	{
		// 能量幣和香蕉數目
		save.data.bananaValue = bag.bananaCounter;
		save.data.diamondValue = bag.diamondCounter;

		// 跟誰講過話
		save.data.saveStoneIntro = dia.saveStoneIntro;

		// 玩家位置
		save.data.playerPos = player.getPosition();
		save.data.place = "street";

		save.flush();
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateTalking();
		updateEsc();
		updateC();

		// 除錯大隊
		// ufo.text = Std.string(player.getPosition());
		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			ufo.visible = true;
			player.setPosition(560, 2120);
			// save.erase();
		}

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);

		FlxG.collide(player, npc, npcTalk);

		FlxG.collide(player, minerDoor, goToMiner);
		FlxG.collide(player, house1, houseIn);
		FlxG.collide(player, house2, houseIn);
		FlxG.collide(player, house3, houseIn);

		FlxG.collide(player, house1Door, houseOut);
		FlxG.collide(player, house2Door, houseOut);
		FlxG.collide(player, house3Door, houseOut);

		FlxG.overlap(player, enemies);

		FlxG.collide(enemies, walls);
		FlxG.collide(enemies);
		FlxG.collide(enemies, npc);
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
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			saveFile();
			FlxG.switchState(new MinerState());
		});
	}

	function houseIn(player:Player, house:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			player.setPosition(house.x, house.y + houseDis);
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		});
	}

	function houseOut(player:Player, houseDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			player.setPosition(houseDoor.x, houseDoor.y - houseDis + 80);
			FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
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

			dia.context(npcType);
		}
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible || bag.shopUi.visible || bag.bagUi.visible)
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
		if (c && !dia.visible && (!bag.bagUi.visible && !bag.shopUi.visible))
		{
			bag.bagUiShow();
		}
	}
}
