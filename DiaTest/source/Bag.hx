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

	public var diamondCounter:Int = 0;

	var diamondCounterText:FlxText;

	var shopCho:FlxText;
	var shopText:FlxTypeText;
	var mainTalk:String;
	var bananaSell:Int = 0;

	var dilog_boxes:Array<String>;
	var name:String;
	var i:Int = 1;

	public var shopChoice(default, null):ShopChoice;

	var pointer:Pointer;

	public function new()
	{
		super();
		// 老闆
		shopkeeper = new FlxSprite(0, 0).loadGraphic(AssetPaths.explain2__png);
		add(shopkeeper);
		// 背景
		background = new FlxSprite(10, 10);
		add(background);

		// 香蕉數目
		bananaCounterText = new FlxText(background.x + 10, background.y + 10, "香蕉葉：0能量石：0", 20);
		add(bananaCounterText);

		// 前數目

		// 商店選項
		shopCho = new FlxText(background.x + 10, background.y + 10, "買\n賣\n聊天\n離開", 20);
		add(shopCho);

		// 商店的字
		shopText = new FlxTypeText(0, 0, 270, "歡迎來到我的店！", 20);
		add(shopText);

		shopText.delay = 0.04;
		shopText.skipKeys = ["X", "SHIFT"];

		// 箭頭
		pointer = new Pointer();
		add(pointer);

		forEach(function(sprite) sprite.scrollFactor.set(0, 0));

		visible = false;
		active = false;
	}

	public function bagUi()
	{
		background.makeGraphic(FlxG.width - 20, FlxG.height - 20, FlxColor.BLACK);
		background.y = 10;
		bananaCounterText.setPosition(background.width / 2, background.y + 10);

		visible = true;
		bananaCounterText.visible = true;
		shopText.visible = false;
		shopkeeper.visible = false;
		shopCho.visible = false;
		pointer.visible = false;

		active = true;
	}

	public function buyAndSell()
	{
		background.y = FlxG.height / 2;
		background.makeGraphic(FlxG.width - 20, 360, FlxColor.BLACK);

		shopText.setPosition(150, background.y + 10);
		shopCho.setPosition(background.x + 10 + pointer.width + 10, background.y + 10);
		mainTalk = "歡迎來到我的店！";
		setMainShop(mainTalk);

		visible = true;
		bananaCounterText.visible = false;
		shopText.visible = true;
		shopkeeper.visible = true;
		shopCho.visible = true;
		pointer.visible = true;

		active = true;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	function setMainShop(mainTalk)
	{
		shopText.resetText(mainTalk);
		shopText.start(false, false);
		pointer.setPointer(background.y + 15, background.x + 10, 26, 4, "ud");
		shopChoice = main;
	}

	public function updateBag()
	{
		bananaCounterText.text = "香蕉葉：" + Std.string(bananaCounter) + "能量石：" + Std.string(diamondCounter);
	}

	override function update(elapsed:Float)
	{
		updateEnter();
		// 退出
		if (visible)
		{
			// 如果按x而且不是在商店(看不到老闆)才能退出
			var x = FlxG.keys.anyJustReleased([X]);
			if (x && !shopkeeper.visible)
			{
				visible = false;
				active = false;
			}
		}
		super.update(elapsed);
	}

	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE, Z]);
		// 按enter了
		if (enter)
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
						shopText.resetText("我還沒想要賣什麼\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = buy;
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
					}
					// 賣
					else if (pointer.y == pointer.start + pointer.bar)
					{
						shopText.resetText("香蕉葉：" + Std.string(bananaCounter) + "每5片1元" + "\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = sell;
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
					}
					// 聊天
					else if (pointer.y == pointer.start + pointer.bar * 2)
					{
						shopText.resetText("為什麼要對著包包大吼大叫\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = talk;
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
					}
					// 離開
					else
					{
						FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
						{
							updateBag();
							visible = false;
							active = false;
							FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
						});
					}
				}

				// 開始買
				else if (shopChoice == buy)
				{
					if (pointer.y == pointer.start + pointer.bar)
					{
						mainTalk = "猩猩什麼都沒有買！";
						setMainShop(mainTalk);
					}
				}

				// 開始賣
				else if (shopChoice == sell)
				{
					if (pointer.y == pointer.start)
					{
						if (bananaCounter >= 5)
						{
							bananaCounter -= 5;
							bananaSell++;
							diamondCounter++;
							shopText.resetText("香蕉葉：" + Std.string(bananaCounter) + "每5片1元" + "\n離開");
							shopText.start(false, false);
							shopText.skip();
						}
					}
					else
					{
						if (bananaSell == 0)
							mainTalk = "猩猩什麼都沒有賣！";
						else
							mainTalk = "猩猩給老闆" + Std.string(bananaSell * 5) + "片香蕉葉！\n老闆給猩猩" + Std.string(bananaSell) + "個能量石！";
						bananaSell = 0;
						setMainShop(mainTalk);
					}
				}

				// 開始聊天
				else if (shopChoice == talk)
				{
					if (pointer.y == pointer.start) {}
					if (pointer.y == pointer.start + pointer.bar)
					{
						mainTalk = "猩猩跟老闆聊天了！";
						setMainShop(mainTalk);
					}
				}
			}
		}
	}
}
