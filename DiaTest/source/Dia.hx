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
import flixel.util.FlxTimer;

class Dia extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var text:FlxTypeText;

	var i:Int = 2;

	var profile:Int = 1;
	var profilePic:String;
	var npcType:NPC.NpcType;

	public var name:String;

	var dilog_boxes:Array<String>;
	var txt:Bool = true;
	var textRunDone:Bool = false;

	public var diaUpDown:String;

	var pointer:Pointer;
	var pointerQ:String = "none";

	public var saveStoneIntro:Bool = false;
	public var stoneTextYes:Bool = false;

	public var appleCoin:Float;
	public var bananaCoin:Float;

	var coinText:FlxText;

	// 香蕉換能量
	var bck = 1000;
	var bcBananaCoinIn:Int = 100; // 機器裡有多少香蕉
	var bcCoinIn:Float = 10;

	// 蘋果換能量
	var ack = 800;
	var acAppleCoinIn:Int = 40; // 機器裡有多少APS，蘋果就是APS
	var acCoinIn:Float = 20;

	// 能量換蘋果
	var cak = 800;
	var caCoinIn:Int = 40;
	var caAppleCoinIn:Float = 20;

	var coinOut:Int = 10; // 玩家決定要塞多少幣進去
	var machGain:Float = 0; // 玩家到底從機器得到多少錢

	// 穩定幣
	var bananaPrize:Int = 10;

	// 借貸
	var interest:Float = 0.01;
	var loan:Bool = false;
	var loanGain:Float = 0;

	public var diamond:Float;

	var diamondUiText:FlxText;

	public var updateDiamond:Bool = false;

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

		coinText = new FlxText(background.x, background.y + 20, background.width, "1", 28);
		coinText.color = FlxColor.BLACK;
		coinText.alignment = CENTER;
		coinText.font = AssetPaths.silver__ttf;
		add(coinText);
		coinText.visible = false;

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
		coinText.y = background.y + 80;
	}

	// 拿包包的參數
	public function getDiamond(diamond, diamondUiText, bananaCoin, appleCoin)
	{
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		this.bananaCoin = bananaCoin;
		this.appleCoin = appleCoin;
	}

	// 對話大滿貫
	public function context(npcType:NPC.NpcType)
	{
		this.npcType = npcType;
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

			case signDefi:
				name = AssetPaths.streetSign__txt;
				txt = true;
			case signApple:
				name = AssetPaths.appleAd__txt;
				txt = true;
			case house1Sign:
				name = ":N:交易所";
				txt = false;
			case p1:
				name = AssetPaths.house1Talk__txt;
				txt = true;
			case mathChart:
				name = ":N:是很難的數學。";
				txt = false;
			case p1BaToCoMach:
				if (bananaCoin >= 10)
				{
					name = ':N:你想用多少香蕉幣買能量幣？你目前有 $bananaCoin 香蕉幣。按X退出。'; // ， 1 香蕉幣可買 $p1Prize 能量幣。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的香蕉幣，至少要10香蕉幣。";
				txt = false;
			case p1ApToCoMach:
				if (appleCoin >= 10)
				{
					name = ':N:你想用多少APS幣買能量幣？你目前有 $appleCoin APS幣。按X退出。'; // ， 1 APS幣可買 $p1Prize 能量幣。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的APS幣，至少要10APS幣。";
				txt = false;
			case p1CoToApMach:
				if (diamond >= 10)
				{
					name = ':N:你想用多少能量幣買APS幣？你目前有 $diamond 能量幣。按X退出。'; // ， 1 能量幣可買 $p1Prize APS幣。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case house2Sign:
				name = ":N:穩定幣鑄造所";
				txt = false;
			case p2:
				name = AssetPaths.house2Talk__txt;
				txt = true;
			case p2Mach:
				if (diamond >= 10)
				{
					name = ':N:你想用多少能量幣買香蕉幣？ 你目前有 $diamond 能量幣';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case house3Sign:
				name = ":N:借貸所";
				txt = false;
			case p3:
				name = AssetPaths.house3Talk__txt;
				txt = true;
			case p3Mach:
				if (diamond >= 10)
				{
					name = ':N:你想放多少能量幣借貸？ 你目前有 $diamond 能量幣';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case house4Sign:
				name = ":N:ApeStarter";
				txt = false;
			case rod:
				name = AssetPaths.rodTalk__txt;
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

	// 左右選擇
	function updateLr()
	{
		var left = FlxG.keys.anyJustReleased([LEFT, A]);
		var right = FlxG.keys.anyJustReleased([RIGHT, D]);
		if (coinText.visible)
		{
			if (npcType == p1BaToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(bananaCoin / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(bcCoinIn - (bck / (bcBananaCoinIn + coinOut)), 3);
				coinText.text = '$coinOut  香蕉幣換 $machGain 能量幣';
			}
			else if (npcType == p1ApToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(appleCoin / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(acCoinIn - (ack / (acAppleCoinIn + coinOut)), 3);
				coinText.text = '$coinOut  APS幣換 $machGain 能量幣';
			}
			else if (npcType == p1CoToApMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(caAppleCoinIn - (cak / (caCoinIn + coinOut)), 3);
				coinText.text = '$coinOut  能量幣換 $machGain APS幣';
			}
			else if (npcType == p2Mach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = coinOut * bananaPrize;
				coinText.text = '$coinOut 能量幣換 $machGain 香蕉幣';
			}
			else if (npcType == p3Mach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = (loanGain + coinOut) * interest;
				coinText.text = '已投資' + (loanGain + coinOut) + '能量幣 利息10秒 $machGain 能量幣';
			}
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		updateLr();
		var x = FlxG.keys.anyJustReleased([X]);
		if (coinText.visible && x)
		{
			coinOut = 10;
			coinText.text = Std.string(coinOut);
			coinText.visible = false;
			visible = false;
			active = false;
		}
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
			// 機器
			else if (coinText.visible)
			{
				if (npcType == p1BaToCoMach)
				{
					name = ':N:你得到了 $machGain 能量幣。';
					txt = false;
					show(name, txt);

					// 算玩家的錢
					diamond += machGain;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					bananaCoin -= coinOut;

					// 算機器的錢
					bcBananaCoinIn += coinOut;
					bcCoinIn -= machGain;
				}
				else if (npcType == p1ApToCoMach)
				{
					name = ':N:你得到了 $machGain 能量幣。';
					txt = false;
					show(name, txt);

					// 算玩家的錢
					diamond += machGain;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					appleCoin -= coinOut;

					// 算機器的錢
					acAppleCoinIn += coinOut;
					acCoinIn -= machGain;
				}
				else if (npcType == p1CoToApMach)
				{
					name = ':N:你得到了 $machGain APS幣。';
					txt = false;
					show(name, txt);

					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					appleCoin += machGain;

					caCoinIn += coinOut;
					caAppleCoinIn -= machGain;
				}
				// 穩定幣
				else if (npcType == p2Mach)
				{
					name = ':N:你得到 $machGain 香蕉幣。';
					txt = false;
					show(name, txt);
					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					bananaCoin += bananaPrize * coinOut;
				}
				else if (npcType == p3Mach)
				{
					name = ':N:你共投資了' + (coinOut + loanGain) + '能量幣。';
					txt = false;
					show(name, txt);
					diamond -= coinOut;
					loanGain += coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					if (!loan)
					{
						loan = true;

						new FlxTimer().start(10, function(timer:FlxTimer)
						{
							diamond += loanGain * interest;
							diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
							updateDiamond = true;
						}, 0);
					}
				}
				coinOut = 10;
				coinText.text = Std.string(coinOut);
				coinText.visible = false;
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
