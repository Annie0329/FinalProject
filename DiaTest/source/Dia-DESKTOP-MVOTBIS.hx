package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var text:FlxTypeText;

	var i:Int = 2;

	var profile:Int = 1;
	var profilePic:String;

	public var name:String;

	var dilog_boxes:Array<String>;
	var txt:Bool = true;
	var textRunDone:Bool = false;

	public var diaUpDown:String;

	var pointer:Pointer;
	var pointerQ:String = "none";

	public var saveStoneIntro:Bool = false;
	public var stoneTextYes:Bool = false;

	var k = 350;

	public var appleCoin:Float;
	public var bananaCoin:Float;

	var bananaCoinIn:Int = 1; // 機器裡有多少香蕉
	var bananaCoinOut:Int = 1; // 玩家決定要塞多少香蕉進去
	var diamondToBaPri:Float;

	public var diamond:Float;

	var diamondUiText:FlxText;

	public var updateDiamond:Bool = false;

	var bananaText:FlxText;

	var save:FlxSave;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(10, 10, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxTypeText(background.x + 110, background.y + 15, 340, "text", 28, true);
		text.color = FlxColor.BLACK;
		text.font = AssetPaths.silver__ttf;
		text.delay = 0.05;
		text.skipKeys = ["X", "SHIFT"];
		add(text);

		bananaText = new FlxText(background.x + background.width / 2, background.y + 20, "1", 20);
		bananaText.color = FlxColor.BLACK;
		add(bananaText);
		bananaText.visible = false;

		// 箭頭
		pointer = new Pointer();
		add(pointer);
		pointer.visible = false;

		save = new FlxSave();
		save.bind("DiaTest");

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
			case "D":
				profilePic = AssetPaths.diaDoge__png;
			case "S":
				profilePic = AssetPaths.diaSpartan__png;
			case "L":
				profilePic = AssetPaths.diaLake__png;
			case "N", "P1", "P2", "P3":
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
		text.y = background.y + 15;
		bananaText.y = background.y + 80;
	}

	// 拿包包的參數
	public function getDiamond(diamond, diamondUiText, bananaCoin)
	{
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		this.bananaCoin = bananaCoin;
	}

	// 左右選擇
	function updateLr()
	{
		var left = FlxG.keys.anyJustReleased([LEFT, A]);
		var right = FlxG.keys.anyJustReleased([RIGHT, D]);
		if (left || right)
		{
			if (bananaText.visible)
			{
				if (left && bananaCoinOut != 1)
					bananaCoinOut--;
				else if (right && bananaCoinOut != Std.int(bananaCoin))
					bananaCoinOut++;
				bananaText.text = Std.string(bananaCoinOut);
			}
		}
	}

	// 對話大滿貫
	public function context(npcType:NPC.NpcType)
	{
		switch (npcType)
		{
			case doge:
				name = AssetPaths.forestMission__txt;
				txt = true;

			case ming:
				name = AssetPaths.mingTalking__txt;
				txt = true;

			case sbRed:
				name = AssetPaths.srTalk__txt;
				txt = true;

			case sbBlue:
				name = AssetPaths.sbTalk__txt;
				txt = true;

			case sbGreen:
				name = AssetPaths.sgTalk__txt;
				txt = true;

			case monument:
				name = ":N:裡面似乎有毀壞的記帳本。";
				txt = false;

			case lake:
				name = AssetPaths.lakeTalking__txt;
				txt = true;

			case saveStone:
				if (saveStoneIntro)
				{
					name = ":N:存檔成功！";
					txt = false;
				}
				else
				{
					name = AssetPaths.saveStoneIntro__txt;
					txt = true;
					saveStoneIntro = true;
				}
			case spartan:
				if (stoneTextYes)
				{
					name = ":S:加油！";
					txt = false;
				}
				else
				{
					name = AssetPaths.spartanTalk__txt;
					txt = true;
					stoneTextYes = true;
				}

			case sign:
				name = AssetPaths.streetSign__txt;
				txt = true;

			case p1:
				name = AssetPaths.house1Talk__txt;
				txt = true;

			case p1Mach:
				diamondToBaPri = FlxMath.roundDecimal(k / bananaCoinIn, 2);
				if (bananaCoin > 0)
				{
					name = ':N:你想用多少香蕉幣買能量幣？你目前有 $bananaCoin 香蕉幣，現在 1 香蕉幣可買 $diamondToBaPri 能量幣。';
					bananaText.visible = true;
				}
				else
					name = ":N:你沒有香蕉幣。";
				txt = false;

			case p2:
				name = AssetPaths.house2Talk__txt;
				txt = true;
			case p3:
				name = AssetPaths.house3Talk__txt;
				txt = true;
		}
		show(name, txt);
	}

	// 呼叫箭頭
	public function getPointer(quest:String)
	{
		pointerQ = quest;
		switch (pointerQ) {}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		updateLr();

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
			else if (bananaText.visible)
			{
				name = ":N:你得到了 " + FlxMath.roundDecimal(diamondToBaPri * bananaCoinOut, 2) + " 能量幣。";
				txt = false;
				show(name, txt);
				diamond += (diamondToBaPri * bananaCoinOut);
				diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
				bananaCoin -= bananaCoinOut;
				bananaCoinIn += bananaCoinOut;
				bananaCoinOut = 1;
				bananaText.visible = false;
				bananaText.text = Std.string(bananaCoinOut);
				updateDiamond = true;
			}
			// 對話換行
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
