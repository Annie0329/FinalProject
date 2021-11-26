package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;

using flixel.util.FlxSpriteUtil; // drawRect需要這個

// 打架的結果
enum Outcome
{
	WIN;
	LOSE;
	FLEE;
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

	// 這些是hud的素材
	var background:FlxSprite; // 背景
	var enemySprite:Enemy; // 敵人

	var pointer:FlxSprite; // 那個選擇打或逃的箭頭
	var selected:Choice; // 我們選的打還是逃(前面那的enum的Choice)
	var choices:Map<Choice, FlxText>; // 這個地圖把打或逃的選項變成文字(應該吧)

	var pointerRight:FlxSprite;
	var pointerLeft:FlxSprite;

	public var outcome:Outcome; // 結果

	var state:Int = 1;

	// 文字組
	var combatText:Text;
	var dilog_boxes:Array<String>;
	var name:String;
	var txt:Bool = true;
	var textRunDone:Bool = false;
	var investNumText:FlxText;
	var textIn:Bool = false;

	var nftStyle:FlxSprite;
	var nftStyleNum:Int = 0;

	var investNum:Int = 5;

	var enemyNameText:FlxText;
	var diamondText:FlxText;

	public var diamondUiText:FlxText;

	public var diamond:Int = 0;

	var alpha:Float = 0; // 淡入淡出的效果，alpha就是透明度啦
	var wait:Bool = true; // 當我們不准玩家動時就把這個設為true

	public function new()
	{
		super();

		// hud的背景
		background = new FlxSprite(0, 0, AssetPaths.combatBackground__png);
		add(background);

		// 加入敵人的人形立牌
		enemySprite = new Enemy(0, 100, shibaCoin);
		enemySprite.screenCenter(FlxAxes.X);
		// enemySprite.animation.frameIndex = 3;
		enemySprite.active = false;
		// enemySprite.facing = FlxObject.LEFT;
		add(enemySprite);

		// 字
		combatText = new Text(110, 220, 270, "text", 24, true);
		add(combatText);

		// 加入選項
		choices = new Map();
		choices[YES] = new FlxText(425, 225, 170, "APE IN", 36);
		choices[NO] = new FlxText(425, choices[YES].y + choices[YES].height + 16, 170, "QUIT", 36);
		add(choices[YES]);
		add(choices[NO]);

		// 投資多少錢
		investNumText = new FlxText(choices[YES].x, choices[YES].y, 170, "5", 44);
		add(investNumText);
		investNumText.alignment = CENTER;
		investNumText.visible = false;

		nftStyle = new FlxSprite(choices[YES].x + choices[YES].width / 2, choices[YES].y).loadGraphic(AssetPaths.nft__png, true, 56, 64);
		nftStyle.animation.frameIndex = 0;
		add(nftStyle);
		nftStyle.visible = false;

		// 敵人名字
		enemyNameText = new FlxText(70, 20, "enemyName", 36);
		enemyNameText.font = AssetPaths.silver__ttf;
		add(enemyNameText);

		// 錢的數量
		diamondText = new FlxText(560, 20, "0", 20);
		add(diamondText);

		// 那隻箭頭
		pointer = new FlxSprite(choices[YES].x - 16, choices[YES].y + (choices[YES].height / 2) - 16, AssetPaths.pointer__png);
		pointer.visible = false;
		add(pointer);

		pointerLeft = new FlxSprite(0, 0, AssetPaths.pointer__png);
		pointerLeft.flipX = true;
		add(pointerLeft);

		pointerRight = new FlxSprite(0, 0, AssetPaths.pointer__png);
		add(pointerRight);

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
		*@param diamond
		*@param diamondUiText
		*@param enemy 我們打的是哪種敵人，這樣才能叫出正確的類型

	 */
	// 準備介面
	public function initCombat(diamond:Int, diamondUiText:FlxText, enemy:Enemy)
	{
		this.enemy = enemy; // 把這裡的敵人設成我們在別地方拿到的敵人
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		diamondText.text = Std.string(diamond);

		enemySprite.changeType(enemy.type); // 換成普通敵人或是魔王

		// 確定這些東西即使在我們之後來也不會亂動或亂出現
		wait = true;
		pointer.visible = false;
		selected = YES;
		movePointer();
		choices[YES].visible = true;
		choices[NO].visible = true;

		investNum = 5;
		investNumText.text = Std.string(investNum);

		pointerLeft.visible = false;
		pointerRight.visible = false;
		switch (enemy.type)
		{
			case shibaCoin:
				enemyNameText.text = "柴犬幣";
				combatText.resetText(":要不要買點狗狗幣啊？:誰不喜歡可愛的狗狗呢？");
			case cloudMiner:
				enemyNameText.text = "雲挖礦";
				combatText.resetText("哈囉~猩猩，只要你付給我5能量幣，就可以租到一台高效率機器幫你挖礦賺大錢喔！快來加入我吧！");
			case nft:
				enemyNameText.text = "NFT";
				combatText.resetText("要不要買些特別的圖像啊？這些獨一無二的藝術品可以留著珍藏也可以拿去商店賣，如果是爆紅款式還可以賣出天價喔！");
			case spartanMiner:
		}

		state = 1;
		visible = true; // 讓打架介面出現

		// 應該是淡入的效果
		FlxTween.num(0, 1, .66, {ease: FlxEase.circOut, onComplete: finishFadeIn}, updateAlpha);
	}

	// 淡入後就啟用hud
	function finishFadeIn(_)
	{
		active = true;
		wait = false;
		textRunDone = false;

		combatText.start(false, false, function()
		{
			textRunDone = true;
			pointer.visible = true;
		});
	}

	function updateKeyboardInput()
	{
		// 看看哪個按鍵被按下的變數
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var fire:Bool = false;

		if (FlxG.keys.anyJustReleased([SPACE, X, ENTER]))
			fire = true;
		else if (FlxG.keys.anyJustReleased([W, UP]))
			up = true;
		else if (FlxG.keys.anyJustReleased([S, DOWN]))
			down = true;
		else if (FlxG.keys.anyJustReleased([A, LEFT]))
			left = true;
		else if (FlxG.keys.anyJustReleased([D, RIGHT]))
			right = true;

		// 根據按鍵做不同反應
		if (fire)
		{
			// 柴犬幣
			if (enemy.type == shibaCoin)
			{
				if (state == 1)
				{
					state++;
					pointer.visible = false;
					switch (selected)
					{
						case YES:
							textRunDone = false;
							choices[YES].visible = false;
							choices[NO].visible = false;
							investNumText.visible = true;
							lrPointer(investNumText.x, investNumText.y, investNumText.width, investNumText.height);

							combatText.resetText("請選擇你要投資多少？最少5能量幣。好了就按enter。");
							combatText.start(false, false, function()
							{
								textRunDone = true;
							});

						case NO:
							outcome = FLEE;
							doneResultsIn();
					}
				}
				else if (state == 2)
				{
					state++;
					if (FlxG.random.bool(70))
					{
						diamond += investNum;
						combatText.resetText("你賺到" + Std.string(investNum) + "能量幣！");
						outcome = WIN;
					}
					else
					{
						diamond -= investNum;
						combatText.resetText("狗狗幣虧了。你什麼都沒得到。");
						outcome = LOSE;
					}
					combatText.start(false, false);
					investNumText.visible = false;
					pointerLeft.visible = false;
					pointerRight.visible = false;
					diamondText.text = Std.string(diamond);
				}
				else if (state == 3)
					doneResultsIn();
			}
			// 雲挖礦
			else if (enemy.type == cloudMiner)
			{
				if (state == 1)
				{
					state++;
					switch (selected)
					{
						case YES:
							diamond += 5;
							textRunDone = false;
							combatText.resetText("我沒騙你吧！馬上就賺到能量幣了。你想再多租幾台嗎？這次你出20能量幣就會有7台機器幫你挖礦賺錢喔！");
							combatText.start(false, false, function()
							{
								textRunDone = true;
							});

						case NO:
							outcome = FLEE;
							combatText.resetText("唉！你這隻蠢猩猩，都不懂得把握機會賺大錢。");
							combatText.start(false, false, function()
							{
								textRunDone = true;
							});
					}
				}
				else if (state == 2)
				{
					state++;
					if (outcome == FLEE)
						doneResultsIn();
					else
					{
						switch (selected)
						{
							case YES:
								diamond -= 20;
								textRunDone = false;
								combatText.resetText("真是隻傻猩猩啊，這些錢我就收下了，嘿嘿嘿！");
								combatText.start(false, false, function()
								{
									textRunDone = true;
								});
								outcome = LOSE;

							case NO:
								combatText.resetText("唉！你這隻蠢猩猩，都不懂得把握機會賺大錢。");
								combatText.start(false, false, function()
								{
									textRunDone = true;
								});
								outcome = FLEE;
						}
					}
				}
				else if (state == 3)
					doneResultsIn();
			}

			// NFT
			else if (enemy.type == nft)
			{
				if (state == 1)
				{
					state++;
					pointer.visible = false;
					switch (selected)
					{
						case YES:
							textRunDone = false;
							choices[YES].visible = false;
							choices[NO].visible = false;
							nftStyle.visible = true;
							lrPointer(nftStyle.x, nftStyle.y, 56, nftStyle.height);

							combatText.resetText("選一個花樣吧。按左右鍵查看花樣。");
							combatText.start(false, false, function()
							{
								textRunDone = true;
							});

						case NO:
							outcome = FLEE;
							doneResultsIn();
					}
				}
				else if (state == 2)
				{
					state++;
					nftStyle.visible = false;
					pointerLeft.visible = false;
					pointerRight.visible = false;

					if (FlxG.random.bool(50))
					{
						diamond += 20;
						combatText.resetText("哇！立刻有人用高價買你的NFT了！");
						outcome = WIN;
					}
					else
					{
						diamond -= 20;
						combatText.resetText("這張NFT沒人想買呢。");
						outcome = LOSE;
					}

					combatText.start(false, false);
				}
				else if (state == 3)
					doneResultsIn();
			}
			diamondText.text = Std.string(diamond);
			diamondUiText.text = Std.string(diamond);
		}
		else if (up || down)
		{
			// 如果按上下鍵就移動箭頭，如果本來在YES就變成NO，反之
			// 聰明的寫法
			selected = if (selected == YES) NO else YES;
			movePointer();
		}
		else if (left || right)
		{
			if (investNumText.visible)
			{
				if (left && investNum != 5)
					investNum -= 5;
				else if (right) // && investNum / 5 != Std.int(diamond / 5))
					investNum += 5;
				investNumText.text = Std.string(investNum);
			}
			else if (nftStyle.visible)
			{
				if (left)
				{
					if (nftStyleNum == 0)
						nftStyleNum = 2;
					else
						nftStyleNum--;
				}
				else if (right)
				{
					if (nftStyleNum == 2)
						nftStyleNum = 0;
					else
						nftStyleNum++;
				}
				nftStyle.animation.frameIndex = nftStyleNum;
			}
		}
	}

	// 傳說中的movePointer
	// 直接指定箭頭到選項的y座標，聰明
	function movePointer()
	{
		pointer.y = choices[selected].y + (choices[selected].height / 2) - 16;
	}

	function lrPointer(spriteX:Float, spriteY:Float, spriteW:Float, spriteH:Float)
	{
		pointerLeft.visible = true;
		pointerLeft.setPosition(spriteX - pointerLeft.width, spriteY + spriteH / 2 - 10);
		pointerRight.visible = true;
		pointerRight.setPosition(spriteX + spriteW, spriteY + spriteH / 2 - 10);
	}

	// 召喚淡入淡出的效果
	function updateAlpha(alpha:Float)
	{
		this.alpha = alpha;
		forEach(function(sprite) sprite.alpha = alpha);
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

	// 更新啦
	override public function update(elapsed:Float)
	{
		updateKeyboardInput();

		super.update(elapsed);
	}

	// 離開打架介面
	function doneResultsIn()
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circOut, onComplete: finishFadeOut}, updateAlpha);
	}
}
