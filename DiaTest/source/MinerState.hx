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

class MinerState extends FlxState
{
	// 玩家
	var player:Player;
	var bag:Bag;

	// 各關目標
	var stoneGoal:Int = 3;
	var boxGoal:Int = 1;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var txt:Bool = true;
	var talkYes:Bool = false;
	var talkId:Int;

	// 其他角色
	var spartan:FlxSprite;

	var saveStone:FlxTypedGroup<FlxSprite> = null;
	var saveStoneId:Int = 19;
	var monumentDoor:FlxSprite;

	// 箱子和石頭
	var box:FlxSprite;
	var boxCounter:Int = 0;
	var stone:FlxTypedGroup<FlxSprite> = null;
	var stoneCounter:Int = 0;

	// 地圖組
	var map:FlxOgmo3Loader;
	var mapRoom:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var loadsave:Bool;

	var talk:String = "none";
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

		// 存檔點
		saveStone = new FlxTypedGroup<FlxSprite>();
		add(saveStone);

		// 礦場門
		monumentDoor = new FlxSprite().loadGraphic(AssetPaths.minerDoor__png, true, 160, 160);
		monumentDoor.animation.add("glow", [0, 1, 2, 3], 3, true);
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

		// 布布
		spartan = new FlxSprite(AssetPaths.spartan__png);
		spartan.immovable = true;
		add(spartan);

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
				if (save.data.place == "menu")
					player.setPosition(save.data.playerPos.x, save.data.playerPos.y);
				else if (save.data.place == "monument")
				{
					player.setPosition(monumentDoor.x + 100, monumentDoor.y + 32);
					save.data.bananaValue = bag.bananaCounter;
					save.data.diamondValue = bag.diamondCounter;
					save.data.playerBag = player.playerBag;
					save.data.playerPos = player.getPosition();
					save.data.place = "miner";
					save.flush();
				}
			}
		}

		FlxG.mouse.visible = false;

		name = ":N:恭喜你到了礦場，送你1能量幣。:N:你得到了1能量幣";
		txt = false;
		playerUpDown();
		dia.show(name, txt);

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

			case "saveStone":
				var ss = new FlxSprite(x, y).loadGraphic(AssetPaths.saveStone__png, true, 80, 80);
				ss.animation.add("shine", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 10, true);
				ss.animation.play("shine");
				ss.immovable = true;
				saveStone.add(ss);

			case "monumentDoor":
				monumentDoor.setPosition(x, y);

			case "spartan":
				spartan.setPosition(x, y);

			case "stone":
				var s = new FlxSprite(x, y, AssetPaths.stone__png);
				stone.add(s);

			case "box":
				box.setPosition(x - 2, y);
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateTalking();
		updateR();
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

		FlxG.collide(player, spartan, ultimateTalk);

		FlxG.collide(player, saveStone, saveFile);
		FlxG.collide(player, monumentDoor, goToMonument);
		FlxG.collide(player, stone, stoneStop);
		FlxG.collide(player, box);

		FlxG.collide(stone);
		FlxG.collide(stone, walls);
		FlxG.collide(stone, saveStone);
		FlxG.collide(stone, box, stoneInsideBox);

		FlxG.collide(box, walls);
	}

	// 終極對話！
	function ultimateTalk(player:Player, sprite:FlxSprite)
	{
		talkYes = true;
		talkId = sprite.ID;
	}

	// 存檔
	function saveFile(player:Player, saveStone:FlxSprite)
	{
		talkYes = true;
		talkId = saveStoneId;
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

	// 石頭別動
	function stoneStop(player:Player, stone:FlxSprite)
	{
		stone.velocity.set(0, 0);
	}

	// 按r重新開始推石頭遊戲
	function updateR()
	{
		var r = FlxG.keys.anyJustReleased([R]);
		if (r)
		{
			box.loadGraphic(AssetPaths.boxEmpty__png);
			stone.forEach(function(sprite)
			{
				sprite.kill();
			});
			map.loadEntities(restartStone, "entities");
		}
	}

	// 石頭放到箱子裡了
	function stoneInsideBox(stone:FlxSprite, box:FlxSprite)
	{
		stone.kill();
		stoneCounter++;
		if (stoneCounter >= stoneGoal)
		{
			boxCounter++;
			player.active = false;
			box.loadGraphic(AssetPaths.boxFull__png);
			FlxTween.tween(box, {y: box.y + 360}, 2, {
				onComplete: function(_)
				{
					box.loadGraphic(AssetPaths.boxEmpty__png);
					map.loadEntities(restartStone, "entities");

					bag.diamondCounter++;
					bag.updateBag();

					name = ":N:你得到了1顆能量石！";
					playerUpDown();
					txt = false;
					dia.show(name, txt);
				}
			});
		}
	}

	// 重新開始推石頭遊戲
	function restartStone(entity:EntityData)
	{
		// 重設石頭關卡
		var x = entity.x;
		var y = entity.y;
		switch (entity.name)
		{
			case "stone":
				var s = new FlxSprite(x, y, AssetPaths.stone__png);
				stone.add(s);

			case "box":
				box.y -= 640;
				FlxTween.tween(box, {x: x - 2, y: y}, 2, {
					onComplete: function(_)
					{
						stoneCounter = 0;
					}
				});
		}
	}

	// 對話大滿貫
	// 對話大滿貫
	function updateTalking()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);

		// 如果玩家離開就不能對話
		if (FlxG.keys.anyJustPressed([A, S, W, D, UP, DOWN, LEFT, RIGHT]))
			talkYes = false;

		// 如果有對話泡泡又按enter就對話
		if (talkYes && enter && !bag.visible)
		{
			talkYes = false;
			if (talkId == spartan.ID)
			{
				name = AssetPaths.minerSpartan__txt;
				txt = true;
			}
			if (talkId == saveStoneId)
			{
				save.data.bananaValue = bag.bananaCounter;
				save.data.diamondValue = bag.diamondCounter;
				save.data.playerBag = player.playerBag;
				save.data.playerPos = player.getPosition();
				save.data.place = "miner";
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
