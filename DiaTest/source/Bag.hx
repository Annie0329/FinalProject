package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

enum ShopChoice
{
	main;
	buy;
	sell;
	talk;
	exit;
}

class Bag extends FlxTypedGroup<FlxSprite>
{
	var shopkeeper:FlxSprite;
	var background:FlxSprite;

	public var bananaCounter:Int = 0;

	var bananaCounterText:FlxText;
	var bananaCounterIcon:FlxSprite;

	public var diamondCounter:Int = 0;

	var diamondCounterText:FlxText;

	var shopCho:FlxText;
	var shopText:Text;
	var mainTalk:String;
	var bananaSell:Int = 0;

	var dilog_boxes:Array<String>;
	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;

	var dealText:FlxText;

	var sellCho:String = "   1能量幣\n原本世界的錢\n離開";
	var buyCho:String = "   2能量幣\n離開";
	var talkCho:String = "為什麼要對著包包大吼大叫\n離開";

	public var shopChoice(default, null):ShopChoice;

	var pointer:Pointer;

	public function new()
	{
		super();
		// 老闆
		shopkeeper = new FlxSprite(0, 0, AssetPaths.shopkeeper__png);
		add(shopkeeper);

		// 背景
		background = new FlxSprite(10, 10);
		background.screenCenter(FlxAxes.X);
		add(background);

		// 香蕉圖示
		bananaCounterIcon = new FlxSprite(background.x + 65, 120, AssetPaths.bananaIcon__png);
		add(bananaCounterIcon);

		// 香蕉數目
		bananaCounterText = new FlxText(bananaCounterIcon.x + bananaCounterIcon.width, bananaCounterIcon.y + 5, "0", 20);
		bananaCounterText.color = 0xff2D5925;
		add(bananaCounterText);

		// 錢數目
		diamondCounterText = new FlxText(370, 150, "0", 20);
		diamondCounterText.color = 0xff2D5925;
		add(diamondCounterText);

		// 商店選項
		shopCho = new FlxText(background.x + 10, background.y + 10, "買\n賣\n聊天\n離開\n", 26, true);
		shopCho.color = 0xff2D5925;
		shopCho.font = AssetPaths.silver__ttf;
		add(shopCho);

		// 商店的字
		shopText = new Text(0, 0, 270, "歡迎來到我的店！", 28, true);
		shopText.color = 0xff2D5925;
		add(shopText);

		// 交易紀錄
		dealText = new FlxText(background.x + 85, 125, "目前並無交易紀錄\n", 28, true);
		dealText.color = 0xff2D5925;
		dealText.font = AssetPaths.silver__ttf;
		add(dealText);

		// 箭頭
		pointer = new Pointer();
		pointer.color = 0xffF0433D;
		add(pointer);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));

		visible = false;
		active = false;
	}

	public function bagUi()
	{
		background.loadGraphic(AssetPaths.bagItem__png);
		background.screenCenter(FlxAxes.X);
		background.y = 10;
		bananaCounterIcon.setPosition(background.x + 65, 120);
		bananaCounterIcon.setGraphicSize(40, 40);
		bananaCounterIcon.updateHitbox();
		bananaCounterText.x = bananaCounterIcon.x + bananaCounterIcon.width;
		diamondCounterText.setPosition(background.x + 370, 265);
		dealText.setPosition(background.x + 85, 125);
		visible = true;
		active = true;
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

		dealText.visible = false;
		shopText.visible = false;
		shopkeeper.visible = false;
		shopCho.visible = false;
		pointer.visible = false;
	}

	public function buyAndSell()
	{
		background.loadGraphic(AssetPaths.shopUi__png);
		background.setPosition(0, 172);
		background.screenCenter(FlxAxes.X);

		shopText.setPosition(background.x + 200, background.y + 20);
		shopCho.setPosition(background.x + 10 + pointer.width + 10, background.y + 20);
		diamondCounterText.setPosition(background.x + 80, 310);
		bananaCounterIcon.setGraphicSize(30, 30);
		bananaCounterIcon.updateHitbox();

		mainTalk = "歡迎來到我的店！";
		setMainShop(mainTalk);

		visible = true;

		bananaCounterIcon.visible = false;
		bananaCounterText.visible = false;
		dealText.visible = false;

		diamondCounterText.visible = true;
		shopText.visible = true;
		shopkeeper.visible = true;
		shopCho.visible = true;
		pointer.visible = true;

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
		pointer.setPointer(background.x + 15, shopCho.y, 30, 4, "ud");
		shopChoice = main;
	}

	public function updateBag()
	{
		bananaCounterText.text = Std.string(bananaCounter);
		diamondCounterText.text = Std.string(diamondCounter);
	}

	override function update(elapsed:Float)
	{
		updateEnter();
		// 退出
		if (visible)
		{
			// 如果按x而且不是在商店(看不到老闆)才能退出
			var x = FlxG.keys.anyJustReleased([X]);
			var l = FlxG.keys.anyJustReleased([LEFT]);
			var r = FlxG.keys.anyJustReleased([RIGHT]);
			if (!shopkeeper.visible)
			{
				if (x)
				{
					visible = false;
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

		super.update(elapsed);
	}

	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		// 按enter了
		if (enter && shopkeeper.visible && textRunDone)
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
							visible = false;
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
							mainTalk = "猩猩給老闆" + Std.string(bananaSell * 2) + "個能量石！\n老闆給猩猩" + Std.string(bananaSell) + "片香蕉葉！";
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
							mainTalk = "猩猩給老闆" + Std.string(bananaSell) + "片香蕉葉！\n老闆給猩猩" + Std.string(bananaSell) + "個能量石！";
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
