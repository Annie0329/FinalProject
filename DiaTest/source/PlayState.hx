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
	var bubble:FlxSprite;

	// 香蕉和他的變數
	var banana:FlxTypedGroup<FlxSprite> = null;
	var bananaSound:FlxSound;

	// 其他角色
	var doge:FlxSprite;
	var lake:FlxSprite;
	var monument:FlxSprite;

	var person1:FlxSprite;
	var person2:FlxSprite;
	var person3:FlxSprite;
	var person4:FlxSprite;

	var shop:FlxSprite;
	var minerDoor:FlxSprite;
	var saveStone:FlxTypedGroup<FlxSprite> = null;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var loadsave:Bool;

	var place:String = "monument";

	var talk:String = "none";
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
		minerDoor = new FlxSprite().makeGraphic(80, 80, FlxColor.WHITE);
		minerDoor.immovable = true;
		add(minerDoor);

		// 商店
		shop = new FlxSprite().makeGraphic(80, 80, FlxColor.TRANSPARENT);
		shop.immovable = true;
		add(shop);

		// Doge
		doge = new FlxSprite(AssetPaths.doge__png);
		doge.immovable = true;
		add(doge);

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

		// 泡泡
		bubble = new FlxSprite(0, 0).loadGraphic(AssetPaths.bubble__png);
		bubble.visible = false;
		add(bubble);

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
					player.setPosition(minerDoor.x - 100, minerDoor.y + 32);
			}
		}

		FlxG.mouse.visible = false;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	// 換成猩猩背包包的造型
	function playerBagPic()
	{
		player.loadGraphic(AssetPaths.apeNew__png, true, 50, 64);
		// 面向右邊時使用鏡像的左邊圖片
		player.setFacingFlip(LEFT, false, false);
		player.setFacingFlip(RIGHT, true, false);

		// 走路動畫
		player.animation.add("lr", [3, 4, 3, 5, 6, 7, 6, 5], 6, false);
		player.animation.add("u", [9, 8, 10, 8], 6, false);
		player.animation.add("d", [1, 0, 2, 0], 6, false);

		player.setSize(50, 32);
		player.offset.set(0, 32);
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
		updateWhenDiaInvisible();
		updateTalking();
		updateEsc();
		updateC();

		// 除錯大隊
		ufo.text = "oui";
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

		FlxG.collide(player, doge, dogeTalk);
		FlxG.overlap(player, banana, getBanana);
		FlxG.collide(player, minerDoor, goToMiner);

		FlxG.collide(player, lake, lakeTalk);
		FlxG.collide(player, monument, monumentTalk);
		FlxG.collide(player, shop, shopOpen);
		FlxG.collide(player, saveStone, saveFile);
	}

	// 泡泡位置
	function bubblePosition(bx, by:Float, bw:Float)
	{
		bubble.setPosition(bx + bw / 2 - bubble.width / 2, by - bubble.height);
		bubble.visible = true;
	}

	// Doge對話
	function dogeTalk(player:Player, doge:FlxSprite)
	{
		bubblePosition(doge.x, doge.y, doge.width);
		talk = "doge";
	}

	// Kris get the banana
	function getBanana(player:Player, banana:FlxSprite)
	{
		banana.kill();
		bananaSound.play(true);
		bag.bananaCounter++;
		bag.updateBag();
	}

	// 湖對話
	function lakeTalk(player:Player, lake:FlxSprite)
	{
		bubblePosition(lake.x, lake.y + lake.height / 2, lake.width);
		talk = "lake";
	}

	// 紀念碑對話
	function monumentTalk(player:Player, monument:FlxSprite)
	{
		bubblePosition(monument.x, monument.y + monument.height / 2, monument.width);
		talk = "monument";
	}

	// 存檔
	function saveFile(player:Player, saveStone:FlxSprite)
	{
		bubblePosition(saveStone.x, saveStone.y, saveStone.width);
		talk = "saveStone";
	}

	// 去礦場
	function goToMiner(player:Player, minerDoor:FlxSprite)
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			save.data.bananaValue = bag.bananaCounter;
			save.data.diamondValue = bag.diamondCounter;
			save.data.playerBag = player.playerBag;
			save.data.place = place;
			save.flush();
			FlxG.switchState(new MinerState(true));
		});
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
			bubble.visible = false;

		// 如果有對話泡泡又按enter就對話
		if (bubble.visible && enter && !bag.visible)
		{
			bubble.visible = false;
			switch (talk)
			{
				// doge
				case "doge":
					// 紀念碑對話
					if (player.playerBag)
						name = AssetPaths.forestMission__txt;
					else
					{
						name = AssetPaths.c1Opening__txt;
						getBag = true;
					}

				// 湖
				case "lake":
					name = AssetPaths.lakeTalking__txt;

				// 紀念碑
				case "monument":
					name = AssetPaths.monument__txt;

				// 存檔點
				case "saveStone":
					save.data.bananaValue = bag.bananaCounter;
					save.data.diamondValue = bag.diamondCounter;
					save.data.playerBag = player.playerBag;
					save.data.playerPos = player.getPosition();
					save.data.place = place;
					save.flush();
					name = AssetPaths.saveFile__txt;
			}
			talk = "none";

			playerUpDown();
			dia.show(name, diaUpDown);
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
		if (!dia.visible)
		{
			if (getBag)
			{
				player.playerBagPic();
				getBag = false;
			}
		}
	}

	// 如果玩家在螢幕上方，對話框就放到下方
	function playerUpDown()
	{
		// 這串偉大的公式是把玩家的世界座標轉成螢幕座標，感謝Kino大大
		// https://kinocreates.io/tutorials/haxeflixel-screen-vs-world-position/
		if (player.y - player.height / 2 - (FlxG.camera.scroll.y * player.scrollFactor.y) > FlxG.height / 2)
			diaUpDown = "up";
		else
			diaUpDown = "down";
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
