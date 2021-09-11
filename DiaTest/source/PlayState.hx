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

	// 對話框和他的變數
	var dia:Dia;
	var diaUpDown:String;
	var name:String;

	// 香蕉和他的變數
	var banana:FlxTypedGroup<FlxSprite> = null;
	var bananaTalk:Bool;
	var bananaCounter:Int = 0;
	var bqNumber:Int = 1;

	// 其他角色
	var doge:FlxSprite;
	var spartan:FlxSprite;

	var box:FlxSprite;
	var boxCounter:Int = 0;
	var stone:FlxTypedGroup<FlxSprite> = null;
	var stoneCounter:Int = 0;
	var target:FlxSprite;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;
	var place:String = "monumentDone";

	// 章節
	var chapter:Int = 1;

	// 除錯ufo
	var ufo:FlxText;

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

		// 箱子目標
		target = new FlxSprite(AssetPaths.target__png);
		add(target);

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		// 香蕉
		banana = new FlxTypedGroup<FlxSprite>();
		add(banana);

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

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 除錯ufo
		ufo = new FlxText(0, 0, "ufo", 20);
		ufo.borderColor = FlxColor.BLACK;
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		// ufo.visible = false;

		// 呼叫開場白
		name = AssetPaths.c1Opening__txt;
		diaUpDown = "up";
		dia.show(name, diaUpDown);

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	// 設位置
	public function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (place)
		{
			// 紀念碑
			case "monumentDone":
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

					case "target":
						target.setPosition(x + 4, y + 4);
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
						box.setPosition(x + 4, y + 4);
				}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateWhenDiaInvisible();

		// 除錯大隊
		ufo.text = place; // Std.string(FlxG.mouse.screenX) + ", " + Std.string(FlxG.mouse.screenY);

		var d = FlxG.keys.anyJustReleased([D]);

		if (d) {}

		// 按r重新開始推石頭遊戲
		var r = FlxG.keys.anyJustReleased([R]);
		if (r && place == "minerDone")
			restartStone();

		// 碰撞爆
		FlxG.overlap(player, ground);
		FlxG.overlap(player, road);
		FlxG.collide(player, walls);
		FlxG.overlap(player, through);

		FlxG.collide(player, doge, dogeTalk);
		FlxG.collide(player, spartan, spartanTalk);
		FlxG.collide(player, banana, forestQ);
		FlxG.collide(player, stone, stoneStop);
		FlxG.collide(player, box, boxStop);

		FlxG.collide(stone, walls);
		FlxG.collide(stone, box, stoneInsideBox);

		FlxG.collide(box, walls);
		FlxG.overlap(box, target, boxOnTarget);
	}

	// Doge對話
	function dogeTalk(player:Player, doge:FlxSprite)
	{
		// 紀念碑對話
		if (place == "monumentDone")
		{
			if (bananaCounter == 0)
			{
				name = AssetPaths.forestMissionFinish__txt;
				place = "miner";
			}
			else
				name = AssetPaths.forestMission__txt;
		}

		// 礦場對話
		else if (place == "minerDone")
			name = AssetPaths.minerDoge__txt;

		playerUpDown();
		dia.show(name, diaUpDown);
	}

	// 斯巴達對話
	function spartanTalk(player:Player, spartan:FlxSprite)
	{
		if (boxCounter > 0)
			name = AssetPaths.stoneMissionFinish__txt;
		else
			name = AssetPaths.minerSpartan__txt;

		playerUpDown();
		dia.show(name, diaUpDown);
	}

	// 香蕉問問題
	function forestQ(player:Player, banana:FlxSprite)
	{
		name = AssetPaths.bananaQuestion__txt;

		playerUpDown();
		dia.bananaTalk(name, banana, diaUpDown, bqNumber);

		bananaTalk = true;
	}

	// 石頭別動
	function stoneStop(player:Player, stone:FlxSprite)
	{
		stone.velocity.set(0, 0);
	}

	// 箱子別動
	function boxStop(player:Player, box:FlxSprite)
	{
		box.velocity.set(0, 0);
	}

	// 石頭放到箱子裡了
	function stoneInsideBox(stone:FlxSprite, box:FlxSprite)
	{
		stone.kill();
		stoneCounter++;
		if (stoneCounter > 0)
		{
			box.loadGraphic(AssetPaths.boxFull__png);
			box.immovable = false;
		}
	}

	// 箱子碰到目標了
	function boxOnTarget(box:FlxSprite, target:FlxSprite)
	{
		if (stoneCounter > 0)
		{
			// 把箱子移到原位
			FlxTween.tween(box, {x: target.x, y: target.y}, 0.5, {
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
		// 先把玩家移到原位
		FlxTween.tween(player, {x: 3520, y: 1280}, 0.5, {
			onComplete: function(_)
			{
				stoneCounter = 0;
				box.immovable = true;
				box.loadGraphic(AssetPaths.boxEmpty__png);
				stone.forEach(function(sprite)
				{
					sprite.kill();
				});
				place = "boxRestart";
				map.loadEntities(placeEntities, "entities");
				place = "minerDone";
				boxCounter++;
			}
		});
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
			if (bananaTalk)
			{
				if (dia.bananaQ)
				{
					dia.banana.kill(); // 我們把香蕉移到迪亞那邊，殺死迪亞香蕉，然後砰！這裡的香蕉就死了
					bqNumber++;
					bananaCounter++;
				}
				bananaTalk = false;
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
						place = "stone";

						name = AssetPaths.c2Opening__txt;
						playerUpDown();
						dia.show(name, diaUpDown);
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
					FlxTween.tween(spartan, {x: 3000}, 1, {
						onComplete: function(_)
						{
							map.loadEntities(placeEntities, "entities");
							place = "minerDone";
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
