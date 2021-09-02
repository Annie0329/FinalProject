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
	var diaUpDown:String;
	var profilePic:String;

	public var answer:Float = 0;

	public var bananaQ:Bool;
	public var banana:FlxSprite; // 我們把香蕉召喚到這裡

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(10, 10, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxText(120, background.y + 10, 350, "", 18);
		text.color = FlxColor.BLACK;
		add(text);

		// 箭頭
		pointer = new FlxSprite(text.x + 5, background.y + 38, AssetPaths.pointer__png);
		add(pointer);

		visible = false;

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	// 一般對話
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
	public function bananaTalk(name, banana, diaUpDown, bqNumber)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = bqNumber * 2;

		profile = 1;
		changeProfile();

		text.text = dilog_boxes[i];
		diaPosition(diaUpDown);

		bananaAnswer(bqNumber);

		visible = true;
		active = true;
		pointer.visible = true;

		this.banana = banana; // 我們告訴迪亞這隻香蕉(迪亞香蕉)是那隻香蕉(PlayState香蕉)(邏輯100)
	}

	// 換對話框頭像
	function changeProfile()
	{
		switch (dilog_boxes[profile])
		{
			case "B":
				profilePic = AssetPaths.diaBanana__png;
			case "D":
				profilePic = AssetPaths.diaDoge__png;
			case "A":
				profilePic = AssetPaths.diaApe__png;
			case "S":
				profilePic = AssetPaths.diaSpartan__png;
		}
		background.loadGraphic(profilePic);
	}

	// 對話框位置
	public function diaPosition(diaUpDown)
	{
		this.diaUpDown = diaUpDown;
		if (diaUpDown == "up")
			background.y = 10;
		else
			background.y = FlxG.height - background.height - 10;

		text.y = background.y + 10;
		pointer.y = background.y + 38;
	}

	// 香蕉問題答案
	function bananaAnswer(bqNumber)
	{
		if (bqNumber == 2 || bqNumber == 3 || bqNumber == 6)
			answer = background.y + 38;
		else if (bqNumber == 1 || bqNumber == 4)
			answer = background.y + 62;
		else
			answer = background.y + 86;
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		movePointer();
		super.update(elapsed);
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter)
		{
			// 香蕉問題回答的對錯
			if (pointer.visible)
			{
				if (pointer.y == answer)
				{
					bananaQ = true;
					name = AssetPaths.bananaYes__txt;
				}
				else
				{
					bananaQ = false;
					name = AssetPaths.bananaNo__txt;
				}
				pointer.visible = false;
				show(name, diaUpDown);
			}
			else
			{
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
	}

	// 移動箭頭
	function movePointer()
	{
		var up = FlxG.keys.anyJustReleased([UP]);
		var down = FlxG.keys.anyJustReleased([DOWN]);
		if (pointer.visible)
		{
			if (up)
			{
				if (pointer.y == background.y + 38)
					pointer.y = background.y + 86;
				else
					pointer.y -= 24;
			}
			if (down)
			{
				if (pointer.y == background.y + 86)
					pointer.y = background.y + 38;
				else
					pointer.y += 24;
			}
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
