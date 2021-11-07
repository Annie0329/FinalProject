package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
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
	var pointer:Pointer;
	var pointerQ:String = "none";
	var txt:Bool = true;

	public var name:String;

	public var diaUpDown:String;

	var profilePic:String;

	var textRunDone:Bool = false;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(10, 10, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxTypeText(background.x + 110, background.y + 10, 340, "text", 28, true);
		text.color = FlxColor.BLACK;
		text.font = AssetPaths.silver__ttf;
		// text.sounds = [FlxG.sound.load("assets/sounds/speech.wav")];
		text.delay = 0.07;
		text.skipKeys = ["X", "SHIFT"];
		add(text);

		// 箭頭
		pointer = new Pointer();
		add(pointer);
		pointer.visible = false;

		visible = false;
		active = false;

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	// 對話出現
	public function show(name, txt:Bool)
	{
		dilog_boxes = if (txt) openfl.Assets.getText(name).split(":") else dilog_boxes = name.split(":");
		i = 2;

		diaPosition(diaUpDown);

		profile = 1;
		changeProfile();

		active = true;
		visible = true;

		textRunDone = false;
		text.resetText(dilog_boxes[i]);
		text.start(false, false, function()
		{
			textRunDone = true;
			if (pointerQ != "none")
				pointer.visible = true;
		});
	}

	// 換對話框頭像
	function changeProfile()
	{
		switch (dilog_boxes[profile])
		{
			case "A":
				profilePic = AssetPaths.diaApe__png;
			case "D":
				profilePic = AssetPaths.diaDoge__png;
			case "S":
				profilePic = AssetPaths.diaSpartan__png;
			case "L":
				profilePic = AssetPaths.diaLake__png;
			case "N":
				profilePic = AssetPaths.diaNull__png;
			case "M":
				profilePic = AssetPaths.diaMing__png;
			case "SR":
				profilePic = AssetPaths.diaSbRed__png;
			case "SG":
				profilePic = AssetPaths.diaSbGreen__png;
			case "SB":
				profilePic = AssetPaths.diaSbBlue__png;
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
		pointer.y = background.y + 75;
		text.y = background.y + 10;
	}

	// 對話大滿貫
	public function context(npcType:NPC.NpcType)
	{
		if (npcType == doge)
		{
			name = AssetPaths.forestMission__txt;
			txt = true;
		}
		if (npcType == ming)
		{
			name = AssetPaths.mingTalking__txt;
			txt = true;
		}
		if (npcType == sbRed)
		{
			name = ":SR:你問我在做什麼？哼哼，我怎麼可能會告訴你我在竄改島上的交易紀錄呢？這次我一定可以做到的！";
			txt = false;
		}
		if (npcType == sbBlue)
		{
			name = ":SB:在迪拜島上，想更改交易紀錄，除非同時把一半以上的島民手中的交易紀錄改掉，不然是不可能成功的。";
			txt = false;
		}
		if (npcType == sbGreen)
		{
			name = ":SG:你遇到那隻紅領巾的笨狗了嗎？他又在做竄改交易紀錄的白日夢了。";
			txt = false;
		}
		if (npcType == monument)
		{
			name = ":N:裡面似乎有毀壞的記帳本。";
			txt = false;
		}
		show(name, txt);
	}

	// 呼叫箭頭
	public function getPointer(quest:String)
	{
		pointerQ = quest;
		switch (pointerQ)
		{
			
		}
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
		if (enter && textRunDone)
		{
			// 箭頭選擇
			if (pointer.visible)
			{
				switch (pointerQ) {}
				show(name, txt);
				pointer.visible = false;
				pointerQ = "none";
			}
			else
			{
				profile += 2;
				changeProfile();
				i += 2;

				// 對話結束就離開
				if (i > dilog_boxes.length)
				{
					text.resetText("  ");
					text.start(false, false, function()
					{
						visible = false;
						active = false;
					});
				}
				// 不然就換行
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
