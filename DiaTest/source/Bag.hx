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

	public var shibaUi = new FlxTypedGroup<FlxSprite>();
	public var nftUi = new FlxTypedGroup<FlxSprite>();

	var shibaNotifUi = new FlxTypedGroup<FlxSprite>();
	var nftNotifUi = new FlxTypedGroup<FlxSprite>();

	var background:FlxSprite;

	// 能量幣和香蕉葉
	public var bananaCounter:Int = 0;
	public var diamondCounter:Float = 200;
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
	var sellCho:String = "香蕉葉 1 能量幣\n狗狗幣\nnft\n原本世界的錢\n離開";
	var chatCho:String = "為什麼要對著包包大吼大叫\n請問有分店嗎\n離開";

	var pointer:Pointer;

	var shopChoice(default, null):ShopChoice;
	var mainChoices:Array<String> = ["buy", "sell", "chat", "exit"];
	var buyChoices:Array<String> = ["leaf", "exit"];
	var sellChoices:Array<String> = ["leaf", "shibaCoin", "nft", "money", "exit"];
	var chatChoices:Array<String> = ["yelling", "branch", "exit"];

	// 字
	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;

	var sellAmoText:FlxText;

	// 各種柴犬
	var shibaPrizeNow:Float = 0; // 進商店時狗狗幣價值多少

	var shiba:FlxSprite;
	var shibaWaveText:FlxText;
	var shibaTimer:FlxTimer; // 計時器

	public var firstShiba:Bool = false; // 第一隻狗狗幣才會跳通知
	public var shibaInvest:Int = 0; // 花多少買狗狗幣
	public var shibaWave:Float = 0; // 狗狗幣漲跌

	// nft
	var nftPrizeNow:Float = 0; // 進商店時nft價值多少

	var nft:FlxSprite;
	var nftWaveText:FlxText;
	var nftTimer:FlxTimer; // 計時器
	var firstNft:Bool = false; // 第一隻nft才會跳通知

	public var nftInvest:Int = 0; // 花多少買nft
	public var nftWave:Float = 0; // nft漲跌

	// 狗狗幣通知
	var shibaNotif:FlxSprite;
	var shibaNotifText:FlxText;
	var shibaNotifTimer:FlxTimer;

	// nft通知
	var nftNotif:FlxSprite;
	var nftNotifText:FlxText;
	var nftNotifTimer:FlxTimer;

	// 香蕉幣
	var bananaCoinIcon:FlxSprite;

	public var bananaCoinText:FlxText;
	public var bananaCoin:Float = 0;

	// APS幣
	var appleCoinIcon:FlxSprite;

	public var appleCoinText:FlxText;
	public var appleCoin:Float = 0;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite();

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

		// 能量幣組
		diamondIcon = new FlxSprite(10, 10).loadGraphic(AssetPaths.diamondIcon__png);
		diamondUi.add(diamondIcon);

		diamondText = new FlxText(diamondIcon.x + 45, diamondIcon.y + diamondIcon.height / 2 - 13, "200", 20);
		diamondText.color = 0xff2D5925;
		diamondUi.add(diamondText);

		add(diamondUi);
		diamondUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		diamondUi.visible = false;

		// 買幣組
		// 狗狗幣
		shiba = new FlxSprite(diamondIcon.x, diamondIcon.y + diamondIcon.height + 10, AssetPaths.shibaCoinIcon__png);
		shibaUi.add(shiba);

		shibaWaveText = new FlxText(diamondText.x, shiba.y + shiba.height / 2 - 11, 0, "+0", 16);
		shibaWaveText.color = FlxColor.GREEN;
		shibaUi.add(shibaWaveText);

		add(shibaUi);
		shibaUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shibaUi.visible = false;

		// nft
		nft = new FlxSprite(diamondIcon.x, shiba.y + shiba.height + 10, AssetPaths.nftIcon__png);
		nftUi.add(nft);

		nftWaveText = new FlxText(diamondText.x, nft.y + nft.height / 2 - 11, 0, "+0", 16);
		nftWaveText.color = FlxColor.GREEN;
		nftUi.add(nftWaveText);

		add(nftUi);
		nftUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		nftUi.visible = false;

		// 狗狗幣通知
		shibaNotif = new FlxSprite(300, 10).makeGraphic(40, 40, FlxColor.RED);
		shibaNotifUi.add(shibaNotif);

		shibaNotifText = new FlxText(shibaNotif.x, shibaNotif.y, "oui", 28);
		shibaNotifText.color = 0xff2D5925;
		shibaNotifText.font = AssetPaths.silver__ttf;
		shibaNotifUi.add(shibaNotifText);

		add(shibaNotifUi);
		shibaNotifUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shibaNotifUi.visible = false;

		// nft通知
		nftNotif = new FlxSprite(shibaNotif.x, shibaNotif.y + shibaNotif.height + 10).makeGraphic(40, 40, FlxColor.WHITE);
		nftNotifUi.add(nftNotif);

		nftNotifText = new FlxText(nftNotif.x, nftNotif.y, "oui", 28);
		nftNotifText.color = 0xff2D5925;
		nftNotifText.font = AssetPaths.silver__ttf;
		nftNotifUi.add(nftNotifText);

		add(nftNotifUi);
		nftNotifUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		nftNotifUi.visible = false;

		// 包包組
		bagUi.add(background);

		// 香蕉圖示
		bananaCounterIcon = new FlxSprite(168, 100, AssetPaths.bananaIcon__png);
		bagUi.add(bananaCounterIcon);

		// 香蕉數目
		bananaCounterText = new FlxText(bananaCounterIcon.x - 30, bananaCounterIcon.y + bananaCounterIcon.height, 106, "0", 16);
		bananaCounterText.color = 0xff2D5925;
		bananaCounterText.alignment = CENTER;
		bagUi.add(bananaCounterText);

		// 香蕉幣
		bananaCoinIcon = new FlxSprite(298, 100, AssetPaths.bananaCoinIcon__png);
		bagUi.add(bananaCoinIcon);

		bananaCoinText = new FlxText(bananaCoinIcon.x - 30, bananaCoinIcon.y + bananaCoinIcon.height, 106, "0", 16);
		bananaCoinText.color = 0xff2D5925;
		bananaCoinText.alignment = CENTER;
		bagUi.add(bananaCoinText);

		// APS幣
		appleCoinIcon = new FlxSprite(428, 100, AssetPaths.appleCoinIcon__png);
		bagUi.add(appleCoinIcon);

		appleCoinText = new FlxText(appleCoinIcon.x - 30, appleCoinIcon.y + appleCoinIcon.height, 106, "0", 16);
		appleCoinText.color = 0xff2D5925;
		appleCoinText.alignment = CENTER;
		bagUi.add(appleCoinText);

		// 交易紀錄
		dealText = new FlxText(165, 120, "目前並無交易紀錄\n", 28, true);
		dealText.color = 0xff2D5925;
		dealText.font = AssetPaths.silver__ttf;
		bagUi.add(dealText);

		add(bagUi);
		bagUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		bagUi.visible = false;

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
		bananaCoinText.text = Std.string(FlxMath.roundDecimal(bananaCoin, 2));
		appleCoinText.text = Std.string(FlxMath.roundDecimal(appleCoin, 2));
		if (diamondCounter < 0)
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}

	// 狗狗幣漲跌
	// 這個程式只會被呼叫一次，但漲跌計時器會不斷跑
	public function countShibaWave()
	{
		shibaUi.visible = true;
		redOrGreen(shibaWave, shibaInvest, shibaWaveText);

		// 漲跌計時器
		shibaTimer = new FlxTimer().start(2, function(timer:FlxTimer)
		{
			// 在第一則新聞的影響範圍內就跌
			if (shibaNotifText.text == "中國宣布禁止所有與加密貨幣相關的活動！")
				if (shibaWave - shibaInvest >= 0.01)
					shibaWave *= 0.01 * (FlxG.random.int(20, 100));
				else
					shibaWave = 0.01;
			// 在第二則新聞的影響範圍內就漲
			else if (shibaNotifText.text == "馬斯克宣布特斯拉商品接受狗狗幣！")
			{
				shibaWave *= (1 + 0.01 * (FlxG.random.int(1, 70)));
			}

			// 其他時間隨機
			else
			{
				// 70%機率漲
				if (FlxG.random.bool(70))
					shibaWave *= (1 + 0.01 * (FlxG.random.int(1, 50)));
				// 30%機率跌
				else
				{
					if (shibaWave - shibaInvest >= 0.01)
						shibaWave *= 0.01 * (FlxG.random.int(20, 100));
					// 防止跌到底
					else
						shibaWave = shibaInvest / 4;
				}
			}
			shibaWave = FlxMath.roundDecimal(shibaWave, 2);

			redOrGreen(shibaWave, shibaInvest, shibaWaveText);
		}, 0);

		// 第一次買狗狗幣才會跳通知
		if (!firstShiba)
		{
			firstShiba = true;
			// 5秒後第一則快訊出現，維持10秒
			shibaNotifTimer = new FlxTimer().start(5, function(timer:FlxTimer)
			{
				shibaNotifUi.visible = true;
				shibaNotifText.text = "中國宣布禁止所有與加密貨幣相關的活動！";
				shibaNotifTimer = new FlxTimer().start(10, function(timer:FlxTimer)
				{
					shibaNotifUi.visible = false;
					shibaNotifText.text = "oui";
					// 5秒後第二則快訊出現，維持10秒
					shibaNotifTimer = new FlxTimer().start(5, function(timer:FlxTimer)
					{
						shibaNotifUi.visible = true;
						shibaWave = shibaInvest;
						shibaNotifText.text = "馬斯克宣布特斯拉商品接受狗狗幣！";
						shibaNotifTimer = new FlxTimer().start(10, function(timer:FlxTimer)
						{
							shibaNotifUi.visible = false;
							shibaNotifText.text = "oui";
						});
					});
				});
			});
		}
	}

	// nft漲跌
	public function countNftWave()
	{
		nftUi.visible = true;
		redOrGreen(nftWave, nftInvest, nftWaveText);

		// 漲跌計時器
		nftTimer = new FlxTimer().start(2, function(timer:FlxTimer)
		{
			// 在第一則新聞的影響範圍內就跌
			if (nftNotifText.text == "nft跌！")
				if (nftWave - nftInvest >= 0.01)
					nftWave *= 0.01 * (FlxG.random.int(20, 100));
				else
					nftWave = 0.01;
			// 在第二則新聞的影響範圍內就漲
			else if (nftNotifText.text == "nft漲！")
			{
				nftWave *= (1 + 0.01 * (FlxG.random.int(1, 70)));
			}

			// 其他時間隨機
			else
			{
				// 70%機率漲
				if (FlxG.random.bool(70))
					nftWave *= (1 + 0.01 * (FlxG.random.int(1, 50)));
				// 30%機率跌
				else
				{
					if (nftWave - nftInvest > 0.01)
						nftWave *= 0.01 * (FlxG.random.int(20, 100));
					// 防止跌到底
					else
						nftWave = nftInvest / 4;
				}
			}
			nftWave = FlxMath.roundDecimal(nftWave, 2);
			redOrGreen(nftWave, nftInvest, nftWaveText);
		}, 0);

		// 第一次買nft才會跳通知
		if (!firstNft)
		{
			firstNft = true;
			// 5秒後第一則快訊出現，維持10秒
			nftNotifTimer = new FlxTimer().start(5, function(timer:FlxTimer)
			{
				nftNotifUi.visible = true;
				nftNotifText.text = "nft跌！";
				nftNotifTimer = new FlxTimer().start(10, function(timer:FlxTimer)
				{
					nftNotifUi.visible = false;
					nftNotifText.text = "oui";
					// 5秒後第二則快訊出現，維持10秒
					nftNotifTimer = new FlxTimer().start(5, function(timer:FlxTimer)
					{
						nftNotifUi.visible = true;
						nftWave = nftInvest;
						nftNotifText.text = "nft漲！";
						nftNotifTimer = new FlxTimer().start(10, function(timer:FlxTimer)
						{
							nftNotifUi.visible = false;
							nftNotifText.text = "oui";
						});
					});
				});
			});
		}
	}

	// 幫你判斷顯示什麼顏色的程式lol如果漲字就變綠色；跌字就變紅色
	function redOrGreen(wave:Float, invest, waveText:FlxText)
	{
		if (wave - invest >= 0)
		{
			waveText.text = "+" + Std.string(FlxMath.roundDecimal(wave - invest, 2));
			waveText.color = FlxColor.GREEN;
		}
		else
		{
			waveText.text = Std.string(FlxMath.roundDecimal(wave - invest, 2));
			waveText.color = FlxColor.RED;
		}
	}

	// 更新啦
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();

		var x = FlxG.keys.anyJustReleased([X]);
		var l = FlxG.keys.anyJustReleased([LEFT]);
		var r = FlxG.keys.anyJustReleased([RIGHT]);

		// diamondText.text = Std.string(shopText.over);

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
				bananaCoinIcon.visible = true;
				bananaCoinText.visible = true;
				appleCoinIcon.visible = true;
				appleCoinText.visible = true;
				dealText.visible = false;
			}
			// 交易紀錄
			if (r)
			{
				background.loadGraphic(AssetPaths.bagDeal__png);
				bananaCounterIcon.visible = false;
				bananaCounterText.visible = false;
				bananaCoinIcon.visible = false;
				bananaCoinText.visible = false;
				appleCoinIcon.visible = false;
				appleCoinText.visible = false;
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
		nftPrizeNow = nftWave;
		sellAmoText.text = Std.string(bananaCounter) + "\n" + Std.string(shibaPrizeNow) + "\n" + Std.string(nftPrizeNow);
		sellAmoText.visible = false;

		shibaUi.visible = false;
		nftUi.visible = false;
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
		if (enter && shopUi.visible)
		{
			// 有箭頭
			if (pointer.visible && textRunDone)
			{
				// 主選單
				if (shopChoice == main)
				{
					background.loadGraphic(AssetPaths.shopkeeper__png);
					switch (pointer.selected)
					{
						// 買
						case "buy":
							shopText.resetText(buyCho);
							shopChoice = buy;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, buyChoices, "ud");
							mainChat = "猩猩什麼都沒有買！";
						// 賣
						case "sell":
							shopText.resetText(sellCho);
							sellAmoText.visible = true;
							shopChoice = sell;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, sellChoices, "ud");
							mainChat = "猩猩什麼都沒有賣！";
						// 聊天
						case "chat":
							shopText.resetText(chatCho);
							shopChoice = chat;
							pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, chatChoices, "ud");
							mainChat = "猩猩什麼也沒說！";
						// 離開
						case "exit":
							FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
							{
								shopUi.visible = false;
								active = false;
								if (shibaInvest != 0)
									shibaUi.visible = true;
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
								sellAmoText.text = "0\n" + Std.string(shibaPrizeNow) + "\n" + Std.string(nftPrizeNow);
								updateBag();
								mainChat = "猩猩給老闆 " + bananaSell + " 片香蕉葉！\n老闆給猩猩 " + bananaSell + " 個能量石！";
								dealText.text = mainChat + "\n";
							}
						case "shibaCoin":
							if (shibaPrizeNow > 0)
							{
								diamondCounter += shibaPrizeNow;
								sellAmoText.text = Std.string(bananaCounter) + "\n0\n" + Std.string(nftPrizeNow);
								updateBag();
								mainChat = "猩猩以 " + shibaInvest + " 買進狗狗幣\n以 " + shibaPrizeNow + " 賣出\n賺了"
									+ FlxMath.roundDecimal(shibaPrizeNow - shibaInvest, 2) + "能量幣！\n";
								shibaWave = 0;
								shibaInvest = 0;
								shibaPrizeNow = 0;
								shibaTimer.cancel();
								if (shibaNotifTimer.active)
									shibaNotifTimer.cancel();
								shibaNotifUi.visible = false;
								shibaWaveText.text = "+0";
								shibaNotifText.text = "oui";
								shibaWaveText.color = FlxColor.GREEN;
							}
						case "nft":
							if (nftPrizeNow > 0)
							{
								diamondCounter += nftPrizeNow;
								sellAmoText.text = Std.string(bananaCounter) + "\n" + Std.string(shibaPrizeNow) + "\n0";
								updateBag();
								mainChat = "猩猩以 " + nftInvest + " 買進nft\n以 " + nftPrizeNow + " 賣出\n賺了" + FlxMath.roundDecimal(nftPrizeNow - nftInvest, 2)
									+ "能量幣！\n";
								nftWave = 0;
								nftInvest = 0;
								nftPrizeNow = 0;
								nftTimer.cancel();
								if (nftNotifTimer.active)
									nftNotifTimer.cancel();
								nftNotifUi.visible = false;
								nftWaveText.text = "+0";
								nftNotifText.text = "oui";
								nftWaveText.color = FlxColor.GREEN;
							}
						case "money":
							name = ":嗯？抱歉，我們不幫忙丟回收紙類喔。";
							txt = false;
							shopChatStart(name, txt);
						case "exit":
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
							name = AssetPaths.shopYellingTalk__txt;
							txt = true;
							background.loadGraphic(AssetPaths.shopkeeperTalk__png);
							shopChatStart(name, txt);
						case "branch":
							name = AssetPaths.shopBranchTalk__txt;
							txt = true;
							shopChatStart(name, txt);
							background.loadGraphic(AssetPaths.shopkeeperSmile__png);
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
		background.loadGraphic(AssetPaths.shopkeeperTalk__png);
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
		shopText.show(name, txt);
	}
}
