package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.frontEnds.BitmapFrontEnd;
import flixel.tile.FlxTilemap;
import flixel.util.FlxAxes;

class PlayState extends FlxState
{
	var player:Player;
	var guy:Guy;
	var dia:Dia;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var road:FlxTilemap;
	var door:FlxTypedGroup<Door>;
	var name:String;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.diaMap__ogmo, AssetPaths.monumentMap__json);

		// 地圖
		road = map.loadTilemap(AssetPaths.monumentTiles__png, "road");
		road.follow();
		add(road);

		// 牆
		walls = map.loadTilemap(AssetPaths.monumentTiles__png, "wall");
		walls.follow();
		add(walls);

		//Doge
		guy = new Guy(0, 0);
		guy.screenCenter(FlxAxes.X);
		guy.immovable = true;
		add(guy);

		// 玩家
		player = new Player();
		add(player);

		FlxG.camera.follow(player, TOPDOWN, 1);

		//任意門
		door = new FlxTypedGroup<Door>();
		add(door);

		//對話框
		dia = new Dia();
		add(dia);

		map.loadEntities(placeEntities, "entities");

		super.create();
	}

	public function placeEntities(entity:EntityData)
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

			case "guy":
				guy.setPosition(x, y);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.collide(player, guy, callDia);
		FlxG.overlap(player, door, changeState);

		if (dia.visible)
			player.active = false;
		else
			player.active = true;
	}

	function callDia(player:Player, guy:Guy)
	{
		name = "assets/data/forestMission.txt";
		dia.show(name);
	}

	function changeState(player:Player, door:Door)
	{
		if (player.x < 0)
			FlxG.switchState(new ForestState());
	}
}
