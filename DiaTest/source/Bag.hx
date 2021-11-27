package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

// 商店選項
enum ShopChoice
{
	main;
	buy;
	sell;
	talk;
	exit;
}

class Bag extends FlxTypedGroup<FlxBasic>
{
	public var shopUi = new FlxTypedGroup<FlxSprite>();
	public var bagUi = new FlxTypedGroup<FlxSprite>();
	public var diamondUi = new FlxTypedGroup<FlxSprite>();

	var background:FlxSprite;

	public var bananaCounter:Int = 0;
	public var diamondCounter:Int = 0;

	var bananaCounterText:FlxText;
	var bananaCounterIcon:FlxSprite;

	var shopCho:FlxText;
	var shopText:Text;
	var mainTalk:String;
	var bananaSell:Int = 0;

	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;

	var dealText:FlxText;

	var sellCho:String = "   1 能量幣\n原本世界的錢\n離開";
	var buyCho:String = "   2 能量幣\n離開";
	var talkCho:String = "為什麼要對著包包大吼大叫\n離開";

	public var shopChoice(default, null):ShopChoice;

	var pointer:Pointer;

	public var diamondText:FlxText;

	var diamondIcon:FlxSprite;

	public function new()
	{
		super();

		// 背景
		background = new FlxSprite();

		// 香蕉圖示
		bananaCounterIcon = new FlxSprite(140, 110, AssetPaths.bananaIcon__png);

		// 包包組
		bagUi.add(background);
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
		shopUi.add(bananaCounterIcon);

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

		add(shopUi);
		shopUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		shopUi.visible = false;

		// 能量幣組
		diamondIcon = new FlxSprite(10, 10).loadGraphic(AssetPaths.diamondIcon__png);
		diamondUi.add(diamondIcon);

		diamondText = new FlxText(diamondIcon.x + 40, diamondIcon.y + 7, "0", 20);
		diamondText.color = 0xff2D5925;
		diamondUi.add(diamondText);

		add(diamondUi);
		diamondUi.forEach(function(sprite) sprite.scrollFactor.set(0, 0));

		active = false;
	}

	// 開啟包包
	public function bagUiShow()
	{
		background.loadGraphic(AssetPaths.bagItem__png);

		bananaCounterIcon.setGraphicSize(40, 40);
		bananaCounterIcon.updateHitbox();
		bananaCounterIcon.setPosition(140, 110);

		dealText.visible = false;

		if (bananaCounter > 0)
		{
			bananaCounterIcon.visible = true;
			bananaCounterText.visible = true;
		}
		else
		{
			bananaCounterIcon.visible = false;
			bananaCounterText.visible = false;
		}

		bagUi.visible = true;
		shopUi.visible = false;
		active = true;
	}

	// 開啟商店
	public function buyAndSell()
	{
		background.loadGraphic(AssetPaths.shopkeeper__png);

		bananaCounterIcon.setGraphicSize(30, 30);
		bananaCounterIcon.updateHitbox();
		bananaCounterIcon.visible = false;

		mainTalk = "歡迎來到我的店！";
		setMainShop(mainTalk);

		bagUi.visible = false;
		shopUi.visible = true;
		active = true;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	function setMainShop(mainTalk)
	{
		textRunDone = false;
		shopText.resetText(mainTalk);
		shopText.start(false, false, function()
		{
			textRunDone = true;
		});
		pointer.setPointer(background.x + 95, shopCho.y, 30, 4, "ud");
		shopChoice = main;
	}

	public function updateBag()
	{
		bananaCounterText.text = Std.string(bananaCounter);
		diamondText.text = Std.string(diamondCounter);
		if (diamondCounter < 0)
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}

	override function update(elapsed:Float)
	{
		updateEnter();

		// 包包功能
		if (bagUi.visible)
		{
			var x = FlxG.keys.anyJustReleased([X]);
			var l = FlxG.keys.anyJustReleased([LEFT]);
			var r = FlxG.keys.anyJustReleased([RIGHT]);
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

		super.update(elapsed);
	}

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
					// 買
					if (pointer.y == pointer.start)
					{
						shopText.resetText(buyCho);
						shopText.start(false, false);
						shopText.skip();
						textRunDone = true;
						shopChoice = buy;
						pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, 2, "ud");
						bananaCounterIcon.visible = true;
						bananaCounterIcon.setPosition(shopText.x - 5, shopText.y);
					}
					// 賣
					else if (pointer.y == pointer.start + pointer.bar)
					{
						shopText.resetText("   " + Std.string(bananaCounter) + sellCho);
						shopText.start(false, false);
						shopText.skip();
						textRunDone = true;
						shopChoice = sell;
						pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, 3, "ud");
						bananaCounterIcon.visible = true;
						bananaCounterIcon.setPosition(shopText.x - 5, shopText.y);
					}
					// 聊天
					else if (pointer.y == pointer.start + pointer.bar * 2)
					{
						textRunDone = false;
						shopText.resetText(talkCho);
						shopText.start(false, false, function()
						{
							textRunDone = true;
						});
						shopText.skip();
						shopChoice = talk;
						pointer.setPointer(shopText.x - pointer.width - 10, shopText.y + 3, 30, 2, "ud");
					}
					// 離開
					else
					{
						textRunDone = true;
						FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
						{
							shopUi.visible = false;
							active = false;
							FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
						});
					}
				}

				// 開始買
				else if (shopChoice == buy)
				{
					if (pointer.y == pointer.start)
					{
						if (diamondCounter >= 2)
						{
							bananaCounter++;
							bananaSell++;
							diamondCounter -= 2;
							shopText.resetText(buyCho);
							shopText.start(false, false);
							shopText.skip();
							textRunDone = true;
							updateBag();
						}
					}
					else if (pointer.y == pointer.start + pointer.bar)
					{
						if (bananaSell == 0)
							mainTalk = "猩猩什麼都沒有買！";
						else
						{
							mainTalk = "猩猩給老闆 " + Std.string(bananaSell * 2) + " 個能量石！\n老闆給猩猩 " + Std.string(bananaSell) + " 片香蕉葉！";
							dealText.text = mainTalk + "\n";
						}
						bananaSell = 0;
						bananaCounterIcon.visible = false;
						setMainShop(mainTalk);
					}
				}

				// 開始賣
				else if (shopChoice == sell)
				{
					if (pointer.y == pointer.start)
					{
						if (bananaCounter > 0)
						{
							diamondCounter += bananaCounter;
							bananaSell = bananaCounter;
							bananaCounter = 0;
							shopText.resetText("   " + Std.string(bananaCounter) + sellCho);
							shopText.start(false, false);
							shopText.skip();
							textRunDone = true;
							updateBag();
						}
					}
					else if (pointer.y == pointer.start + pointer.bar)
					{
						name = ":嗯？抱歉，我們不幫忙丟回收紙類喔。";
						txt = false;
						shopTalkStart(name, txt);
					}
					else
					{
						if (bananaSell == 0)
							mainTalk = "猩猩什麼都沒有賣！";
						else
						{
							mainTalk = "猩猩給老闆 " + Std.string(bananaSell) + " 片香蕉葉！\n老闆給猩猩 " + Std.string(bananaSell) + " 個能量石！";
							dealText.text = mainTalk + "\n";
						}
						bananaSell = 0;
						bananaCounterIcon.visible = false;
						setMainShop(mainTalk);
					}
				}

				// 開始聊天
				else if (shopChoice == talk)
				{
					if (pointer.y == pointer.start)
					{
						name = AssetPaths.shopTalk__txt;
						txt = true;
						shopTalkStart(name, txt);
					}
					if (pointer.y == pointer.start + pointer.bar)
					{
						mainTalk = "猩猩跟老闆聊天了！";
						setMainShop(mainTalk);
					}
				}
			}
			else
			{
				// 對話結束就離開
				if (shopText.over)
				{
					pointer.visible = true;
					if (shopChoice == talk)
					{
						shopText.resetText(talkCho);
						shopText.start(false, false);
						shopText.skip();
						textRunDone = true;
					}
					else if (shopChoice == sell)
					{
						shopText.resetText("   " + Std.string(bananaCounter) + sellCho);
						shopText.start(false, false);
						shopText.skip();
						textRunDone = true;
						bananaCounterIcon.visible = true;
					}
				}
			}
		}
	}

	// 聊天準備事項
	function shopTalkStart(name, txt)
	{
		pointer.visible = false;
		bananaCounterIcon.visible = false;
		shopText.show(name, txt);
	}
}
