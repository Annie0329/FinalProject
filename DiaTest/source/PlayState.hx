package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
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
	var banana:FlxTypedGroup<Banana>;
	var bananaTalk:Bool;
	var bananaCounter:Int = 0;
	var bqNumber:Int = 1;

	// 其他角色
	var doge:FlxSprite;
	var spartan:FlxSprite;

	// 地圖組
	var map:FlxOgmo3Loader;
	var through:FlxTilemap;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var ground:FlxTilemap;

	var place:String = "monumentDone";

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

		// 玩家
		player = new Player();
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);

		// 香蕉
		banana = new FlxTypedGroup<Banana>();
		add(banana);

		// Doge
		doge = new FlxSprite(AssetPaths.doge__png);
		doge.immovable = true;
		add(doge);

		// 布布
		spartan = new FlxSprite(AssetPaths.spartan__png);
		spartan.immovable = true;
		add(spartan);

		// 在前面的物件
		through = map.loadTilemap(AssetPaths.mtSmall__png, "through");
		through.follow();
		add(through);

		// 對話框
		dia = new Dia();
		add(dia);

		// 角色擺位置
		map.loadEntities(placeEntities, "entities");

		// 除錯ufo
		ufo = new FlxText(0, 0, "ddd", 20);
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
			case "monumentDone":
				switch (entity.name)
				{
					case "player":
						player.setPosition(x + 8, y + 8);

					case "guy":
						doge.setPosition(x, y);

					case "banana":
						banana.add(new Banana(entity.x + 20, entity.y + 20));

					case "spartan":
						spartan.setPosition(x, y);
				}
			case "miner":
				switch (entity.name)
				{
					case "playerMiner":
						player.setPosition(x + 8, y + 8);

					case "guyMiner":
						doge.setPosition(x, y);
				}
			case "stone":
				switch (entity.name)
				{
					case "playerStone":
						player.setPosition(x + 8, y + 8);

					case "spartanStone":
						spartan.setPosition(x, y);
				}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// 除錯大隊
		ufo.text = place; // Std.string(FlxG.mouse.screenX) + ", " + Std.string(FlxG.mouse.screenY);

		var d = FlxG.keys.anyJustReleased([D]);
		if (d)
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.5, true);
		}

		// 碰撞爆
		FlxG.collide(player, walls);
		FlxG.overlap(player, road);
		FlxG.collide(player, doge, dogeTalk);
		FlxG.collide(player, spartan, spartanTalk);
		FlxG.collide(player, banana, forestQ);

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

			// 換地圖
			switch (place)
			{
				case "miner":
					FlxG.camera.fade(FlxColor.BLACK, 0.5, true);
					map.loadEntities(placeEntities, "entities");
					FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

					banana.kill();

					place = "stone";
					name = AssetPaths.c2Opening__txt;

					playerUpDown();
					dia.show(name, diaUpDown);

				case "stone":
					FlxG.camera.fade(FlxColor.BLACK, 0.5, true);
					map.loadEntities(placeEntities, "entities");
					FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

					name = AssetPaths.stoneExplain__txt;
					place = "minerDone";

					playerUpDown();
					dia.show(name, diaUpDown);
			}
		}
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
		{
			name = AssetPaths.minerDoge__txt;
		}

		playerUpDown();
		dia.show(name, diaUpDown);
	}

	// 香蕉問問題
	function forestQ(player:Player, banana:Banana)
	{
		playerUpDown();

		name = AssetPaths.bananaQuestion__txt;
		dia.bananaTalk(name, banana, diaUpDown, bqNumber);

		bananaTalk = true;
	}

	// 斯巴達對話
	function spartanTalk(player:Player, spartan:FlxSprite)
	{
		name = AssetPaths.minerSpartan__txt;

		playerUpDown();
		dia.show(name, diaUpDown);
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
