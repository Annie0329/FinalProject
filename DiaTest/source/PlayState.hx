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

class PlayState extends FlxState
{
	// 玩家
	var player:Player;

	// 各關目標
	var bananaGoal:Int = 1;
	var stoneGoal:Int = 3;
	var boxGoal:Int = 1;

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;
	var bubble:FlxSprite;

	// 香蕉和他的變數
	var banana:FlxTypedGroup<FlxSprite> = null;
	var talkToBanana:Bool = true;
	var bananaCounter:Int = 0;
	var bqNumber:Int = 1;

	// 其他角色
	var doge:FlxSprite;
	var spartan:FlxSprite;
	var lake:FlxSprite;

	// 箱子和石頭
	var box:FlxSprite;
	var boxCounter:Int = 0;
	var stone:FlxTypedGroup<FlxSprite> = null;
	var stoneCounter:Int = 0;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var place:String = "miner";

	var talk:String = "none";

	// 除錯ufo
	var ufo:FlxText;

	/**
		*來自MenuState的呼喚，我們要從哪裡開始
		*@param place
	 */
	public function new(place:String)
	{
		super();
		this.place = place; // 這個place等於那個place(咒語)
	}

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.diaMap__json);

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

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		if (place == "miner")
			playerBagPic();

		// 香蕉
		banana = new FlxTypedGroup<FlxSprite>();
		add(banana);

		// 湖
		lake = new FlxSprite();
		lake.makeGraphic(80, 160, FlxColor.TRANSPARENT);
		lake.immovable = true;
		add(lake);

		// 石頭
		stone = new FlxTypedGroup<FlxSprite>();
		add(stone);

		// 箱子
		box = new FlxSprite(AssetPaths.boxEmpty__png);
		box.immovable = true;
		add(box);

		// Doge
		doge = new FlxSprite(AssetPaths.doge__png);
		doge.immovable = true;
		add(doge);

		// 布布
		spartan = new FlxSprite(AssetPaths.spartan__png);
		spartan.immovable = true;
		add(spartan);

		// 地圖在前面的物件
		through = map.loadTilemap(AssetPaths.mtSmall__png, "through");
		through.follow();
		add(through);

		// 對話框
		dia = new Dia();
		add(dia);

		// 泡泡
		bubble = new FlxSprite(0, 0);
		bubble.loadGraphic(AssetPaths.bubble__png);
		bubble.visible = false;
		add(bubble);

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");
		beginPlace();

		// 除錯ufo
		ufo = new FlxText(0, 0, 200, "ufo", 20);
		ufo.color = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		FlxG.mouse.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	// 開場專屬對話
	function beginPlace()
	{
		switch (place)
		{
			// 第一章從紀念碑開始
			case "monument":
				place = "monumentDone";
				name = AssetPaths.c1Opening__txt;
				playerUpDown();
				dia.show(name, diaUpDown);

			// 第二章從礦場開始
			case "miner":
				place = "stone";

				// 記得殺香蕉
				banana.kill();
				bananaCounter = bananaGoal;

				name = AssetPaths.c2Opening__txt;
				playerUpDown();
				dia.show(name, diaUpDown);
		}
	}

	// 設位置
	public function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (place)
		{
			// 紀念碑
			case "monument":
				switch (entity.name)
				{
					case "player":
						player.setPosition(x + 8, y + 8);

					case "guy":
						doge.setPosition(x, y);

					case "banana":
						var b = new FlxSprite(entity.x + 20, entity.y + 20, AssetPaths.banana__png);
						b.immovable = true;
						banana.add(b);

					case "lake":
						lake.setPosition(x, y);
				}

			// 礦場
			case "miner":
				switch (entity.name)
				{
					case "playerMiner":
						player.setPosition(x + 8, y + 8);

					case "guyMiner":
						doge.setPosition(x, y);

					case "spartan":
						spartan.setPosition(x, y);

					case "lake":
						lake.setPosition(x, y);
				}

			// 石頭關卡
			case "stone":
				switch (entity.name)
				{
					case "playerStone":
						player.setPosition(x + 8, y + 8);

					case "spartanStone":
						spartan.setPosition(x, y);

					case "stone":
						var s = new FlxSprite(x + 20, y + 20, AssetPaths.stone__png);
						stone.add(s);

					case "box":
						box.setPosition(x + 4, y + 4);
				}

			// 斯巴達跑回去
			case "minerDone":
				switch (entity.name)
				{
					case "spartan":
						spartan.setPosition(x, y);
				}

			// 重設關卡
			case "boxRestart":
				switch (entity.name)
				{
					case "stone":
						var s = new FlxSprite(x + 20, y + 20, AssetPaths.stone__png);
						stone.add(s);

					case "box":
						box.x = 3760;
						FlxTween.tween(box, {x: x + 4, y: y + 4}, 1, {
							onComplete: function(_)
							{
								stoneCounter = 0;
							}
						});
				}
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();
		updateTalking();
		updateR();

		// 除錯大隊
		ufo.text = Std.string(player.active); // ", " + Std.string(FlxG.mouse.screenY);

		// 如果按esc鍵就回選單
		var esc = FlxG.keys.anyJustReleased([ESCAPE]);
		if (esc && !dia.visible)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}

		var e = FlxG.keys.anyJustReleased([E]);
		if (e)
		{
			player.loadGraphic(AssetPaths.apeNew__png, true, 46, 64);
			// 面向右邊時使用鏡像的左邊圖片
			player.setFacingFlip(LEFT, false, false);
			player.setFacingFlip(RIGHT, true, false);

			// 走路動畫
			player.animation.add("lr", [3, 4, 5, 6, 7], 6, false);
			player.animation.add("u", [9, 8, 10, 8], 6, false);
			player.animation.add("d", [1, 0, 2, 0], 6, false);
		}

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);

		FlxG.collide(player, doge, dogeTalk);
		FlxG.collide(player, spartan, spartanTalk);
		FlxG.collide(player, banana, forestQ);
		FlxG.collide(player, lake, lakeTalk);
		FlxG.collide(player, stone, stoneStop);
		FlxG.collide(player, box);

		FlxG.collide(stone);
		FlxG.collide(stone, walls);
		FlxG.collide(stone, box, stoneInsideBox);

		FlxG.collide(box, walls);
	}

	// 對話大滿貫
	function updateTalking()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);

		// 如果玩家離開就不能跟其他人對話
		if (FlxG.keys.anyJustPressed([A, S, W, D, UP, DOWN, LEFT, RIGHT]))
			bubble.visible = false;

		// 如果有對話泡泡又按enter就對話
		if (bubble.visible && enter)
		{
			bubble.visible = false;
			switch (talk)
			{
				// doge
				case "doge":
					// 紀念碑對話
					if (place == "monumentDone")
					{
						if (bananaCounter >= bananaGoal)
						{
							name = AssetPaths.forestMissionFinish__txt;
							place = "miner";
							talkToBanana = false;

							playerBagPic();
						}
						else
							name = AssetPaths.forestMission__txt;
					}

					// 礦場對話
					else if (place == "minerDone")
						name = AssetPaths.minerDoge__txt;
					playerUpDown();
					dia.show(name, diaUpDown);

				// 斯巴達
				case "spartan":
					if (boxCounter >= boxGoal)
						name = AssetPaths.stoneMissionFinish__txt;
					else
						name = AssetPaths.minerSpartan__txt;
					playerUpDown();
					dia.show(name, diaUpDown);

				// 香蕉
				case "banana":
					if (dia.touchBanana)
						dia.startTalkToBanana();

				// 湖
				case "lake":
					name = AssetPaths.lakeTalking__txt;
					playerUpDown();
					dia.show(name, diaUpDown);
			}

			talk = "none";
		}
	}

	function playerBagPic()
	{
		player.loadGraphic(AssetPaths.apeNew__png, true, 46, 64);
		// 面向右邊時使用鏡像的左邊圖片
		player.setFacingFlip(LEFT, false, false);
		player.setFacingFlip(RIGHT, true, false);

		// 走路動畫
		player.animation.add("lr", [3, 4, 5, 6, 7], 6, false);
		player.animation.add("u", [9, 8, 10, 8], 6, false);
		player.animation.add("d", [1, 0, 2, 0], 6, false);
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

	// 斯巴達對話
	function spartanTalk(player:Player, spartan:FlxSprite)
	{
		bubblePosition(spartan.x, spartan.y, spartan.width);
		talk = "spartan";
	}

	// 香蕉問問題
	function forestQ(player:Player, banana:FlxSprite)
	{
		bubblePosition(banana.x, banana.y, banana.width);
		talk = "banana";

		name = AssetPaths.bananaQuestion__txt;
		playerUpDown();
		dia.bananaTalk(name, banana, diaUpDown, bqNumber);

		talkToBanana = true;
	}

	// 湖對話
	function lakeTalk(player:Player, lake:FlxSprite)
	{
		bubblePosition(lake.x, lake.y + lake.height / 2, lake.width);
		talk = "lake";
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
		if (r && place == "minerDone")
		{
			restartStone();
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
			FlxTween.tween(box, {x: 3000}, 1, {
				onComplete: function(_)
				{
					restartStone();
				}
			});
		}
	}

	// 重新開始推石頭遊戲
	function restartStone()
	{
		box.loadGraphic(AssetPaths.boxEmpty__png);
		stone.forEach(function(sprite)
		{
			sprite.kill();
		});
		place = "boxRestart";
		map.loadEntities(placeEntities, "entities");
		place = "minerDone";
	}

	// 對話結束時要做的事
	function updateWhenDiaInvisible()
	{
		// 對話框顯示時玩家就不能動
		if (dia.visible)
			player.active = false;
		else
			player.active = true;

		// 對話結束時要做什麼合集
		if (!dia.visible)
		{
			// 香蕉終結者2000
			if (talkToBanana)
			{
				// 如果答對香蕉的問題就殺香蕉換題目
				if (dia.bananaQ)
				{
					dia.banana.kill(); // 我們把香蕉移到迪亞那邊，殺死迪亞香蕉，然後砰！這裡的香蕉就死了
					bqNumber++;
					bananaCounter++;
					talkToBanana = false;
					dia.bananaQ = false;
				}
			}

			// 談笑間切換地圖
			switch (place)
			{
				// 前往礦場
				case "miner":
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						map.loadEntities(placeEntities, "entities");
						FlxG.camera.fade(FlxColor.BLACK, .33, true);
						banana.kill();

						name = AssetPaths.c2Opening__txt;
						playerUpDown();
						dia.show(name, diaUpDown);
						place = "stone";
					});

				// 參觀關卡
				case "stone":
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					{
						map.loadEntities(placeEntities, "entities");
						FlxG.camera.fade(FlxColor.BLACK, .33, true);
						place = "spartanOut";

						name = AssetPaths.stoneExplain__txt;
						playerUpDown();
						dia.show(name, diaUpDown);
					});

				// 斯巴達離開
				case "spartanOut":
					player.active = false;
					FlxTween.tween(spartan, {x: 3000}, 1, {
						onComplete: function(_)
						{
							map.loadEntities(placeEntities, "entities");
							place = "minerDone";
							player.active = true;
						}
					});
			}
		}
	}

	// 如果玩家在螢幕上方，對話框就放到下方
	function playerUpDown()
	{
		if (player.y % (FlxG.height * 2) > FlxG.height)
			diaUpDown = "up";
		else
			diaUpDown = "down";
	}
}
