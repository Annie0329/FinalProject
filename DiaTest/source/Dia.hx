package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var i:Int = 1;
	var dilog_boxes:Array<String>;
	var text:FlxText;
	var background:FlxSprite;
	var name:String;
	var pointer:FlxSprite;

	public var banana:Banana; // 我們把香蕉召喚到這裡

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		background.setPosition(0, 10);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxText(10, 10, FlxG.width - 20, "", 20);
		add(text);

		pointer = new FlxSprite().makeGraphic(10, 10, FlxColor.YELLOW);
		pointer.setPosition(0, 10);
		pointer.screenCenter(FlxAxes.X);
		add(pointer);

		visible = false;

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	// 講話
	public function show(name)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 1;
		text.text = dilog_boxes[i];
		visible = true;
		active = true;
		pointer.visible = false;
	}

	public function bananaTalk(name, banana)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 1;
		text.text = dilog_boxes[i];
		visible = true;
		active = true;
		pointer.visible = true;

		this.banana = banana; // 我們告訴迪亞這隻香蕉(迪亞香蕉)是那隻香蕉(PlayState香蕉)(邏輯100)
	}

	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		super.update(elapsed);
	}

	// 按Enter換行
	function updateEnter()
	{
		var enter:Bool = false;
		enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter == true)
		{
			if (pointer.visible)
			{
				i = 2;
				pointer.visible = false;
			}

			i++;

			if (i != dilog_boxes.length)
				text.text = dilog_boxes[i];
			else
			{
				visible = false;
				active = false;
			}
		}
	}

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
