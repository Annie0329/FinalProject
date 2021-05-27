// 傳說中的500行程式
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil; // drawRect需要這個

// 打架的結果
enum Outcome
{
	NONE;
	ESCAPE;
	VICTORY;
	DEFEAT;
}

// 選項
enum Choice
{
	FIGHT;
	FLEE;
}

class CombatHUD extends FlxTypedGroup<FlxSprite>
{
	// 打架結束後這些東西會告訴我們發生了什麼事
	public var enemy:Enemy; // 我們打的是哪個敵人
	public var playerHealth(default, null):Int; // 我們還有多少血，default是默認
	public var outcome(default, null):Outcome; // 我們到底是逃走還是殺了敵人

	// 這些事hud的素材
	var background:FlxSprite; // 背景
	var playerSprite:Player; // 玩家
	var enemySprite:Enemy; // 敵人

	// 敵人的血量
	var enemyHealth:Int;
	var enemyMaxHealth:Int;
	var enemyHealthBar:FlxBar; // 告訴我們敵人目前血量和最高血量

	var playerHealthCounter:FlxText; // 玩家的目前血量和最高血量

	var damages:Array<FlxText>; // 這陣列裡有2筆資料：傷害的值和miss

	var pointer:FlxSprite; // 那個選擇打或逃的箭頭
	var selected:Choice; // 我們選的打還是逃(前面那的enum的Choice)
	var choices:Map<Choice, FlxText>; // 這個地圖把打或逃的選項變成文字(應該吧)

	var results:FlxText; // 顯示結果的文字

	var alpha:Float = 0; // 淡入淡出的效果
	var wait:Bool = true; // 當我們不准玩家動時就把這個設為true

	// 聲音們
	var fledSound:FlxSound;
	var hurtSound:FlxSound;
	var loseSound:FlxSound;
	var selectSound:FlxSound;
	var winSound:FlxSound;
	var combatSound:FlxSound;

	var screen:FlxSprite;

	public function new()
	{
		super();

		// 這八成是波動特效
		screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
		var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 4, -1, 4);
		var waveSprite = new FlxEffectSprite(screen, [waveEffect]);
		add(waveSprite);

		// hud的背景，黑底白邊，經典！畫完就加到群組
		background = new FlxSprite().makeGraphic(120, 120, FlxColor.WHITE);
		background.drawRect(1, 1, 118, 44, FlxColor.BLACK);
		background.drawRect(1, 46, 118, 73, FlxColor.BLACK);
		background.screenCenter();
		add(background);

		// 加入玩家的人形立牌，這東東沒辦法被操控
		playerSprite = new Player(background.x = 36, background.y = 16);
		playerSprite.animation.frameIndex = 3;
		playerSprite.active = false;
		playerSprite.facing = FlxObject.RIGHT;
		add(playerSprite);

		// 加入敵人的人形立牌
		enemySprite = new Enemy(background.x = 76, background.y = 16, REGULAR);
		enemySprite.animation.frameIndex = 3;
		enemySprite.active = false;
		enemySprite.facing = FlxObject.LEFT;
		add(enemySprite);

		// 加入玩家的血量
		playerHealthCounter = new FlxText(1, playerSprite.y + playerSprite.height + 2, "3/3", 8);
		playerHealthCounter.alignment = CENTER;
		playerHealthCounter.x = playerSprite.x + 4 - (playerHealthCounter.width / 2);
		add(playerHealthCounter);

		// 加入敵人的血量條
		enemyHealthBar = new FlxBar(enemySprite.x - 6, playerHealthCounter.y, LEFT_TO_RIGHT, 20, 10);
		enemyHealthBar.createFilledBar(0xffdc143c, FlxColor.YELLOW, true, FlxColor.YELLOW);
		add(enemyHealthBar);
	}
}
