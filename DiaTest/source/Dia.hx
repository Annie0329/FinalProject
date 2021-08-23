package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var i:Int = 2;
	var profile:Int = 1;

	var dilog_boxes:Array<String>;
	var text:FlxText;
	var background:FlxSprite;
	var name:String;
	var pointer:FlxSprite;
	var enter:Bool = false;

	public var banana:Banana; // 我們把香蕉召喚到這裡

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(10, 10, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxText(120, background.y + 10, FlxG.width / 3 * 2, "", 20);
		text.color = FlxColor.BLACK;
		add(text);

		pointer = new FlxSprite().makeGraphic(10, 10, FlxColor.YELLOW);
		pointer.setPosition(0, background.y);
		pointer.screenCenter(FlxAxes.X);
		add(pointer);

		visible = false;

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	// 講話
	public function show(name, diaUpDown)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 2;

		profile = 1;
		changeProfile();

		text.text = dilog_boxes[i];
		diaPosition(diaUpDown);

		visible = true;
		active = true;
		pointer.visible = false;
	}

	// 香蕉對話
	public function bananaTalk(name, banana, diaUpDown)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 2;

		profile = 1;
		changeProfile();

		text.text = dilog_boxes[i];
		diaPosition(diaUpDown);

		visible = true;
		active = true;

		pointer.visible = true;

		this.banana = banana; // 我們告訴迪亞這隻香蕉(迪亞香蕉)是那隻香蕉(PlayState香蕉)(邏輯100)
	}

	// 換對話框
	function changeProfile()
	{
		switch (dilog_boxes[profile])
		{
			case "B":
				background.loadGraphic(AssetPaths.diaBanana__png);
			case "D":
				background.loadGraphic(AssetPaths.diaDoge__png);
			case "A":
				background.loadGraphic(AssetPaths.diaApe__png);
			case "S":
				background.loadGraphic(AssetPaths.diaSpartan__png);
		}
	}

	// 如果玩家在上方，對話框就放到下方
	public function diaPosition(diaUpDown)
	{
		if (diaUpDown == "up")
			background.y = 10;
		else
			background.y = FlxG.width / 2;

		text.y = background.y + 10;
		pointer.y = background.y;
	}

	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		super.update(elapsed);
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter == true)
		{
			if (pointer.visible)
			{
				i = 4;
				pointer.visible = false;
			}

			profile += 2;
			changeProfile();

			i += 2;

			if (i > dilog_boxes.length)
			{
				visible = false;
				active = false;
			}
			else
				text.text = dilog_boxes[i];
		}
	}

	// 按x鍵直接跳過整串對話
	function updateSkip()
	{
		var xKey:Bool = false;
		xKey = FlxG.keys.anyJustReleased([X]);
		if (xKey && !pointer.visible)
		{
			visible = false;
			active = false;
		}
	}
}
