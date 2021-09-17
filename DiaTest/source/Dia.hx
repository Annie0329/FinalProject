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
	var explain:FlxSprite;
	var pointer:FlxSprite;

	public var name:String;

	var diaUpDown:String;
	var profilePic:String;

	public var touchBanana:Bool = false;

	var textRunDone:Bool = false;

	public var answer:Float = 0;

	public var bananaQ:Bool;
	public var banana:FlxSprite; // 我們把香蕉召喚到這裡

	public function new()
	{
		super();

		// 解釋畫面
		explain = new FlxSprite(0, 0, AssetPaths.explain1__png);
		explain.scrollFactor.set(0, 0);
		add(explain);

		// 背景
		background = new FlxSprite(10, 10, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxTypeText(120, background.y + 10, 350, "text", 18);
		text.color = FlxColor.BLACK;
		add(text);

		text.delay = 0.04;
		text.skipKeys = ["X"];

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
		text.resetText(dilog_boxes[i]);

		profile = 1;
		changeProfile();

		diaPosition(diaUpDown);

		visible = true;
		active = true;
		textRunDone = false;

		pointer.visible = false;

		text.start(false, false, function()
		{
			textRunDone = true;
		});
	}

	// 香蕉對話
	public function bananaTalk(name, banana, diaUpDown, bqNumber)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = bqNumber * 2;
		text.resetText(dilog_boxes[i]);

		profile = 1;
		changeProfile();

		diaPosition(diaUpDown);

		bananaAnswer(bqNumber);

		this.banana = banana; // 我們告訴迪亞這隻香蕉(迪亞香蕉)是那隻香蕉(PlayState香蕉)(邏輯100)
		touchBanana = true;
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
			case "L":
				profilePic = AssetPaths.diaLake__png;
		}

		// 召喚解釋畫面
		if (dilog_boxes[profile] == "DE")
		{
			profilePic = AssetPaths.diaDoge__png;
			explainPic = "assets/images/explain" + Std.string(explainNum) + ".png";
			explain.loadGraphic(explainPic);
			explain.visible = true;
			explainNum++;
		}
		else
			explain.visible = false;

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

	// 開始跟香蕉說話，因為香蕉是群組呼叫比較麻煩
	public function startTalkToBanana()
	{
		visible = true;
		active = true;
		textRunDone = false;

		// 文字動畫跑完才會出現箭頭
		text.start(true, false, function()
		{
			pointer.visible = true;
			touchBanana = false;
			textRunDone = true;
		});
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		movePointer();

		// 如果玩家離開香蕉就不能跟香蕉說話
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (FlxG.keys.anyJustPressed([A, S, W, D, UP, DOWN, LEFT, RIGHT]) && !visible)
		{
			active = false;
			touchBanana = false;
		}

		super.update(elapsed);
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter) // && textRunDone)
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
			else if (!touchBanana)
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

	// 按v鍵直接跳過整串對話
	function updateSkip()
	{
		var vKey:Bool = false;
		vKey = FlxG.keys.anyJustReleased([V]);
		if (vKey && !pointer.visible)
		{
			visible = false;
			active = false;
		}
	}
}
