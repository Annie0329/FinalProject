package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var i:Int = 2;
	var profile:Int = 1;

	var explainNum:Int = 1;
	var explainPic:String;

	var dilog_boxes:Array<String>;

	var text:FlxTypeText;
	var background:FlxSprite;

	public var name:String;

	var diaUpDown:String;
	var profilePic:String;

	var textRunDone:Bool = false;

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
		text = new FlxTypeText(120, background.y + 10, 350, "text", 18);
		text.color = FlxColor.BLACK;
		add(text);

		text.delay = 0.04;
		text.skipKeys = ["X", "SHIFT"];

		visible = false;
		active = false;

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	// 對話
	public function show(name, diaUpDown)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 2;
		text.resetText(dilog_boxes[i]);

		profile = 1;
		changeProfile();

		diaPosition(diaUpDown);

		textRunDone = false;

		visible = true;
		active = true;

		text.start(false, false, function()
		{
			textRunDone = true;
		});
	}

	// 換對話框頭像
	function changeProfile()
	{
		switch (dilog_boxes[profile])
		{
			case "D":
				profilePic = AssetPaths.diaDoge__png;
			case "A":
				profilePic = AssetPaths.diaApe__png;
			case "S":
				profilePic = AssetPaths.diaSpartan__png;
			case "L":
				profilePic = AssetPaths.diaLake__png;
			case "N":
				profilePic = AssetPaths.diaNull__png;
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
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();

		super.update(elapsed);
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter) // && textRunDone)
		{
			profile += 2;
			changeProfile();

			i += 2;

			// 對話結束就離開
			if (i > dilog_boxes.length)
			{
				visible = false;
				active = false;
			}
			else
			{
				textRunDone = false;
				text.resetText(dilog_boxes[i]);
				text.start(false, false, function()
				{
					textRunDone = true;
				});
			}
		}
	}

	// 按v鍵直接跳過整串對話
	function updateSkip()
	{
		var vKey:Bool = false;
		vKey = FlxG.keys.anyJustReleased([V]);
		if (vKey)
		{
			visible = false;
			active = false;
		}
	}
}
