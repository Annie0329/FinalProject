package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxAxes;

class ForestState extends FlxState
{
	var player:Player;
	var dia:Dia;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var door:FlxTypedGroup<Door>;
	var banana:FlxTypedGroup<Banana>;
	var name:String;
	var i:Int = 0;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.diaMap__ogmo, AssetPaths.forestMap__json);

		// 地圖
		road = map.loadTilemap(AssetPaths.forestTiles__png, "road");
		road.follow();
		add(road);

		// 牆
		walls = map.loadTilemap(AssetPaths.forestTiles__png, "wall");
		walls.follow();
		add(walls);

		// 玩家
		player = new Player();
		add(player);

		FlxG.camera.follow(player, TOPDOWN, 1);
		door = new FlxTypedGroup<Door>();
		add(door);

		banana = new FlxTypedGroup<Banana>();
		add(banana);

		dia = new Dia();
		add(dia);

		map.loadEntities(placeEntities, "entities");

		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			// 把玩家的x跟y弄得跟地圖設定的一樣
			case "player":
				player.setPosition(x + 8, y + 8);

			case "door":
				door.add(new Door(entity.x + 20, entity.y + 20));

			case "banana":
				banana.add(new Banana(entity.x, entity.y));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.collide(player, banana, forestQ);
		FlxG.overlap(player, door, changeState);

		if (dia.visible)
			player.active = false;
		else
			player.active = true;
	}

	//香蕉問問題
	function forestQ(player:Player, banana:Banana)
	{
		i++;
		if (i > 3)
			i = 1;
		name = "assets/data/bananaQ" + Std.string(i) + ".txt";
		trace(name);
		dia.show(name);
	}

	//回到紀念碑
	function changeState(player:Player, door:Door)
	{
		FlxG.switchState(new PlayState());
	}
}
