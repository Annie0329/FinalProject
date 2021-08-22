package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var guy:Guy;
	var dia:Dia;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var banana:FlxTypedGroup<Banana>;
	var ufo:FlxText;
	var bananaTalk:Bool;
	var bananaCounter:Int = 0;

	var diaUpDown:String;
	var name:String;
	var i:Int = 0;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.diaMap__json);

		// 地圖
		road = map.loadTilemap(AssetPaths.mtSmall__png, "road");
		road.follow();
		add(road);

		// 牆
		walls = map.loadTilemap(AssetPaths.mtSmall__png, "wall");
		walls.follow();
		add(walls);

		// Doge
		guy = new Guy();
		guy.immovable = true;
		add(guy);

		// 玩家
		player = new Player();
		add(player);

		ufo = new FlxText(240, (FlxG.height - 40) / 2, FlxG.width / 4, "ddd", 20);
		// text.screenCenter();
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		FlxG.camera.follow(player, TOPDOWN, 1);

		// 香蕉
		banana = new FlxTypedGroup<Banana>();
		add(banana);

		// 對話框
		dia = new Dia();
		add(dia);

		// 地圖
		map.loadEntities(placeEntities, "entities");

		name = "assets/data/c1Begining.txt";
		diaUpDown = "up";
		dia.show(name, diaUpDown);

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
				player.setPosition(x + 8, y + 8);

			case "guy":
				guy.setPosition(x, y);

			case "banana":
				banana.add(new Banana(entity.x + 20, entity.y + 20));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		ufo.text = Std.string(player.y % (FlxG.height * 2));

		FlxG.collide(player, walls);
		FlxG.collide(player, guy, forestMis);
		FlxG.collide(player, banana, forestQ);

		if (dia.visible)
		{
			player.active = false;
		}
		else
			player.active = true;

		// 香蕉終結者2000
		if (bananaTalk)
		{
			if (!dia.visible)
			{
				dia.banana.kill(); // 我們把香蕉移到迪亞那邊，殺死迪亞香蕉，然後砰！這裡的香蕉就死了
				bananaTalk = false;
				bananaCounter++;
			}
		}
	}

	// Doge在紀念碑的對話
	function forestMis(player:Player, guy:Guy)
	{
		if (bananaCounter == 3)
			name = "assets/data/forestMissionFinish.txt";
		else
			name = "assets/data/forestMission.txt";
		playerUpDown();
		dia.show(name, diaUpDown);
	}

	// 香蕉問問題
	function forestQ(player:Player, banana:Banana)
	{
		i++;
		if (i > 3)
			i = 1;
		playerUpDown();

		name = "assets/data/bananaQ" + Std.string(i) + ".txt";
		dia.bananaTalk(name, banana, diaUpDown);

		bananaTalk = true;
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
