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
	var text:FlxText;
	var bananaTalk:Bool;
	var bananaCounter:Int = 0;

	var name:String;
	var i:Int = 0;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.testMap__ogmo, AssetPaths.testMap__json);

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
		dia.show(name);

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
				player.setPosition(x + 4, y + 4);

			case "guy":
				guy.setPosition(x, y);

			case "banana":
				banana.add(new Banana(entity.x + 10, entity.y + 10));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
		dia.show(name);
	}

	// 香蕉問問題
	function forestQ(player:Player, banana:Banana)
	{
		i++;
		if (i > 3)
			i = 1;
		name = "assets/data/bananaQ" + Std.string(i) + ".txt";
		dia.bananaTalk(name, banana);
		bananaTalk = true;
	}
}
