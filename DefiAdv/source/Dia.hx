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

	var minerPoster:FlxSprite;

	var i:Int = 2;

	var profile:Int = 1;
	var profilePic:String;
	var npcType:NPC.NpcType;

	public var name:String;

	var dilog_boxes:Array<String>;
	var txt:Bool = true;

	public var textRunDone:Bool = false;

	var saveShow:String = ":N:oui";

	public var diaUpDown:String;

	var pointer:Pointer;
	var pointerQ:String = "none";

	public var saveStoneIntro:Bool = false;
	public var stoneTextYes:Bool = false;
	public var leafYes:Bool = false;
	public var talkMiss:Bool = false;
	public var talkDone:Bool = false;
	public var readDaSign:Bool = false;
	public var lakeTalking:Bool = false;
	public var saveStoneYes:Bool = false;

	public var appleCoin:Float;
	public var bananaCoin:Float;
	public var dexCoin:Float;
	public var rodWave:Float = 0;

	var coinText:FlxText;

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
	public var interest:Float = 0.01;
	public var loanGain:Float = 0;
	public var loan:Bool = false;

	public var diamond:Float;

	var diamondUiText:FlxText;

	public var updateDiamond:Bool = false;

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

		coinText = new FlxText(background.x, background.y + 60, background.width, "1", 84);
		coinText.color = FlxColor.BLACK;
		coinText.alignment = CENTER;
		coinText.font = AssetPaths.silver__ttf;
		add(coinText);
		coinText.visible = false;

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
			enterCur.visible = true;
			enterCur.flicker(0, 0.5);
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
		}

		background.loadGraphic(profilePic);
	}

	// 對話框位置
	public function diaPosition(diaUpDown)
	{
		this.diaUpDown = diaUpDown;
		if (diaUpDown == "up")
			background.y = 30;
		else
			background.y = FlxG.height - background.height - 30;
		pointer.y = background.y + 225;
		text.y = background.y + 45;
		coinText.y = background.y + 240;
		enterCur.y = background.y + 310;
	}

	// 拿包包的參數
	public function getDiamond(diamond, diamondUiText, bananaCoin, appleCoin, rodWave, dexCoin)
	{
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		this.bananaCoin = bananaCoin;
		this.appleCoin = appleCoin;
		this.dexCoin = dexCoin;
		this.rodWave = rodWave;
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
					name = AssetPaths.kingTalk__txt;
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
				name = AssetPaths.house1Talk__txt;
				txt = true;
			case mathChart:
				name = ":N:是很難的數學。";
				txt = false;
			case p1BaToCoMach:
				if (bananaCoin >= 10)
				{
					name = ':N:你想用多少香蕉幣買能量幣？你目前有 $bananaCoin 香蕉幣。按X退出，按R全數兌換。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的香蕉幣，至少要10香蕉幣。";
				txt = false;
			case p1ApToCoMach:
				if (appleCoin + rodWave >= 10)
				{
					name = ":N:你想用多少APS幣買能量幣？你目前有" + Std.string(FlxMath.roundDecimal(appleCoin + rodWave, 2)) + "APS幣。按X退出，按R全數兌換。";
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的APS幣，至少要10APS幣。";
				txt = false;
			case p1CoToApMach:
				if (diamond >= 10)
				{
					name = ':N:你想用多少能量幣買APS幣？你目前有 $diamond 能量幣。按X退出。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的能量幣，至少要10能量幣。";
				txt = false;
			case p1DeToCoMach:
				if (dexCoin >= 10)
				{
					name = ':N:你想用多少青蛙幣換成能量幣？你現在有$dexCoin 青蛙幣。按X退出，按R全數兌換。';
					coinText.visible = true;
				}
				else
					name = ":N:你沒有足夠的青蛙幣，至少要10青蛙幣。";
				txt = false;
			case p1CoToDeMach:
				if (diamond >= 10)
				{
					name = ':N:你想用多少能量幣買青蛙幣？你目前有 $diamond 能量幣。按X退出。'; // ， 1 能量幣可買 $p1Prize APS幣。';
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
					name = ':N:你想用多少能量幣買香蕉幣？ 你目前有 $diamond 能量幣。按X退出。';
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
			case dexNews:
				name = AssetPaths.dexNews__txt;
				txt = true;
			case p3Mach:
				if (diamond >= 10)
				{
					name = ':N:你想放多少能量幣借貸？ 你目前有 $diamond 能量幣。按X退出。';
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
		switch (pointerQ)
		{
			case "winGame":
				pointer.setPointer(text.x, text.y + 90, 90, ["yes", "no"], "ud");
		}
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
				machGain = FlxMath.roundDecimal(bcCoinIn - (bck / (bcBananaCoinIn + coinOut)), 2);
				coinText.text = '$coinOut  香蕉幣換 $machGain 能量幣';
			}
			else if (npcType == p1ApToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int((appleCoin + rodWave) / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(acCoinIn - (ack / (acAppleCoinIn + coinOut)), 2);
				// FlxMath.roundDecimal(coinOut * (acCoinIn / acAppleCoinIn),2);
				coinText.text = '$coinOut  APS幣換 $machGain 能量幣';
			}
			else if (npcType == p1CoToApMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = FlxMath.roundDecimal(caAppleCoinIn - (cak / (caCoinIn + coinOut)), 2);
				coinText.text = '$coinOut  能量幣換 $machGain APS幣';
			}
			else if (npcType == p1CoToDeMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = coinOut * dexPrizeBuy;
				coinText.text = '$coinOut 能量幣換 $machGain 青蛙幣';
			}
			else if (npcType == p1DeToCoMach)
			{
				if (left && coinOut != 10)
					coinOut -= 10;
				if (right && coinOut / 10 != Std.int(diamond / 10))
					coinOut += 10;
				machGain = coinOut * dexPrizeSell;
				coinText.text = '$coinOut 青蛙幣換 $machGain 能量幣';
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
				machGain = FlxMath.roundDecimal((loanGain + coinOut) * interest, 2);
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
		var x = FlxG.keys.anyJustReleased([X, ESCAPE]);
		var r = FlxG.keys.anyJustReleased([R]);

		// 退出機器
		if (coinText.visible)
		{
			if (x)
			{
				cancel.play();
				coinOut = 10;
				coinText.text = Std.string(coinOut);
				coinText.visible = false;
				visible = false;
				active = false;
			}
			// 全數賣掉的功能
			if (r)
			{
				check.play();
				if (npcType == p1ApToCoMach)
				{
					machGain = FlxMath.roundDecimal(acCoinIn - (ack / (acAppleCoinIn + appleCoin + rodWave)), 2);
					appleCoin = 0;
					rodWave = 0;
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

				coinOut = 10;
				coinText.text = Std.string(coinOut);
				coinText.visible = false;
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
				}
				pointer.visible = false;
				pointerQ = "none";
			}
			// 機器
			else if (coinText.visible)
			{
				next.play();
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
					// 先扣槓桿的錢再扣蘋果幣的錢
					rodWave -= coinOut;
					if (rodWave < 0)
					{
						appleCoin += rodWave;
						rodWave = 0;
					}
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
				// 青蛙幣
				else if (npcType == p1CoToDeMach)
				{
					name = ':N:你得到 $machGain 青蛙幣。';
					txt = false;
					show(name, txt);
					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					dexCoin += machGain;
				}
				else if (npcType == p1DeToCoMach)
				{
					name = ':N:你得到 $machGain 能量幣。';
					txt = false;
					show(name, txt);
					diamond += machGain;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					dexCoin -= coinOut;
				}
				// 穩定幣
				else if (npcType == p2Mach)
				{
					name = ':N:你得到 $machGain 香蕉幣。';
					txt = false;
					show(name, txt);
					diamond -= coinOut;
					diamondUiText.text = Std.string(FlxMath.roundDecimal(diamond, 2));
					bananaCoin += machGain;
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
