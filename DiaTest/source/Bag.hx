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
	var shopText:FlxText;

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
		shopText = new FlxText(0, 0, 200, "歡迎來到我的店！", 20);
		add(shopText);

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

		shopText.setPosition(background.width / 2, background.y + 10);
		shopCho.setPosition(background.x + 10 + pointer.width + 10, background.y + 10);
		setMainShop();

		visible = true;
		bananaCounterText.visible = false;
		shopText.visible = true;
		shopkeeper.visible = true;
		shopCho.visible = true;
		pointer.visible = true;

		active = true;
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}

	function setMainShop()
	{
		shopText.text = "歡迎來到我的店！";
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
			var x = FlxG.keys.anyJustReleased([X]);
			if (x && !pointer.visible)
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
		if (enter && pointer.visible)
		{
			// 主選單
			if (shopChoice == main)
			{
				// 買
				if (pointer.y == pointer.start)
				{
					shopText.text = "我還沒想要賣什麼\n離開";
					shopChoice = buy;
					pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
				}
				// 賣
				else if (pointer.y == pointer.start + pointer.bar)
				{
					shopText.text = "香蕉葉：" + Std.string(bananaCounter) + "每5片1元" + "\n離開";
					shopChoice = sell;
					pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
				}
				// 聊天
				else if (pointer.y == pointer.start + pointer.bar * 2)
				{
					shopText.text = "今天天氣真好！\n離開";
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
					setMainShop();
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
						diamondCounter++;
						shopText.text = "香蕉葉：" + Std.string(bananaCounter) + "每5片1元" + "\n離開";
					}
				}
				else
				{
					setMainShop();
				}
			}

			// 開始聊天
			else if (shopChoice == talk)
			{
				if (pointer.y == pointer.start + pointer.bar)
				{
					setMainShop();
				}
			}
		}
	}
}
