package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var healthCounter:FlxText;
	var moneyCounter:FlxText;
	var healthIcon:FlxSprite;
	var moneyIcon:FlxSprite;
	var text:FlxText;
	var textBox:FlxSprite;
	var i:Int = 0;
	var f:String = "";

	public function new()
	{
		super();
		// 黑色扛棒，FlxG.width應該是螢幕寬度
		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		// 白線
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);

		// 血量
		healthCounter = new FlxText(16, 0, 0, "3/3", 8);
		// 血量的陰影
		healthCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		// 血量圖示，第一個是x座標，第二個是y座標，第三個是圖片檔
		healthIcon = new FlxSprite(4, healthCounter.y + (healthCounter.height / 2) - 4, AssetPaths.health__png);

		// 錢的數目
		moneyCounter = new FlxText(0, 2, 0, "0", 8);
		moneyCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);

		// 錢的數目圖示
		moneyIcon = new FlxSprite(FlxG.width - 12, moneyCounter.y + (moneyCounter.height / 2) - 4, AssetPaths.coin__png);

		// 錢的數目對齊
		moneyCounter.alignment = RIGHT;
		moneyCounter.x = moneyIcon.x - moneyCounter.width - 4;

		// 用力加進去
		add(background);
		add(healthIcon);
		add(moneyIcon);
		add(healthCounter);
		add(moneyCounter);

		// 就算攝影機動還是待在原處
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	public function updateHUD(health:Int, money:Int)
	{
		healthCounter.text = health + "/3";
		moneyCounter.text = Std.string(money);
		moneyCounter.x = moneyIcon.x - moneyCounter.width - 4;
	}
}
