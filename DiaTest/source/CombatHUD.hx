package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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
	YES;
	NO;
}

class CombatHUD extends FlxTypedGroup<FlxSprite>
{
	public var enemy:Enemy; // 我們打的是哪個敵人
	public var choice(default, null):Choice; // 我們到底是逃走還是殺了敵人

	// 這些是hud的素材
	var background:FlxSprite; // 背景
	var playerSprite:Player; // 玩家
	var enemySprite:Enemy; // 敵人

	var pointer:FlxSprite; // 那個選擇打或逃的箭頭
	var selected:Choice; // 我們選的打還是逃(前面那的enum的Choice)
	var choices:Map<Choice, FlxText>; // 這個地圖把打或逃的選項變成文字(應該吧)

	// 文字組
	var combatText:FlxTypeText;
	var dilog_boxes:Array<String>;
	var name:String;
	var txt:Bool = true;
	var i:Int = 1;
	var textRunDone:Bool = false;

	var alpha:Float = 0; // 淡入淡出的效果，alpha就是透明度啦
	var wait:Bool = true; // 當我們不准玩家動時就把這個設為true

	public function new()
	{
		super();

		// hud的背景
		background = new FlxSprite().makeGraphic(240, 240, 0xff2D5925);
		background.drawRect(2, 2, 236, 88, 0xffB6E3AD);
		background.drawRect(2, 92, 236, 146, 0xffB6E3AD);
		background.screenCenter();
		add(background);

		// 加入玩家的人形立牌，這東東沒辦法被操控
		playerSprite = new Player();
		playerSprite.setPosition(background.x + 36, background.y + 35);
		playerSprite.animation.frameIndex = 3;
		playerSprite.active = false;
		playerSprite.facing = FlxObject.RIGHT;
		add(playerSprite);

		// 加入敵人的人形立牌
		enemySprite = new Enemy(0, 0, REGULAR);
		enemySprite.setPosition(background.x + 152, background.y);
		// enemySprite.animation.frameIndex = 3;
		enemySprite.active = false;
		// enemySprite.facing = FlxObject.LEFT;
		add(enemySprite);

		// 字
		combatText = new FlxTypeText(background.x, background.y, 200, "你想要買奇怪的柴犬幣嗎？", 28, true);
		combatText.color = 0xff2D5925;
		combatText.font = AssetPaths.silver__ttf;
		// text.sounds = [FlxG.sound.load("assets/sounds/speech.wav")];
		combatText.delay = 0.07;
		combatText.skipKeys = ["X", "SHIFT"];
		add(combatText);

		// 加入選項
		choices = new Map();
		choices[YES] = new FlxText(background.x + 60, background.y + 96, 170, "YES", 44);
		choices[YES].color = 0xff2D5925;
		choices[NO] = new FlxText(background.x + 60, choices[YES].y + choices[YES].height + 16, 170, "NO", 44);
		choices[NO].color = 0xff2D5925;
		add(choices[YES]);
		add(choices[NO]);

		// 那隻箭頭
		pointer = new FlxSprite(background.x + 40, choices[YES].y + (choices[YES].height / 2) - 16, AssetPaths.combatPointer__png);
		pointer.visible = false;
		add(pointer);

		forEach(function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
			sprite.alpha = 0;
		});
		// 在我們叫打架畫面前這些東西都不要出現，也不要亂動
		active = false;
		visible = false;
	}

	/**
		*當打架開始時PlayerState會啟動這個功能。這會架好螢幕，讓一切都準備好
		*@param enemy 我們打的是哪種敵人，這樣才能叫出正確的類型
	 */
	public function initCombat(playerHealth:Int, enemy:Enemy)
	{
		this.enemy = enemy; // 把這裡的敵人設成我們在別地方拿到的敵人

		enemySprite.changeType(enemy.type); // 換成普通敵人或是魔王

		// 確定這些東西即使在我們之後來也不會亂動或亂出現
		wait = true;
		pointer.visible = false;
		selected = YES;
		movePointer();

		visible = true; // 讓打架介面出現

		// 應該是淡入的效果
		FlxTween.num(0, 1, .66, {ease: FlxEase.circOut, onComplete: finishFadeIn}, updateAlpha);
	}

	// 召喚淡入淡出的效果
	function updateAlpha(alpha:Float)
	{
		this.alpha = alpha;
		forEach(function(sprite) sprite.alpha = alpha);
		// 謎樣的程式
		// 根據我的了解，this好像是用來區分本來就在的變數跟外來的變數
		// 有加this的是本地變數
	}

	// 淡入後就啟用hud
	function finishFadeIn(_)
	{
		active = true;
		wait = false;
		textRunDone = false;
		combatText.resetText("你想要買奇怪的柴犬幣嗎？");
		combatText.start(false, false, function()
		{
			textRunDone = true;
			pointer.visible = true;
		});
	}

	// 淡出後再停用hud，也停止更新
	function finishFadeOut(_)
	{
		combatText.resetText("  ");
		combatText.start(false, false, function()
		{
			visible = false;
			active = false;
		});
	}

	override public function update(elapsed:Float)
	{
		if (!wait) // 如果在等待的話就不要更新按鍵狀態(也就是不能用按鍵)
		{
			updateKeyboardInput();
		}
		super.update(elapsed);
	}

	function updateKeyboardInput()
	{
		// 看看哪個按鍵被按下的變數
		var up:Bool = false;
		var down:Bool = false;
		var fire:Bool = false;

		if (FlxG.keys.anyJustReleased([SPACE, X, ENTER]))
		{
			fire = true;
		}
		else if (FlxG.keys.anyJustReleased([W, UP]))
		{
			up = true;
		}
		else if (FlxG.keys.anyJustReleased([S, DOWN]))
		{
			down = true;
		}

		// 根據按鍵做不同反應
		if (fire)
		{
			makeChoice(); // 我們選擇完成後會啟動的功能
		}
		else if (up || down)
		{
			// 如果按上下鍵就移動箭頭，如果本來在YES就變成NO，反之
			// 聰明的寫法
			selected = if (selected == YES) NO else YES;
			movePointer();
		}
	}

	// 傳說中的movePointer
	// 直接指定箭頭到選項的y座標，聰明
	function movePointer()
	{
		pointer.y = choices[selected].y + (choices[selected].height / 2) - 16;
	}

	// 選擇完成後，根據選中內容做出反應
	function makeChoice()
	{
		pointer.visible = false;
		switch (selected)
		{
			case YES:
				// 如果我們選擇打架，我們會有85%的機率可以打中敵人
				choice = YES;
				doneResultsIn();

			case NO:
				choice = NO;
				doneResultsIn();
		}
		// 在這些事發生時我們要讓玩家等待，以免出錯
		wait = true;
	}

	// 如果結果淡入完成玩家又沒被打敗，就淡出整的打架介面
	function doneResultsIn()
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circOut, onComplete: finishFadeOut}, updateAlpha);
	}
}
