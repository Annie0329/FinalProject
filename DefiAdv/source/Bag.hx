package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

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
	public var itemUi = new FlxTypedGroup<FlxSprite>();
	public var dealUi = new FlxTypedGroup<FlxSprite>();
	public var diamondUi = new FlxTypedGroup<FlxSprite>();

	public var shibaUi = new FlxTypedGroup<FlxSprite>();
	public var nftUi = new FlxTypedGroup<FlxSprite>();
	public var rodUi = new FlxTypedGroup<FlxSprite>();

	var shibaNotifUi = new FlxTypedGroup<FlxSprite>();
	var nftNotifUi = new FlxTypedGroup<FlxSprite>();

	var background:FlxSprite;

	// 聲音組
	var check:FlxSound;
	var move:FlxSound;
	var cancel:FlxSound;

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
	var buyCho:String = "香蕉葉 1 能量幣\n離開";
	var sellCho:String = "香蕉葉 1 能量幣\n狗狗幣\nNFT\n新臺幣\n離開";
	var chatCho:String = "為什麼要對錢包大吼大叫\n請問有分店嗎\n我忘記該怎麼操控遊戲了\n離開";

	var pointer:Pointer;

	var shopChoice(default, null):ShopChoice;
	var mainChoices:Array<String> = ["buy", "sell", "chat", "exit"];
	var buyChoices:Array<String> = ["leaf", "exit"];
	var sellChoices:Array<String> = ["leaf", "shibaCoin", "nft", "money", "exit"];
	var chatChoices:Array<String> = ["yelling", "branch", "gameGuide", "exit"];

	// 字
	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;
	var enterCur:FlxSprite;

	var sellAmoText:FlxText;

	// 各種狗狗幣
	var shibaPrizeNow:Float = 0; // 進商店時狗狗幣價值多少

	var shiba:FlxSprite;
	var shibaWaveText:FlxText;
	var shibaTimer:FlxTimer; // 計時器

	public var firstShiba:Bool = false; // 第一隻狗狗幣才會跳通知
	public var shibaInvest:Int = 0; // 花多少買狗狗幣
	public var shibaWave:Float = 0; // 狗狗幣漲跌

	// nft
	var nftPrizeNow:Float = 0; // 進商店時nft價值多少

	public var nft:FlxSprite;

	var nftWaveText:FlxText;
	var nftTimer:FlxTimer; // 計時器

	public var firstNft:Bool = false; // 第一隻nft才會跳通知
	public var nftInvest:Int = 0; // 花多少買nft
	public var nftWave:Float = 0; // nft漲跌

	// 各種槓桿
	var rodPrizeNow:Float = 0; // 進商店時槓桿價值多少

	var rod:FlxSprite;
	var rodWaveText:FlxText;

	public var rodTimer:FlxTimer; // 計時器

	public var rodInvest:Int = 0; // 花多少買槓桿
	public var rodWave:Float = 0; // 槓桿漲跌
	public var rodWaveAdd:Float = 0; // 賺多少，加到蘋果幣上
	public var rodNum:Int = 0; // 幾倍槓桿

	// 通知計時器
	var notifTimer:FlxTimer;

	// 狗狗幣通知
	var shibaNotif:FlxSprite;
	var shibaNewsDown:String = "中國宣布禁止所有與加密貨幣相關的活動！";
	var shibaNewsUp:String = "馬斯克宣布特斯拉商品接受狗狗幣！";

	public var shibaNotifText:FlxText;

	var shibaNotifTimer:FlxTimer;

	// nft通知
	var nftNotif:FlxSprite;
	var nftNewsDown:String = "大明星美蛙賣掉了他的猩猩NFT！";
	var nftNewsUp:String = "小賈斯汀花129萬美元買猩猩NFT！";

	public var nftNotifText:FlxText;

	var nftNotifTimer:FlxTimer;

	// 香蕉幣
	var bananaCoinIcon:FlxSprite;

	public var bananaCoinText:FlxText;
	public var bananaCoin:Float = 0;

	// APS幣
	var appleCoinIcon:FlxSprite;

	public var appleCoinText:FlxText;
	public var appleCoin:Float = 0;

	// 空投幣(青蛙幣)
	var dexCoinIcon:FlxSprite;

	public var dexCoinText:FlxText;
	public var dexCoin:Float = 0;

	var ufo:FlxText;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite();

		// 聲音組
		check = FlxG.sound.load(AssetPaths.check__mp3);
		move = FlxG.sound.load(AssetPaths.movePointer__mp3);
		cancel = FlxG.sound.load(AssetPaths.cancel__mp3);

		// 商店組
		shopUi.add(background);

		// 箭頭
		pointer = new Pointer();
		pointer.color = 0xffF0433D;
		shopUi.add(pointer);

		// 商店選項
		shopCho = new FlxText(background.x + 270 + pointer.width + 30, FlxG.height / 2 + 30, 0, "買\n賣\n聊天\n離開\n", 78, true);
		shopCho.color = 0xff2D5925;
		shopCho.font = AssetPaths.silver__ttf;
		shopUi.add(shopCho);

		// 商店的字
		shopText = new Text(background.x + 840, shopCho.y, 810, "歡迎來到我的店！", 84, true);
		shopText.color = 0xff2D5925;
		shopUi.add(shopText);

		// 賣的東西擁有量
		sellAmoText = new FlxText(background.x + 1350, shopCho.y, 810, "oui", 84, true);
		sellAmoText.color = 0xff2D5925;
		sellAmoText.font = AssetPaths.silver__ttf;
		shopUi.add(sellAmoText);

		// 指示你可以跳行的箭頭
		enterCur = new FlxSprite(shopText.x + shopText.width - 60, shopText.y + 360, AssetPaths.pointer__png);
		enterCur.color = 0xff2D5925;
		shopUi.add(enterCur);
		enterCur.visible = false;

		add(shopUi);
		shopUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shopUi.visible = false;

		// 能量幣組
		diamondIcon = new FlxSprite(21, 21).loadGraphic(AssetPaths.diamondIcon__png);
		diamondUi.add(diamondIcon);

		diamondText = new FlxText(diamondIcon.x + 100, diamondIcon.y + diamondIcon.height / 2 - 30, 0, "0", 54);
		diamondText.color = 0xff2D5925;
		diamondUi.add(diamondText);

		add(diamondUi);
		diamondUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		diamondUi.visible = false;

		// 買幣組
		// 狗狗幣
		shiba = new FlxSprite(diamondIcon.x + diamondIcon.width + 30, 15, AssetPaths.shibaCoinIcon__png);
		shibaUi.add(shiba);

		shibaWaveText = new FlxText(shiba.x + 120, shiba.y + shiba.height / 2 - 33, 0, "+0", 44);
		shibaWaveText.color = FlxColor.GREEN;
		shibaUi.add(shibaWaveText);

		add(shibaUi);
		shibaUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shibaUi.visible = false;

		// 狗狗幣通知
		shibaNotif = new FlxSprite(shiba.x + shiba.width + 30, 21).loadGraphic(AssetPaths.notfi__png);
		shibaNotifUi.add(shibaNotif);

		shibaNotifText = new FlxText(shibaNotif.x + 100, shibaNotif.y + 15, 0, "oui", 84);
		shibaNotifText.color = 0xff933D3D;
		shibaNotifText.font = AssetPaths.silver__ttf;
		shibaNotifUi.add(shibaNotifText);

		add(shibaNotifUi);
		shibaNotifUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shibaNotifUi.visible = false;
		// nft
		nft = new FlxSprite(shiba.x, shiba.y + shiba.height + 6).loadGraphic(AssetPaths.nftIcon__png, true, 308, 108);
		nft.animation.frameIndex = 0;
		nftUi.add(nft);

		nftWaveText = new FlxText(nft.x + 120, nft.y + nft.height / 2 - 33, 0, "+0", 44);
		nftWaveText.color = FlxColor.GREEN;
		nftUi.add(nftWaveText);

		add(nftUi);
		nftUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		nftUi.visible = false;

		// nft通知
		nftNotif = new FlxSprite(shibaNotif.x, shibaNotif.y + shibaNotif.height + 24).loadGraphic(AssetPaths.notfi__png);
		nftNotifUi.add(nftNotif);

		nftNotifText = new FlxText(nftNotif.x + 100, nftNotif.y + 15, 0, "oui", 84);
		nftNotifText.color = 0xff933D3D;
		nftNotifText.font = AssetPaths.silver__ttf;
		nftNotifUi.add(nftNotifText);

		add(nftNotifUi);
		nftNotifUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		nftNotifUi.visible = false;

		// 槓桿
		rod = new FlxSprite(nft.x, nft.y + nft.height + 6).loadGraphic(AssetPaths.rodIcon__png);
		rodUi.add(rod);

		rodWaveText = new FlxText(rod.x + 120, rod.y + rod.height / 2 - 33, 0, "+0", 44);
		rodWaveText.color = FlxColor.GREEN;
		rodUi.add(rodWaveText);

		add(rodUi);
		rodUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		rodUi.visible = false;

		// 包包組
		itemUi.add(background);

		// 香蕉
		bananaCounterIcon = new FlxSprite(504, 300, AssetPaths.bananaIcon__png);
		itemUi.add(bananaCounterIcon);

		bananaCounterText = new FlxText(bananaCounterIcon.x - 90, bananaCounterIcon.y + bananaCounterIcon.height, 328, "0", 48);
		bananaCounterText.color = 0xff2D5925;
		bananaCounterText.alignment = CENTER;
		itemUi.add(bananaCounterText);

		// 香蕉幣
		bananaCoinIcon = new FlxSprite(885, bananaCounterIcon.y, AssetPaths.bananaCoinIcon__png);
		itemUi.add(bananaCoinIcon);

		bananaCoinText = new FlxText(bananaCoinIcon.x - 90, bananaCoinIcon.y + bananaCoinIcon.height, 318, "0", 48);
		bananaCoinText.color = 0xff2D5925;
		bananaCoinText.alignment = CENTER;
		itemUi.add(bananaCoinText);

		// APS幣
		appleCoinIcon = new FlxSprite(1284, bananaCounterIcon.y, AssetPaths.appleCoinIcon__png);
		itemUi.add(appleCoinIcon);

		appleCoinText = new FlxText(appleCoinIcon.x - 90, appleCoinIcon.y + appleCoinIcon.height, 318, "0", 48);
		appleCoinText.color = 0xff2D5925;
		appleCoinText.alignment = CENTER;
		itemUi.add(appleCoinText);

		// 空投幣
		dexCoinIcon = new FlxSprite(bananaCounterIcon.x, 550, AssetPaths.dexCoinIcon__png);
		itemUi.add(dexCoinIcon);

		dexCoinText = new FlxText(dexCoinIcon.x - 90, dexCoinIcon.y + dexCoinIcon.height, 318, "0", 48);
		dexCoinText.color = 0xff2D5925;
		dexCoinText.alignment = CENTER;
		itemUi.add(dexCoinText);

		add(itemUi);
		itemUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		itemUi.visible = false;

		// 交易紀錄
		dealUi.add(background);
		dealText = new FlxText(495, 360, 0, "目前並無交易紀錄\n", 84, true);
		dealText.color = 0xff2D5925;
		dealText.font = AssetPaths.silver__ttf;
		dealUi.add(dealText);

		add(dealUi);
		dealUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		dealUi.visible = false;

		// 除錯ufo
		ufo = new FlxText(0, 0, 600, "ufo", 60);
		ufo.scrollFactor.set(0, 0);
		add(ufo);
		ufo.visible = false;

		active = false;
	}

	// 開啟包包
	public function bagUiShow()
	{
		background.loadGraphic(AssetPaths.bagItem__png);

		dealUi.visible = false;

		itemUi.visible = true;
		shopUi.visible = false;
		bananaCounterIcon.visible = true;
		active = true;
	}

	// 更新包包
	public function updateBag()
	{
		bananaCounterText.text = Std.string(bananaCounter);

		diamondCounter = FlxMath.roundDecimal(diamondCounter, 2);
		diamondText.text = Std.string(diamondCounter);

		bananaCoin = FlxMath.roundDecimal(bananaCoin, 2);
		bananaCoinText.text = Std.string(bananaCoin);

		appleCoin = FlxMath.roundDecimal(appleCoin, 2);
		appleCoinText.text = Std.string(appleCoin + rodWave);

		dexCoin = FlxMath.roundDecimal(dexCoin, 2);
		dexCoinText.text = Std.string(dexCoin);
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
			countWave("shiba", shibaNotifText, shibaWave, shibaWaveText, shibaInvest, shibaNewsDown, shibaNewsUp);
		}, 0);

		// 第一次買狗狗幣才會跳通知
		if (!firstShiba)
		{
			firstShiba = true;
			notification(shibaNotifUi, shibaNotifText, shibaNewsDown, shibaNewsUp);
		}
	}

	// nft漲跌
	public function countNftWave(style)
	{
		nft.animation.frameIndex = style;
		nftUi.visible = true;
		redOrGreen(nftWave, nftInvest, nftWaveText);

		// nft漲跌計時器
		nftTimer = new FlxTimer().start(2, function(timer:FlxTimer)
		{
			countWave("nft", nftNotifText, nftWave, nftWaveText, nftInvest, nftNewsDown, nftNewsUp);
		}, 0);

		// 第一次買nft才會跳通知
		if (!firstNft)
		{
			firstNft = true;
			notification(nftNotifUi, nftNotifText, nftNewsDown, nftNewsUp);
		}
	}

	// 槓桿漲跌
	public function countRodWave()
	{
		rodUi.visible = true;
		redOrGreen(rodWave, rodInvest, rodWaveText);

		// 槓桿漲跌計時器
		rodTimer = new FlxTimer().start(2, function(timer:FlxTimer)
		{
			rodWave = FlxMath.roundDecimal(rodWave, 2);
			// 70%機率漲
			if (FlxG.random.bool(70))
				rodWave *= (1 + 0.01 * (FlxG.random.int(20, 100)));
			// 30%機率跌
			else
			{
				if (rodWave - rodInvest >= 0.01)
					rodWave *= 0.01 * (FlxG.random.int(20, 50));
				// 防止跌到底
				else
					rodWave = rodInvest / 4;
			}
			// 開槓桿開爆了
			if (rodWave / rodInvest < 1 / rodNum)
			{
				rod.flicker();
				rodWaveText.flicker(function(FlxFlicker)
				{
					rodUi.visible = false;
					rodWave = 0;
					rodInvest = 0;
					appleCoinText.text = Std.string(appleCoin);
					rodTimer.cancel();
				});
			}
			// ufo.visible = true;
			ufo.text = Std.string(rodInvest);
			appleCoinText.text = Std.string(FlxMath.roundDecimal(appleCoin + rodWave, 2));

			redOrGreen(rodWave, rodInvest, rodWaveText);
		}, 0);
	}

	// 幣漲跌
	function countWave(enemy, notifText, wave:Float, waveText, invest:Int, newsDown, newsUp)
	{
		// 在第一則新聞的影響範圍內就跌
		if (notifText.text == newsDown)
			if (wave - invest >= 0.01)
				wave *= 0.01 * (FlxG.random.int(20, 100));
			else
				wave = 0.01;
		// 在第二則新聞的影響範圍內就漲
		else if (notifText.text == newsUp)
		{
			if (wave - invest < 0)
				wave = invest * 2;
			else
				wave *= (1 + 0.01 * (FlxG.random.int(20, 100)));
		}

		// 其他時間隨機
		else
		{
			// 70%機率漲
			if (FlxG.random.bool(70))
				wave *= (1 + 0.01 * (FlxG.random.int(1, 50)));
			// 30%機率跌
			else
			{
				if (wave - invest >= 0.01)
					wave *= 0.01 * (FlxG.random.int(20, 100));
				// 防止跌到底
				else
					wave = invest / 4;
			}
		}
		if (enemy == "shiba")
			shibaWave = FlxMath.roundDecimal(wave, 2);
		else if (enemy == "nft")
			nftWave = FlxMath.roundDecimal(wave, 2);

		redOrGreen(wave, invest, waveText);
	}

	// 新聞通知
	function notification(notifUi:FlxTypedGroup<FlxSprite>, notifText:FlxText, newsDown, newsUp)
	{
		// 5秒後第一則快訊出現，維持10秒
		notifTimer = new FlxTimer().start(5, function(timer:FlxTimer)
		{
			notifUi.visible = true;
			notifText.text = newsDown;

			timer = new FlxTimer().start(10, function(timer:FlxTimer)
			{
				notifUi.visible = false;
				notifText.text = "oui";
				// 5秒後第二則快訊出現，維持10秒
				timer = new FlxTimer().start(5, function(timer:FlxTimer)
				{
					notifUi.visible = true;
					notifText.text = newsUp;
					timer = new FlxTimer().start(10, function(timer:FlxTimer)
					{
						notifUi.visible = false;
						notifText.text = "done";
					});
				});
			});
		});
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
		var x = FlxG.keys.anyJustReleased([X, ESCAPE]);
		var l = FlxG.keys.anyJustReleased([LEFT]);
		var r = FlxG.keys.anyJustReleased([RIGHT]);

		// 包包功能
		if (itemUi.visible || dealUi.visible)
		{
			// 退出
			if (x)
			{
				cancel.play();
				itemUi.visible = false;
				dealUi.visible = false;
				active = false;
			}
			// 所有物品
			if (l)
			{
				move.play();
				background.loadGraphic(AssetPaths.bagItem__png);
				itemUi.visible = true;
				dealUi.visible = false;
			}
			// 交易紀錄
			if (r)
			{
				move.play();
				background.loadGraphic(AssetPaths.bagDeal__png);
				itemUi.visible = false;
				dealUi.visible = true;
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
		itemUi.visible = false;
		shopUi.visible = true;
		active = true;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	// 商店功能
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		// 按enter了
		if (!pointer.visible && shopText.textRunDone)
		{
			enterCur.visible = true;
			if (!enterCur.isFlickering())
				enterCur.flicker(0, 0.5);
		}
		if (enter && shopUi.visible)
		{
			enterCur.stopFlickering();
			enterCur.visible = false;
			check.play(true);
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
							pointer.setPointer(shopText.x - pointer.width - 30, shopText.y + 9, 90, buyChoices, "ud");
							mainChat = "猩猩什麼都沒有買！";
						// 賣
						case "sell":
							shopText.resetText(sellCho);
							sellAmoText.visible = true;
							sellAmoText.text = Std.string(bananaCounter) + "\n" + Std.string(shibaPrizeNow) + "\n" + Std.string(nftPrizeNow);
							shopChoice = sell;
							pointer.setPointer(shopText.x - pointer.width - 30, shopText.y + 9, 90, sellChoices, "ud");
							mainChat = "猩猩什麼都沒有賣！";
						// 聊天
						case "chat":
							shopText.resetText(chatCho);
							shopChoice = chat;
							pointer.setPointer(shopText.x - pointer.width - 30, shopText.y + 9, 90, chatChoices, "ud");
							mainChat = "猩猩什麼也沒說！";
						// 離開
						case "exit":
							FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
							{
								shopUi.visible = false;
								active = false;
								if (shibaInvest != 0)
									shibaUi.visible = true;
								if (nftInvest != 0)
									nftUi.visible = true;
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
							if (diamondCounter >= 1)
							{
								bananaCounter++;
								bananaSell++;
								diamondCounter--;
								mainChat = '猩猩給老闆 $bananaSell 個能量幣！\n老闆給猩猩 $bananaSell 片香蕉葉！';
								dealText.text = mainChat + "\n";
								updateBag();
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
								mainChat = '猩猩給老闆 $bananaSell 片香蕉葉！\n老闆給猩猩 $bananaSell 個能量幣！';
								dealText.text = mainChat + "\n";
							}
						case "shibaCoin":
							if (shibaPrizeNow > 0)
							{
								diamondCounter += shibaPrizeNow;
								sellAmoText.text = Std.string(bananaCounter) + "\n0\n" + Std.string(nftPrizeNow);
								updateBag();
								mainChat = '猩猩以 $shibaInvest 買進狗狗幣\n以 $shibaPrizeNow 賣出\n賺了' + FlxMath.roundDecimal(shibaPrizeNow - shibaInvest, 2) + "能量幣！\n";
								shibaWave = 0;
								shibaInvest = 0;
								shibaPrizeNow = 0;
								shibaTimer.cancel();
								if (shibaNotifText.text != "done")
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
								mainChat = '猩猩以 $nftInvest 買進NFT\n以 $nftPrizeNow 賣出\n賺了' + FlxMath.roundDecimal(nftPrizeNow - nftInvest, 2) + '能量幣！\n';
								nftWave = 0;
								nftInvest = 0;
								nftPrizeNow = 0;
								nftTimer.cancel();
								if (nftNotifText.text != "done")
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
						case "gameGuide":
							name = AssetPaths.shopGuide__txt;
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
		enterCur.stopFlickering();
		enterCur.visible = false;
		background.loadGraphic(AssetPaths.shopkeeperTalk__png);
		shopText.resetText(mainChat);
		shopText.start(false, false, function()
		{
			textRunDone = true;
			enterCur.visible = true;
			enterCur.flicker(0, 0.5);
		});
		pointer.setPointer(background.x + 285, shopCho.y, 90, mainChoices, "ud");
		shopChoice = main;
		bananaSell = 0;
	}

	// 聊天準備事項
	function shopChatStart(name, txt)
	{
		pointer.visible = false;
		sellAmoText.visible = false;
		shopText.show(name, txt);
	}
}
