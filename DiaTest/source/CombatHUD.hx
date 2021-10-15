package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Matrix;
import openfl.geom.Point;

using flixel.util.FlxSpriteUtil; // drawRect需要這個

// 傳說中的500行程式
// 我一直很好奇，到底要怎麼做，才能讓我們在打架介面按方向鍵時，操控的角色不會跟著動？
// 或者事實上按鍵一次只能做一件事？
// 我後來找到了，在PlayState裡的startCombat功能有一條player.active  =  false，就這樣呵呵
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

	// 這些是hud的素材
	var background:FlxSprite; // 背景
	var playerSprite:Player; // 玩家
	var enemySprite:Enemy; // 敵人

	// 敵人的血量
	var enemyHealth:Int;
	var enemyMaxHealth:Int;
	var enemyHealthBar:FlxBar; // 告訴我們敵人目前血量和最高血量

	var playerHealthCounter:FlxText; // 玩家的目前血量和最高血量

	var damages:Array<FlxText>; // 這陣列裡有2筆資料：0是玩家被傷害值；1是敵人被傷害值

	var pointer:FlxSprite; // 那個選擇打或逃的箭頭
	var selected:Choice; // 我們選的打還是逃(前面那的enum的Choice)
	var choices:Map<Choice, FlxText>; // 這個地圖把打或逃的選項變成文字(應該吧)

	var results:FlxText; // 顯示結果的文字

	var alpha:Float = 0; // 淡入淡出的效果，alpha就是透明度啦
	var wait:Bool = true; // 當我們不准玩家動時就把這個設為true

	// 聲音們
	var fledSound:FlxSound;
	var hurtSound:FlxSound;
	var loseSound:FlxSound;
	var missSound:FlxSound;
	var selectSound:FlxSound;
	var winSound:FlxSound;
	var combatSound:FlxSound;

	public function new()
	{
		super();

		// hud的背景，黑底白邊，經典！畫完就加到群組
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
		enemySprite.animation.frameIndex = 3;
		enemySprite.active = false;
		enemySprite.facing = FlxObject.LEFT;
		add(enemySprite);

		// 加入玩家的血量
		playerHealthCounter = new FlxText(playerSprite.x, playerSprite.y + playerSprite.height, "3/3", 16);
		playerHealthCounter.color = 0xff2D5925;
		playerHealthCounter.alignment = CENTER;
		add(playerHealthCounter);

		// 加入敵人的血量條
		enemyHealthBar = new FlxBar(enemySprite.x + 12, playerHealthCounter.y, LEFT_TO_RIGHT, 40, 20);
		enemyHealthBar.createFilledBar(0xffdc143c, FlxColor.YELLOW, true, FlxColor.YELLOW);
		add(enemyHealthBar);

		// 加入選項
		choices = new Map();
		choices[FIGHT] = new FlxText(background.x + 60, background.y + 96, 170, "FIGHT", 44);
		choices[FIGHT].color = 0xff2D5925;
		choices[FLEE] = new FlxText(background.x + 60, choices[FIGHT].y + choices[FIGHT].height + 16, 170, "FLEE", 44);
		choices[FLEE].color = 0xff2D5925;
		add(choices[FIGHT]);
		add(choices[FLEE]);

		// 那隻箭頭
		pointer = new FlxSprite(background.x + 40, choices[FIGHT].y + (choices[FIGHT].height / 2) - 16, AssetPaths.combatPointer__png);
		pointer.visible = false;
		add(pointer);

		// 扣血的字樣
		damages = new Array<FlxText>();
		damages.push(new FlxText(0, 0, 80, 16));
		damages.push(new FlxText(0, 0, 80, 16));
		for (d in damages) // d應該是for迴圈裡的i吧
		{
			d.color = FlxColor.WHITE;
			d.setBorderStyle(SHADOW, FlxColor.RED);
			d.alignment = CENTER;
			d.visible = false;
			add(d);
		}

		// 加入結果的字樣
		results = new FlxText(background.x + 4, background.y + 18, 232, "", 36);
		results.alignment = CENTER;
		results.color = FlxColor.YELLOW;
		results.setBorderStyle(SHADOW, FlxColor.GRAY);
		results.visible = false;
		add(results);

		// 像是HUD那樣，就算攝影機動還是待在原處
		// 注意這裡的括號啊！啊！
		// 我上次搞錯結果vscode就不幫我排版了
		forEach(function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
			sprite.alpha = 0;
		});
		// 在我們叫打架畫面前這些東西都不要出現，也不要亂動
		active = false;
		visible = false;

		// 播爆聲音
		fledSound = FlxG.sound.load(AssetPaths.fled__wav);
		hurtSound = FlxG.sound.load(AssetPaths.hurt__wav);
		loseSound = FlxG.sound.load(AssetPaths.lose__wav);
		missSound = FlxG.sound.load(AssetPaths.miss__wav);
		selectSound = FlxG.sound.load(AssetPaths.select__wav);
		winSound = FlxG.sound.load(AssetPaths.win__wav);
		combatSound = FlxG.sound.load(AssetPaths.combat__wav);
	}

	/**
		*當打架開始時PlayerState會啟動這兩個功能。這會架好螢幕，讓一切都準備好
		*@param playerHealth 玩家一開始有多少血
		*@param enemy 我們打的是哪種敵人，這樣才能叫出正確的血量跟類型
	 */
	public function initCombat(playerHealth:Int, enemy:Enemy)
	{
		// 音樂請下
		combatSound.play();

		this.playerHealth = playerHealth; // 把這裡的玩家生命值設成我們在別地方拿到的玩家生命值
		this.enemy = enemy; // 把這裡的敵人設成我們在別地方拿到的敵人

		updatePlayerHealth();

		// 設定敵人
		enemyMaxHealth = enemyHealth = if (enemy.type == REGULAR) 2 else 4;
		enemyHealthBar.value = 100; // 敵人的血量一開始是100%
		enemySprite.changeType(enemy.type); // 換成普通敵人或是魔王

		// 確定這些東西即使在我們之後來也不會亂動或亂出現
		wait = true;
		results.text = "";
		pointer.visible = false;
		results.visible = false;
		outcome = NONE;
		selected = FIGHT;
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
		pointer.visible = true;
		selectSound.play();
	}

	// 淡出後再停用hud，也停止更新
	function finishFadeOut(_)
	{
		active = false;
		visible = false;
	}

	// 更新玩家的血量
	function updatePlayerHealth()
	{
		playerHealthCounter.text = playerHealth + " / 3";
		// playerHealthCounter.x = playerSprite.x + 8 - (playerHealthCounter.width / 2);
	}

	override public function update(elapsed:Float)
	{
		if (!wait) // 如果在等待的話就不要更新按鍵狀態(也就是不能用按鍵)
		{
			updateKeyboardInput();
			updateTouchInput();
		}
		super.update(elapsed);
	}

	function updateKeyboardInput()
	{
		#if FLX_KEYBOARD
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
			selectSound.play();
			makeChoice(); // 我們選擇完成後會啟動的功能
		}
		else if (up || down)
		{
			// 如果按上下鍵就移動箭頭，如果本來在FIGHT就變成FLEE，反之
			// 聰明的寫法
			selected = if (selected == FIGHT) FLEE else FIGHT;
			selectSound.play();
			movePointer();
		}
		#end
		// 如果沒打#end vs會亂排版喔
		// 什麼時後C++開始用井字號了
		// 我以為這只是加搞笑的
		// 我後來查了一下，有#的if只有在條件符合時才會編譯
		// 效率100
	}

	function updateTouchInput()
	{
		// 如果是手機版就看看選項有沒有被點
		#if FLX_TOUCH
		for (touch in FlxG.touches.justReleased())
		{
			for (choice in choices.keys())
			{
				var text = choices[choice];
				if (touch.overlaps(text))
				{
					selected = choice;
					movePointer();
					makeChoice();
					return;
				}
			}
		}
		#end
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
			case FIGHT:
				// 如果我們選擇打架，我們會有85%的機率可以打中敵人
				if (FlxG.random.bool(85))
				{
					// 如果打中了，敵人會扣1滴血
					// damage[0]是玩家；damage[1]是敵人
					damages[1].text = "1";
					// 敵人左右搖晃
					FlxTween.tween(enemySprite, {x: enemySprite.x + 8}, 0.1, {
						onComplete: function(_)
						{
							FlxTween.tween(enemySprite, {x: enemySprite.x - 8}, 0.1);
						}
					});
					hurtSound.play();
					enemyHealth--;
					enemyHealthBar.value = (enemyHealth / enemyMaxHealth) * 100; // 改變敵人的血量條
				}
				else
				{
					// 如果我們打偏了就把扣血字樣改成miss
					damages[1].text = "MISS!";
					missSound.play();
				}

				// 把扣血字樣移到敵人上，把alpha(透明度)設成0，但可見度是真，這樣我們才能呼喚他們
				damages[1].x = enemySprite.x + enemySprite.width / 2 - (damages[1].width / 2);
				damages[1].y = enemySprite.y + enemySprite.height / 2 - (damages[1].height / 2);
				damages[1].alpha = 0;
				damages[1].visible = true;

				// 如果敵人還活著的話他會歐你
				if (enemyHealth > 0)
				{
					enemyAttack();
				}
				// 扣血字樣的淡入跟漂浮在玩家上
				FlxTween.num(damages[0].y, damages[0].y - 24, 1, {ease: FlxEase.circOut}, updateDamageY);
				FlxTween.num(0, 1, .2, {ease: FlxEase.circInOut, onComplete: doneDamageIn}, updateDamageAlpha);

			case FLEE:
				// 玩家有50%的機率可以逃跑
				if (FlxG.random.bool(50))
				{
					// 如果成功了就會淡入逃跑成功的字樣
					outcome = ESCAPE;
					results.text = "ESCAPED!";
					fledSound.play();
					results.visible = true;
					results.alpha = 0;
					FlxTween.tween(results, {alpha: 1}, .66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
				}
				else
				{
					// 如果逃跑失敗敵人就會歐你
					enemyAttack();
					FlxTween.num(damages[0].y, damages[0].y - 24, 1, {ease: FlxEase.circOut}, updateDamageY);
					FlxTween.num(0, 1, .2, {ease: FlxEase.circInOut, onComplete: doneDamageIn}, updateDamageAlpha);
				}
		}
		// 在這些事發生時我們要讓玩家等待，以免出錯
		wait = true;
	}

	// 敵人攻擊的功能
	function enemyAttack()
	{
		// 敵人有30%的機率可以歐中玩家
		if (FlxG.random.bool(30))
		{
			FlxG.camera.flash(FlxColor.WHITE, .2); // 螢幕變白
			FlxG.camera.shake(0.01, 0.2); // 螢幕搖晃
			hurtSound.play();
			damages[0].text = "1";
			playerHealth--;
			updatePlayerHealth();
		}
		else
		{
			// 敵人如果miss的話就顯示miss
			damages[0].text = "MISS!";
			missSound.play();
		}

		// 把扣血字樣移到玩家身上，把alpha(透明度)設成0，但可見度是真，這樣我們才能呼喚他們
		damages[0].x = playerSprite.x + playerSprite.width / 2 - (damages[0].width / 2);
		damages[0].y = playerSprite.y + playerSprite.height / 2 - (damages[0].height / 2);
		damages[0].alpha = 0;
		damages[0].visible = true;
	}

	// 移動扣血字樣的功能
	function updateDamageY(damageY:Float)
	{
		damages[0].y = damages[1].y = damageY;
	}

	// 淡入淡出扣血字樣的功能
	function updateDamageAlpha(damageAlpha:Float)
	{
		damages[0].alpha = damages[1].alpha = damageAlpha;
	}

	// 這是傷害值完成淡入後會啟動的功能，暫停一下後會讓傷害值淡出
	function doneDamageIn(_)
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circInOut, startDelay: 1, onComplete: doneDamageOut}, updateDamageAlpha);
	}

	// 如果結果淡入完成玩家又沒被打敗，就淡出整的打架介面
	function doneResultsIn(_)
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circOut, onComplete: finishFadeOut, startDelay: 1}, updateAlpha);
	}

	// 當傷害值完成淡出後會啟動的功能。傷害值會被清空，還有接下來要做什麼。
	// 如果敵人死了就呼叫勝利；如果玩家死了就呼叫被擊敗，如果都沒有就呼叫下一回合
	function doneDamageOut(_)
	{
		damages[0].visible = false;
		damages[1].visible = false;
		damages[0].text = "";
		damages[1].text = "";

		if (playerHealth <= 0)
		{
			// 如果玩家死了我們就淡入被擊敗消息
			outcome = DEFEAT;
			loseSound.play();
			results.text = "DEFEAT!";
			results.visible = true;
			results.alpha = 0;
			FlxTween.tween(results, {alpha: 1}, 0.66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
		}
		else if (enemyHealth <= 0)
		{
			// 如果敵人死了我們就顯示勝利消息
			outcome = VICTORY;
			winSound.play();
			results.text = "VICTORY!";
			results.visible = true;
			results.alpha = 0;
			FlxTween.tween(results, {alpha: 1}, 0.66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
		}
		else
		{
			// 如果兩邊都還活著就清空一切並且讓玩家選擇下一個動作
			wait = false;
			pointer.visible = true;
		}
	}
}
