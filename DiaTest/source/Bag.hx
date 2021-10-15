package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
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
	var shopText:FlxTypeText;
	var mainTalk:String;
	var bananaSell:Int = 0;

	var dilog_boxes:Array<String>;
	var name:String;
	var i:Int = 1;
	var textRunDone:Bool = false;

	var dealText:FlxText;
	var j:Int = 1;

	public var shopChoice(default, null):ShopChoice;

	var pointer:Pointer;

	public function new()
	{
		super();
		// 老闆
		shopkeeper = new FlxSprite(0, 0).loadGraphic(AssetPaths.shopkeeper__png);
		add(shopkeeper);

		// 背景
		background = new FlxSprite(10, 10);
		add(background);

		// 香蕉圖示
		bananaCounterIcon = new FlxSprite(65, 120).loadGraphic(AssetPaths.bananaIcon__png);
		add(bananaCounterIcon);

		// 香蕉數目
		bananaCounterText = new FlxText(bananaCounterIcon.x + bananaCounterIcon.width, bananaCounterIcon.y + 5, "0", 20);
		bananaCounterText.color = 0xff2D5925;
		add(bananaCounterText);

		// 錢數目
		diamondCounterText = new FlxText(370, 265, "0", 20);
		diamondCounterText.color = 0xff2D5925;
		add(diamondCounterText);

		// 商店選項
		shopCho = new FlxText(background.x + 10, background.y + 10, "買\n賣\n聊天\n離開\n", 26, true);
		shopCho.color = 0xff2D5925;
		shopCho.font = AssetPaths.silver__ttf;
		add(shopCho);

		// 商店的字
		shopText = new FlxTypeText(0, 0, 270, "歡迎來到我的店！", 28, true);
		shopText.color = 0xff2D5925;
		shopText.delay = 0.05;
		shopText.skipKeys = ["X", "SHIFT"];
		shopText.sounds = [FlxG.sound.load("assets/sounds/speech.wav")];
		shopText.font = AssetPaths.silver__ttf;
		add(shopText);

		dealText = new FlxText(85, 125, "Doge給猩猩一個包包！\n", 28, true);
		dealText.color = 0xff2D5925;
		dealText.font = AssetPaths.silver__ttf;
		add(dealText);

		// 箭頭
		pointer = new Pointer();
		pointer.loadGraphic(AssetPaths.shopPointer__png);
		add(pointer);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));

		visible = false;
		active = false;
	}

	public function bagUi()
	{
		background.loadGraphic(AssetPaths.bagItem__png);
		background.y = 10;
		bananaCounterIcon.setPosition(65, 120);
		diamondCounterText.setPosition(370, 265);
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

		diamondCounterText.visible = true;
		dealText.visible = false;
		shopText.visible = false;
		shopkeeper.visible = false;
		shopCho.visible = false;
		pointer.visible = false;
	}

	public function buyAndSell()
	{
		background.setPosition(0, 172);
		background.loadGraphic(AssetPaths.shopUi__png);

		shopText.setPosition(200, background.y + 20);
		shopCho.setPosition(background.x + 10 + pointer.width + 10, background.y + 20);
		diamondCounterText.setPosition(80, 310);

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
		pointer.setPointer(shopCho.y, background.x + 15, 30, 4, "ud");
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
		if (enter && shopkeeper.visible)
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
						shopText.resetText("      " + "2元" + "\n\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = buy;
						pointer.setPointer(shopText.y + 3, shopText.x - pointer.width - 10, 60, 2, "ud");
						bananaCounterIcon.visible = true;
						bananaCounterIcon.setPosition(shopText.x - 5, shopText.y);
					}
					// 賣
					else if (pointer.y == pointer.start + pointer.bar)
					{
						shopText.resetText("      " + Std.string(bananaCounter) + "   1元" + "\n\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = sell;
						pointer.setPointer(shopText.y + 3, shopText.x - pointer.width - 10, 60, 2, "ud");
						bananaCounterIcon.visible = true;
						bananaCounterIcon.setPosition(shopText.x - 5, shopText.y);
					}
					// 聊天
					else if (pointer.y == pointer.start + pointer.bar * 2)
					{
						shopText.resetText("為什麼要對著包包大吼大叫\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = talk;
						pointer.setPointer(shopText.y + 3, shopText.x - pointer.width - 10, 28, 2, "ud");
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
							shopText.resetText("      " + "2元" + "\n\n離開");
							shopText.start(false, false);
							shopText.skip();
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
							if (j < 2)
								dealText.text += mainTalk + "\n";
							j++;
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
							bananaCounter--;
							bananaSell++;
							diamondCounter++;
							shopText.resetText("      " + Std.string(bananaCounter) + "   1元" + "\n\n離開");
							shopText.start(false, false);
							shopText.skip();
							updateBag();
						}
					}
					else
					{
						if (bananaSell == 0)
							mainTalk = "猩猩什麼都沒有賣！";
						else
						{
							mainTalk = "猩猩給老闆" + Std.string(bananaSell) + "片香蕉葉！\n老闆給猩猩" + Std.string(bananaSell) + "個能量石！";
							if (j < 2)
								dealText.text += mainTalk + "\n";
							j++;
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
						shopTalkStart(name);
						pointer.visible = false;
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
				i++;

				// 對話結束就離開
				if (i >= dilog_boxes.length)
				{
					pointer.visible = true;
					shopText.resetText("為什麼要對著包包大吼大叫\n離開");
					shopText.start(false, false);
					shopText.skip();
					shopChoice = talk;
				}
				else
				{
					textRunDone = false;
					shopText.resetText(dilog_boxes[i]);
					shopText.start(false, false, function()
					{
						textRunDone = true;
					});
				}
			}
		}
	}

	// 聊天準備事項
	function shopTalkStart(name)
	{
		dilog_boxes = openfl.Assets.getText(name).split(":");
		i = 1;

		textRunDone = false;
		shopText.resetText(dilog_boxes[i]);
		shopText.start(false, false, function()
		{
			textRunDone = true;
		});
	}
}
