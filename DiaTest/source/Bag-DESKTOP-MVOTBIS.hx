package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

// 商店選項
enum ShopChoice
{
	main;
	buy;
	sell;
	chat;
	exit;
}

class Bag extends FlxTypedGroup<FlxBasic>
{
	public var shopUi = new FlxTypedGroup<FlxSprite>();
	public var bagUi = new FlxTypedGroup<FlxSprite>();
	public var diamondUi = new FlxTypedGroup<FlxSprite>();
	public var coinUi = new FlxTypedGroup<FlxSprite>();

	var background:FlxSprite;

	// 能量幣和香蕉葉
	public var bananaCounter:Int = 0;
	public var diamondCounter:Float = 0;
	public var diamondText:FlxText;

	var diamondIcon:FlxSprite;

	var bananaCounterText:FlxText;
	var bananaCounterIcon:FlxSprite;

	var dealText:FlxText;

	// 商店組
	var shopCho:FlxText;
	var shopText:Text;
	var mainChat:String;
	var bananaSell:Int = 0;
	var buyCho:String = "香蕉葉 2 能量幣\n離開";
	var sellCho:String = "香蕉葉 1 能量幣\n狗狗幣\n原本世界的錢\n離開";
	var chatCho:String = "為什麼要對著包包大吼大叫\n離開";

	var pointer:Pointer;

	var shopChoice(default, null):ShopChoice;
	var mainChoices:Array<String> = ["buy", "sell", "chat", "exit"];
	var buyChoices:Array<String> = ["leaf", "exit"];
	var sellChoices:Array<String> = ["leaf", "shibaCoin", "money", "exit"];
	var chatChoices:Array<String> = ["yelling", "exit"];

	// 字
	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;

	// 各種柴犬
	var sellAmoText:FlxText;
	var shibaPrizeNow:Float = 0;

	var shiba:FlxSprite;
	var shibaWaveText:FlxText;
	var shibaTimer:FlxTimer;

	public var shibaInvest:Int = 0;
	public var shibaWave:Float = 0;

	public var bananaCoin:Float = 10;

	var appleCoin:Float = 0;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite();

		// 包包組
		bagUi.add(background);

		// 香蕉圖示
		bananaCounterIcon = new FlxSprite(140, 110, AssetPaths.bananaIcon__png);
		bagUi.add(bananaCounterIcon);

		// 香蕉數目
		bananaCounterText = new FlxText(bananaCounterIcon.x + bananaCounterIcon.width, bananaCounterIcon.y + 5, "0", 20);
		bananaCounterText.color = 0xff2D5925;
		bagUi.add(bananaCounterText);

		// 交易紀錄
		dealText = new FlxText(165, 120, "目前並無交易紀錄\n", 28, true);
		dealText.color = 0xff2D5925;
		dealText.font = AssetPaths.silver__ttf;
		bagUi.add(dealText);

		add(bagUi);
		bagUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		bagUi.visible = false;

		// 商店組
		shopUi.add(background);

		// 箭頭
		pointer = new Pointer();
		pointer.color = 0xffF0433D;
		shopUi.add(pointer);

		// 商店選項
		shopCho = new FlxText(background.x + 90 + pointer.width + 10, FlxG.height / 2 + 10, "買\n賣\n聊天\n離開\n", 26, true);
		shopCho.color = 0xff2D5925;
		shopCho.font = AssetPaths.silver__ttf;
		shopUi.add(shopCho);

		// 商店的字
		shopText = new Text(background.x + 280, shopCho.y, 270, "歡迎來到我的店！", 28, true);
		shopText.color = 0xff2D5925;
		shopUi.add(shopText);

		// 賣的東西擁有量
		sellAmoText = new FlxText(background.x + 450, shopCho.y, 270, "oui", 28, true);
		sellAmoText.color = 0xff2D5925;
		sellAmoText.font = AssetPaths.silver__ttf;
		shopUi.add(sellAmoText);

		add(shopUi);
		shopUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shopUi.visible = false;

		// 買幣組
		// 狗狗幣
		shiba = new FlxSprite(320, 10).loadGraphic(AssetPaths.shibaCoin__png, true, 64, 64);
		shiba.animation.frameIndex = 0;
		coinUi.add(shiba);

		shibaWaveText = new FlxText(shiba.x + shiba.width, shiba.y, 0, "+0", 20);
		shibaWaveText.color = FlxColor.GREEN;
		coinUi.add(shibaWaveText);

		add(coinUi);
		coinUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		coinUi.visible = false;

		// 能量幣組
		diamondIcon = new FlxSprite(10, 10).loadGraphic(AssetPaths.diamondIcon__png);
		diamondUi.add(diamondIcon);

		diamondText = new FlxText(diamondIcon.x + 40, diamondIcon.y + 7, "0", 20);
		diamondText.color = 0xff2D5925;
		diamondUi.add(diamondText);

		add(diamondUi);
		diamondUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		diamondUi.visible = false;

		active = false;
	}

	// 開啟包包
	public function bagUiShow()
	{
		background.loadGraphic(AssetPaths.bagItem__png);

		dealText.visible = false;

		bagUi.visible = true;
		shopUi.visible = false;
		active = true;
	}

	// 更新包包
	public function updateBag()
	{
		bananaCounterText.text = Std.string(bananaCounter);
		diamondCounter = FlxMath.roundDecimal(diamondCounter, 2);
		diamondText.text = Std.string(diamondCounter);
		if (diamondCounter < 0)
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}

	// 狗狗幣漲跌
	public function countShibaWave()
	{
		coinUi.visible = true;
		if (shibaWave - shibaInvest >= 0)
		{
			shibaWaveText.text = "+" + Std.string(FlxMath.roundDecimal(shibaWave - shibaInvest, 2));
			shibaWaveText.color = FlxColor.GREEN;
		}
		else
		{
			shibaWaveText.text = Std.string(FlxMath.roundDecimal(shibaWave - shibaInvest, 2));
			shibaWaveText.color = FlxColor.RED;
		}
		shibaTimer = new FlxTimer().start(2, function(timer:FlxTimer)
		{
			if (FlxG.random.bool(70))
				shibaWave *= (1 + 0.01 * (FlxG.random.int(1, 50)));
			else
				shibaWave *= 0.01 * (FlxG.random.int(20, 100));
			shibaWave = FlxMath.roundDecimal(shibaWave, 2);
			if (shibaWave - shibaInvest >= 0)
			{
				shibaWaveText.text = "+" + Std.string(FlxMath.roundDecimal(shibaWave - shibaInvest, 2));
				shibaWaveText.color = FlxColor.GREEN;
			}
			else
			{
				shibaWaveText.text = Std.string(FlxMath.roundDecimal(shibaWave - shibaInvest, 2));
				shibaWaveText.color = FlxColor.RED;
			}
		}, 0);
	}

	// 更新啦
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();

		var x = FlxG.keys.anyJustReleased([X]);
		var l = FlxG.keys.anyJustReleased([LEFT]);
		var r = FlxG.keys.anyJustReleased([RIGHT]);

		// 包包功能
		if (bagUi.visible)
		{
			// 退出
			if (x)
			{
				bagUi.visible = false;
				active = false;
			}
			// 所有物品
			if (l)
			{
				background.loadGraphic(AssetPaths.bagItem__png);
				bananaCounterIcon.visible = true;
				bananaCounterText.visible = true;
				dealText.visible = false;
			}
			// 交易紀錄
			if (r)
			{
				background.loadGraphic(AssetPaths.bagDeal__png);
				bananaCounterIcon.visible = false;
				bananaCounterText.visible = false;
				dealText.visible = true;
			}
		}
	}

	// 開啟商店
	public function buyAndSell()
	{
		background.loadGraphic(AssetPaths.shopkeeper__png);

		mainChat = "歡迎來到我的店！";
		setMainShop();
		shibaPrizeNow = shibaWave;
		sellAmoText.text = Std.string(bananaCounter) + "\n" + Std.string(shibaPrizeNow);
		sellAmoText.visible = false;

		coinUi.visible = false;
		bagUi.visible = false;
		shopUi.visible = true;
		active = true;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	// 商店功能
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		// 按enter了
		if (enter && shopUi.visible && textRunDone)
		{
			// 有箭頭
			if (pointer.visible)
			{
				// 主選單
				if (shopChoice == main)
				{
					switch (pointer.selected)
					{
						// 買
						case "buy":
							shopText.resetText(buyCho);
							shopChoice = buy;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, buyChoices, "ud");

						// 賣
						case "sell":
							shopText.resetText(sellCho);
							sellAmoText.visible = true;
							shopChoice = sell;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, sellChoices, "ud");

						// 聊天
						case "chat":
							shopText.resetText(chatCho);
							shopChoice = chat;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, chatChoices, "ud");

						// 離開
						case "exit":
							FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
							{
								shopUi.visible = false;
								active = false;
								if (shibaWave != 0)
									coinUi.visible = true;
								FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
							});
					}
					shopText.start(false, false);
					shopText.skip();
					textRunDone = true;
				}

				// 開始買
				else if (shopChoice == buy)
				{
					switch (pointer.selected)
					{
						case "leaf":
							if (diamondCounter >= 2)
							{
								bananaCounter++;
								bananaSell++;
								diamondCounter -= 2;
								mainChat = "猩猩給老闆 " + bananaSell * 2 + " 個能量石！\n老闆給猩猩 " + bananaSell + " 片香蕉葉！";
								dealText.text = mainChat + "\n";
								updateBag();
								bananaSell = 0;
							}
						case "exit":
							if (bananaSell == 0)
								mainChat = "猩猩什麼都沒有買！";

							bananaCounterIcon.visible = false;
							setMainShop();
					}
				}

				// 開始賣
				else if (shopChoice == sell)
				{
					switch (pointer.selected)
					{
						case "leaf":
							if (bananaCounter > 0)
							{
								diamondCounter += bananaCounter;
								bananaSell = bananaCounter;
								bananaCounter = 0;
								sellAmoText.text = "0\n" + Std.string(shibaPrizeNow);
								updateBag();
								mainChat = "猩猩給老闆 " + bananaSell + " 片香蕉葉！\n老闆給猩猩 " + bananaSell + " 個能量石！";
								dealText.text = mainChat + "\n";
							}
						case "shibaCoin":
							if (shibaPrizeNow > 0)
							{
								diamondCounter += shibaPrizeNow;
								sellAmoText.text = Std.string(bananaCounter) + "\n0";
								updateBag();
								mainChat = "猩猩以 " + shibaInvest + " 買進狗狗幣\n以 " + shibaPrizeNow + " 賣出\n賺了"
									+ FlxMath.roundDecimal(shibaPrizeNow - shibaInvest, 2) + "能量幣！";
								shibaWave = 0;
								shibaInvest = 0;
								shibaPrizeNow = 0;
								shibaTimer.cancel();
							}
						case "money":
							name = ":嗯？抱歉，我們不幫忙丟回收紙類喔。";
							txt = false;
							shopChatStart(name, txt);
						case "exit":
							if (bananaSell == 0 && shibaPrizeNow == 0)
								mainChat = "猩猩什麼都沒有賣！";

							sellAmoText.visible = false;
							bananaSell = 0;
							setMainShop();
					}
				}

				// 開始聊天
				else if (shopChoice == chat)
				{
					switch (pointer.selected)
					{
						case "yelling":
							name = AssetPaths.shopTalk__txt;
							txt = true;
							shopChatStart(name, txt);
						case "exit":
							mainChat = "猩猩跟老闆聊天了！";
							setMainShop();
					}
				}
			}
			else
			{
				// 對話結束就離開
				if (shopText.over)
				{
					pointer.visible = true;
					if (shopChoice == chat)
					{
						shopText.resetText(chatCho);
					}
					else if (shopChoice == sell)
					{
						shopText.resetText(sellCho);
						sellAmoText.visible = true;
					}
					shopText.start(false, false);
					shopText.skip();
					textRunDone = true;
				}
			}
		}
	}

	// 準備商店主選單
	function setMainShop()
	{
		textRunDone = false;
		shopText.resetText(mainChat);
		shopText.start(false, false, function()
		{
			textRunDone = true;
		});
		pointer.setPointer(background.x + 95, shopCho.y, 30, mainChoices, "ud");
		shopChoice = main;
	}

	// 聊天準備事項
	function shopChatStart(name, txt)
	{
		pointer.visible = false;
		sellAmoText.visible = false;
		bananaCounterIcon.visible = false;
		shopText.show(name, txt);
	}
}
