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
	var diamondCounterIcon:FlxSprite;

	var shopCho:FlxText;
	var shopText:FlxTypeText;
	var mainTalk:String;
	var bananaSell:Int = 0;

	var dilog_boxes:Array<String>;
	var name:String;
	var i:Int = 1;
	var textRunDone:Bool = false;

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
		bananaCounterIcon = new FlxSprite(background.x + 10, background.y + 10).loadGraphic(AssetPaths.bananaIcon__png);
		add(bananaCounterIcon);

		// 香蕉數目
		bananaCounterText = new FlxText(bananaCounterIcon.x + bananaCounterIcon.width + 10, bananaCounterIcon.y + 5, "0", 20);
		add(bananaCounterText);

		// 錢圖示
		diamondCounterIcon = new FlxSprite(background.x + 10, background.y + 50).loadGraphic(AssetPaths.diamond__png);
		add(diamondCounterIcon);

		// 錢數目
		diamondCounterText = new FlxText(diamondCounterIcon.x + diamondCounterIcon.width + 10, diamondCounterIcon.y + 5, "0", 20);
		add(diamondCounterText);

		// 商店選項
		shopCho = new FlxText(background.x + 10, background.y + 10, "買\n賣\n聊天\n離開", 20);
		add(shopCho);

		// 商店的字
		shopText = new FlxTypeText(0, 0, 270, "歡迎來到我的店！", 20);
		add(shopText);

		shopText.delay = 0.04;
		shopText.skipKeys = ["X", "SHIFT"];
		shopText.sounds = [FlxG.sound.load("assets/sounds/speech.wav")];
		// shopText.font = AssetPaths.font__ttf;

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
		bananaCounterIcon.setPosition(background.x + 10, background.y + 10);
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
		diamondCounterIcon.visible = true;

		shopText.visible = false;
		shopkeeper.visible = false;
		shopCho.visible = false;
		pointer.visible = false;
	}

	public function buyAndSell()
	{
		background.y = FlxG.height / 2;
		background.makeGraphic(FlxG.width - 20, 360, FlxColor.BLACK);

		shopText.setPosition(150, background.y + 10);
		shopCho.setPosition(background.x + 10 + pointer.width + 10, background.y + 10);
		diamondCounterIcon.setPosition(shopCho.x, shopCho.y + shopCho.height + 10);
		diamondCounterText.setPosition(shopCho.x + diamondCounterIcon.width + 10, diamondCounterIcon.y);

		mainTalk = "歡迎來到我的店！";
		setMainShop(mainTalk);

		visible = true;

		bananaCounterIcon.visible = false;
		bananaCounterText.visible = false;

		diamondCounterText.visible = true;
		diamondCounterIcon.visible = true;
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
		pointer.setPointer(background.y + 15, background.x + 10, 26, 4, "ud");
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
						shopText.resetText("      " + "2元" + "\n\n離開");
						shopText.start(false, false);
						shopText.skip();
						shopChoice = buy;
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 52, 2, "ud");
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
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 52, 2, "ud");
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
						pointer.setPointer(background.y + 15, shopText.x - pointer.width - 10, 26, 2, "ud");
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
							mainTalk = "猩猩給老闆" + Std.string(bananaSell * 2) + "個能量石！\n老闆給猩猩" + Std.string(bananaSell) + "片香蕉葉！";
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
							mainTalk = "猩猩給老闆" + Std.string(bananaSell) + "片香蕉葉！\n老闆給猩猩" + Std.string(bananaSell) + "個能量石！";
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
