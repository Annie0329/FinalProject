package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class Dia extends FlxTypedGroup<FlxSprite>
{
	public var win:Bool = false;

	var background:FlxSprite;
	var text:FlxTypeText;
	var enterCur:FlxSprite;

	// 聲音組
	var next:FlxSound;
	var check:FlxSound;
	var cancel:FlxSound;
	var move:FlxSound;

	// 礦場海報
	var minerPoster:FlxSprite;

	var profile:Int = 1;
	var profilePic:String;
	var npcType:NPC.NpcType;
	var name:String;
	var i:Int = 2;
	var dilog_boxes:Array<String>;
	var txt:Bool = true;
	var textRunDone:Bool = false;

	// 存檔的字
	var saveShow:String = ":N:oui";

	public var diaUpDown:String;

	// 選擇箭頭
	var pointer:Pointer;
	var pointerQ:String = "none";

	// 誰說過了什麼
	public var saveStoneIntro:Bool = false;
	public var stoneTextYes:Bool = false;
	public var leafYes:Bool = false;
	public var talkMiss:Bool = false;
	public var talkDone:Bool = false;
	public var lakeTalking:Bool = false;
	public var saveStoneYes:Bool = false;
	public var readDaSign:Bool = false;
	public var twentyDiamond:Bool = false;

	// 各種錢的數值
	public var appleCoin:Float;
	public var bananaCoin:Float;
	public var dexCoin:Float;
	public var rodWave:Float = 0;
	public var rodInvest:Int = 0;

	// 機器介面
	var coinOutText:FlxText;
	var machGainText:FlxText;
	var coinHaveText:FlxText;

	// 香蕉換能量
	var bck = 10000000;
	var bcBananaCoinIn:Int = 10000; // 機器裡有多少香蕉
	var bcCoinIn:Float = 1000;

	// 蘋果換能量
	var ack = 10000000;
	var acAppleCoinIn:Int = 5000; // 機器裡有多少APS，蘋果就是APS
	var acCoinIn:Float = 2000;

	// 能量換蘋果
	var cak = 8000000;
	var caCoinIn:Int = 4000;
	var caAppleCoinIn:Float = 2000;

	var coinOut:Int = 10; // 玩家決定要塞多少幣進去
	var machGain:Float = 0; // 玩家到底從機器得到多少錢

	// 穩定幣
	var bananaPrize:Int = 10;

	// 青蛙幣
	var dexPrizeBuy:Int = 4;
	var dexPrizeSell:Float = 0.5;

	// 借貸
	public var interest:Float = 0.001; // 利息
	public var loanGain:Float = 0; // 投資多少
	public var loan:Bool = false;

	// 能量幣
	public var diamond:Float;

	var diamondUiText:FlxText;

	// 更新包包
	public var updateDiamond:Bool = false;

	// 存檔元件
	var save:FlxSave;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite(30, 30, AssetPaths.diaDoge__png);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 字
		text = new FlxTypeText(background.x + 330, background.y + 45, 1020, "text", 84, true);
		text.color = FlxColor.BLACK;
		text.font = AssetPaths.silver__ttf;
		text.delay = 0.05;
		text.sounds = [FlxG.sound.load(AssetPaths.typing__ogg)];
		text.finishSounds = true;
		text.skipKeys = ["X", "SHIFT"];
		add(text);

		// 指示你可以跳行的箭頭
		enterCur = new FlxSprite(background.x + background.width / 2 - 30, background.y + 310, AssetPaths.pointer__png);
		enterCur.color = FlxColor.BLACK;
		enterCur.angle = 90;
		add(enterCur);
		enterCur.visible = false;

		// 聲音組
		next = FlxG.sound.load(AssetPaths.next__ogg);
		cancel = FlxG.sound.load(AssetPaths.cancel__ogg);
		check = FlxG.sound.load(AssetPaths.check__ogg);
		move = FlxG.sound.load(AssetPaths.movePointer__ogg);

		// 玩家有多少要賣掉的幣
		coinHaveText = new FlxText(880, 290, 200, "1", 72);
		coinHaveText.color = 0xff704927;
		coinHaveText.alignment = CENTER;
		coinHaveText.font = AssetPaths.silver__ttf;
		add(coinHaveText);
		coinHaveText.visible = false;

		// 玩家要放多少錢
		coinOutText = new FlxText(720, 505, 260, "1", 84);
		coinOutText.color = 0xff704927;
		coinOutText.alignment = CENTER;
		coinOutText.font = AssetPaths.silver__ttf;
		add(coinOutText);
		coinOutText.visible = false;

		// 玩家可以從機器得到多少錢
		machGainText = new FlxText(coinOutText.x, 770, 260, "1", 84);
		machGainText.color = 0xff704927;
		machGainText.alignment = CENTER;
		machGainText.font = AssetPaths.silver__ttf;
		add(machGainText);
		machGainText.visible = false;

		// 箭頭
		pointer = new Pointer();
		pointer.color = 0xffCC9709;
		add(pointer);
		pointer.visible = false;

		// 礦場海報
		minerPoster = new FlxSprite(AssetPaths.minePoster__png);
		minerPoster.screenCenter();
		add(minerPoster);
		minerPoster.visible = false;

		save = new FlxSave();
		save.bind("DefiAdv");

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

		enterCur.stopFlickering();
		enterCur.visible = false;
		textRunDone = false;
		text.resetText(dilog_boxes[i]);

		text.start(false, false, function()
		{
			// 如果不是機器介面就讓對話箭頭出現
			if (!coinOutText.visible)
			{
				enterCur.visible = true;
				enterCur.flicker(0, 0.5);
			}

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
			case "K":
				profilePic = AssetPaths.diaSbBlack__png;
			case "P1":
				profilePic = AssetPaths.diaP1__png;
			case "P2":
				profilePic = AssetPaths.diaP2__png;
			case "P3":
				profilePic = AssetPaths.diaP3__png;

			case "AC":
				profilePic = AssetPaths.diaP1ApToCoMach__png;
			case "CA":
				profilePic = AssetPaths.diaP1CoToApMach__png;
			case "BC":
				profilePic = AssetPaths.diaP1BaToCoMach__png;
			case "DC":
				profilePic = AssetPaths.diaP1DeToCoMach__png;
			case "CD":
				profilePic = AssetPaths.diaP1CoToDeMach__png;
			case "CB":
				profilePic = AssetPaths.diaP2Mach__png;
			case "LOAN":
				profilePic = AssetPaths.diaP3Mach__png;
		}

		background.loadGraphic(profilePic);
	}

	// 對話框位置
	public function diaPosition(diaUpDown)
	{
		this.diaUpDown = diaUpDown;
		// 機器介面位置要特別調
		if (coinOutText.visible)
		{
			text.visible = false;
			background.x = 0;
			background.y = 0;
		}
		// 其他的就要看上下
		else
		{
			text.visible = true;
			background.x = 255;
			if (diaUpDown == "up")
				background.y = 30;
			else if (diaUpDown == "down")
				background.y = 660;
			pointer.y = background.y + 225;
			text.y = background.y + 45;
			enterCur.y = background.y + 310;
		}
	}

	// 拿包包的參數
	public function getDiamond(diamond, diamondUiText, bananaCoin, appleCoin, rodWave, rodInvest, dexCoin)
	{
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		this.bananaCoin = bananaCoin;
		this.appleCoin = appleCoin;
		this.dexCoin = dexCoin;
		this.rodWave = rodWave;
		this.rodInvest = rodInvest;
	}

	// 存檔炫一下
	public function saveShowTime(money:Float, place)
	{
		saveShow = ':N:猩猩  ' + place + '  $money 能量幣\n存檔成功！';
	}

	// 對話大滿貫
	public function context(npcType:NPC.NpcType)
	{
		this.npcType = npcType;
		switch (npcType)
		{
			case doge:
				if (talkDone)
					name = AssetPaths.goToMiner__txt;
				else
				{
					if (leafYes)
						name = AssetPaths.missionYes__txt;
					else
						name = AssetPaths.missionNo__txt;
				}

				txt = true;

			case ming:
				if (talkMiss)
				{
					name = AssetPaths.mingTalking__txt;
					txt = true;
				}
				else
				{
					name = ":M:這裡視野真好。";
					txt = false;
				}

			case sbRed:
				if (talkMiss)
				{
					name = AssetPaths.srTalk__txt;
					txt = true;
				}
				else
				{
					name = ":SR:呼呼，今天天氣真好。";
					txt = false;
				}

			case sbBlue:
				if (talkMiss)
				{
					name = AssetPaths.sbTalk__txt;
					txt = true;
				}
				else
				{
					name = ":SB:最近島上有怪人在賣奇怪的東西呢。";
					txt = false;
				}

			case sbGreen:
				if (talkMiss)
				{
					name = AssetPaths.sgTalk__txt;
					txt = true;
				}
				else
				{
					name = ":SG:狗狗幣長得真恐怖。";
					txt = false;
				}
			case sbBlack:
				if (talkDone)
				{
					if (twentyDiamond)
						name = AssetPaths.kingTalk__txt;
					else
						name = AssetPaths.kingSellTalk__txt;
					txt = true;
				}
				else
				{
					name = ":K:去找其他島民們聊天吧！現在的你還沒有資格跟我說話。";
					txt = false;
				}
			case monument:
				name = ":N:裡面似乎有毀壞的記帳本，現已無法進入。";
				txt = false;

			case lake:
				if (lakeTalking)
				{
					name = ":L:快去冒險吧！";
					txt = false;
				}
				else
				{
					name = AssetPaths.lakeTalking__txt;
					txt = true;
					lakeTalking = true;
				}

			case saveStone:
				if (saveStoneIntro)
				{
					name = saveShow;
					txt = false;
				}
				else
				{
					name = AssetPaths.saveStoneIntro__txt;
					txt = true;
					saveStoneIntro = true;
					saveStoneYes = true;
				}
			case spartan:
				if (stoneTextYes)
				{
					name = ":S:如果還不清楚規則，那個看板上有說明可以再去確認！:S:等你準備好，就可以直接從礦場大門進入礦場了。";
					txt = false;
				}
				else
				{
					name = AssetPaths.spartanTalk__txt;
					txt = true;
					stoneTextYes = true;
				}
			case minerSign:
				minerPoster.visible = true;
				name = ":N:礦場規則";
				txt = false;
				background.visible = false;
				text.visible = false;
			case talkingBox:
				name = ":S:這是負責運送小石頭的礦車，至少要5顆小石頭它才會發動。";
				txt = false;
			case signDefi:
				name = AssetPaths.streetSign__txt;
				txt = true;
				if (!readDaSign)
					readDaSign = true;
			case signApple:
				name = AssetPaths.appleAd__txt;
				txt = true;
			case house1Sign:
				name = ":N:交易所";
				txt = false;
			case p1:
				name = ":P1:還想再聽我說一次嗎？\n  好啊\n  別了謝謝";
				txt = false;
			case mathChart:
				name = ":N:是很難的數學。";
				txt = false;
			case p1BaToCoMach:
				if (bananaCoin >= 10)
				{
					name = ':BC:香蕉幣買能量幣';
					coinHaveText.text = Std.string(bananaCoin);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的香蕉幣，至少要10香蕉幣。";
				txt = false;
			case p1ApToCoMach:
				if (appleCoin + rodWave >= 10)
				{
					name = ":AC:APS幣買能量幣";
					coinHaveText.text = Std.string(FlxMath.roundDecimal(appleCoin + rodWave, 2));
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的APS幣，至少要10APS幣。";
				txt = false;
			case p1CoToApMach:
				if (diamond >= 10)
				{
					name = ':CA:能量幣買APS幣';
					coinHaveText.text = Std.string(diamond);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case p1DeToCoMach:
				if (dexCoin >= 10)
				{
					name = ':DC:青蛙幣買能量幣';
					coinHaveText.text = Std.string(dexCoin);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的青蛙幣，至少要10青蛙幣。";
				txt = false;
			case p1CoToDeMach:
				if (diamond >= 10)
				{
					name = ':CD:能量幣買青蛙幣';
					coinHaveText.text = Std.string(diamond);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;

			case house2Sign:
				name = ":N:穩定幣鑄造所";
				txt = false;
			case p2:
				name = ":P2:想再聽一次解說嗎？\n  當然好\n  不用了";
				txt = false;
			case p2Mach:
				if (diamond >= 10)
				{
					name = ':CB:能量幣買香蕉幣';
					coinHaveText.text = Std.string(diamond);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case house3Sign:
				name = ":N:借貸所";
				txt = false;
			case p3:
				name = ":P3:要再聽一次解說嗎？\n  好呀\n  不用了謝謝";
				txt = false;

			case dexNews:
				name = AssetPaths.dexNews__txt;
				txt = true;
			case p3Mach:
				if (diamond >= 10)
				{
					name = ':LOAN:借貸';
					coinHaveText.text = Std.string(diamond);
					coinHaveText.visible = true;
					coinOutText.visible = true;
					machGainText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;

			case house4Sign:
				name = ":N:ApeStarter";
				txt = false;
			case showcase:
				name = ":N:從左至右，依序為能量幣、香蕉幣、APS幣、青蛙幣。";
				txt = false;
			case rod:
				name = AssetPaths.rodTalk__txt;
				txt = true;
		}
		show(name, txt);

		if (npcType == p1)
			getPointer("p1Talk");
		else if (npcType == p2)
			getPointer("p2Talk");
		else if (npcType == p3)
			getPointer("p3Talk");
	}

	// 呼叫箭頭
	public function getPointer(quest:String)
	{
		pointerQ = quest;
		switch (pointerQ)
		{
			case "winGame":
				pointer.setPointer(text.x, text.y + 90, 90, ["yes", "no"], "ud");
			case "p1Talk":
				pointer.setPointer(text.x, text.y + 90, 90, ["yes", "no"], "ud");
			case "p2Talk":
				pointer.setPointer(text.x, text.y + 90, 90, ["yes", "no"], "ud");
			case "p3Talk":
				pointer.setPointer(text.x, text.y + 90, 90, ["yes", "no"], "ud");
		}
	}

	// 左右選擇
	function updateLr()
	{
		var left = FlxG.keys.anyJustReleased([LEFT, A]);
		var right = FlxG.keys.anyJustReleased([RIGHT, D]);
		if (coinOutText.visible)
		{
			if (left || right)
				move.play(true);
			if (npcType == p1BaToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(bananaCoin / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(bcCoinIn - (bck / (bcBananaCoinIn + coinOut)), 2);
				coinOutText.text = Std.string(coinOut);
				machGainText.text = Std.string(machGain);
			}
			else if (npcType == p1ApToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int((appleCoin + rodWave) / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(acCoinIn - (ack / (acAppleCoinIn + coinOut)), 2);
				// FlxMath.roundDecimal(coinOut * (acCoinIn / acAppleCoinIn),2);
			}
			else if (npcType == p1CoToApMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(caAppleCoinIn - (cak / (caCoinIn + coinOut)), 2);
			}
			else if (npcType == p1CoToDeMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = coinOut * dexPrizeBuy;
			}
			else if (npcType == p1DeToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(dexCoin / 10))
					coinOut += 10;
				machGain = coinOut * dexPrizeSell;
			}
			else if (npcType == p2Mach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = coinOut * bananaPrize;
			}
			else if (npcType == p3Mach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal((loanGain + coinOut) * interest, 2);
			}
			coinOutText.text = Std.string(coinOut);
			machGainText.text = Std.string(machGain);
		}
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateEnter();
		updateSkip();
		updateLr();
		var x = FlxG.keys.anyJustReleased([X, ESCAPE]);
		var r = FlxG.keys.anyJustReleased([R]);
		var f = FlxG.keys.anyJustReleased([F]);

		// 退出機器
		if (coinOutText.visible)
		{
			if (x)
			{
				cancel.play();
				coinOut = 10;
				coinOutText.text = Std.string(coinOut);
				coinOutText.visible = false;
				machGainText.visible = false;
				coinHaveText.visible = false;
				visible = false;
				active = false;
			}
			// 全數賣掉的功能
			if (r)
			{
				text.visible = true;
				coinOutText.visible = false;
				machGainText.visible = false;
				coinHaveText.visible = false;
				check.play();
				if (npcType == p1ApToCoMach)
				{
					machGain = FlxMath.roundDecimal(acCoinIn - (ack / (acAppleCoinIn + appleCoin + rodWave)), 2);
					appleCoin = 0;
					rodWave = 0;
					rodInvest = 0;
				}
				else if (npcType == p1BaToCoMach)
				{
					machGain = FlxMath.roundDecimal(bcCoinIn - (bck / (bcBananaCoinIn + bananaCoin)), 2);
					bananaCoin = 0;
				}
				else if (npcType == p1DeToCoMach)
				{
					machGain = FlxMath.roundDecimal(dexCoin * dexPrizeSell, 2);
					dexCoin = 0;
				}
				diamond += machGain;
				name = ':N:你得到了 $machGain 能量幣。';
				txt = false;

				show(name, txt);
				diaPosition("down");

				coinOut = 10;
				coinOutText.text = Std.string(coinOut);

				updateDiamond = true;
			}
			// 退還借貸的錢
			if (f && npcType == p3Mach && loanGain > 0)
			{
				coinOutText.visible = false;
				machGainText.visible = false;
				coinHaveText.visible = false;

				diamond += loanGain;
				name = ':N:你得到了 $loanGain 能量幣。';
				txt = false;
				loanGain = 0;
				show(name, txt);
				diaPosition("down");

				updateDiamond = true;
			}
		}

		super.update(elapsed);
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		if (enter && textRunDone)
		{
			enterCur.stopFlickering();
			enterCur.visible = false;
			next.play();
			// 礦場海報消失
			if (minerPoster.visible)
			{
				new FlxTimer().start(0.5, function(timer:FlxTimer)
				{
					minerPoster.visible = false;
					background.visible = true;
					text.visible = true;
				});
			}

			// 箭頭選擇
			if (pointer.visible)
			{
				check.play();
				switch (pointerQ)
				{
					case "winGame":
						switch (pointer.selected)
						{
							case "yes":
								win = true;
								visible = false;
							case "no":
								name = ":N:等到你想離開再來這邊吧。";
								txt = false;
								show(name, txt);
						}
					case "p1Talk":
						switch (pointer.selected)
						{
							case "yes":
								name = AssetPaths.house1Talk__txt;
								txt = true;
							case "no":
								name = ":P1:好吧。";
								txt = false;
						}
						show(name, txt);
					case "p2Talk":
						switch (pointer.selected)
						{
							case "yes":
								name = AssetPaths.house2Talk__txt;
								txt = true;
							case "no":
								name = ":P2:沒問題。";
								txt = false;
						}
						show(name, txt);
					case "p3Talk":
						switch (pointer.selected)
						{
							case "yes":
								name = AssetPaths.house3Talk__txt;
								txt = true;
							case "no":
								name = ":P3:如果你想再聽一次的話可以來找我喔。";
								txt = false;
						}
						show(name, txt);
				}
				pointer.visible = false;
				pointerQ = "none";
			}
			// 機器
			else if (coinOutText.visible && coinOut > 0)
			{
				next.play();
				if (npcType == p1BaToCoMach)
				{
					name = ':N:你得到了 $machGain 能量幣。';

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

					// 算玩家的錢
					diamond += machGain;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					// 先扣槓桿的錢再扣蘋果幣的錢
					rodWave -= coinOut;
					if (rodWave < 0)
					{
						appleCoin += rodWave;
						rodWave = 0;
						rodInvest = 0;
					}
					// 算機器的錢
					acAppleCoinIn += coinOut;
					acCoinIn -= machGain;
				}
				else if (npcType == p1CoToApMach)
				{
					name = ':N:你得到了 $machGain APS幣。';

					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					appleCoin += machGain;

					caCoinIn += coinOut;
					caAppleCoinIn -= machGain;
				}
				// 青蛙幣
				else if (npcType == p1CoToDeMach)
				{
					name = ':N:你得到 $machGain 青蛙幣。';
					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					dexCoin += machGain;
				}
				else if (npcType == p1DeToCoMach)
				{
					name = ':N:你得到 $machGain 能量幣。';
					diamond += machGain;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					dexCoin -= coinOut;
				}
				// 穩定幣
				else if (npcType == p2Mach)
				{
					name = ':N:你得到 $machGain 香蕉幣。';
					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					bananaCoin += machGain;
				}
				else if (npcType == p3Mach)
				{
					name = ':N:你共投資了' + coinOut + '能量幣。';
					diamond -= coinOut;
					loanGain += coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					if (!loan)
					{
						loan = true;
					}
				}

				coinOut = 10;
				coinOutText.text = Std.string(coinOut);
				coinOutText.visible = false;
				machGainText.visible = false;
				coinHaveText.visible = false;
				updateDiamond = true;

				diaPosition("down");
				show(name, false);
			}
			// 對話換行
			else
			{
				next.play();
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
						enterCur.visible = true;
						enterCur.flicker(0, 0.5);
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
