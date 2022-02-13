package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.debug.completion.CompletionListScrollBar;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

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

	var pointer:Pointer; // 那個選擇打或逃的箭頭
	var choices:Map<Choice, FlxText>; // 這個地圖把打或逃的選項變成文字(應該吧)
	var ynCho:Array<String> = ["YES", "NO"];

	var pointerRight:FlxSprite;
	var pointerLeft:FlxSprite;

	public var outcome:Outcome; // 結果

	var state:Int = 1;

	// 文字組
	var combatText:Text;
	var dilog_boxes:Array<String>;
	var name:String;
	var txt:Bool = true;
	var textIn:Bool = false;

	// NFT
	var nftStyle:FlxSprite;

	public var nftStyleNum:Int = 0;

	// 槓桿
	var rodTalk:Bool = false;
	var rodNum:Int = 2;
	var rodNumText:FlxText;

	public var appleRod:Float; // 槓桿賺了多少蘋果幣
	public var bananaCoin:Float;
	public var appleCoin:Float;

	// ApeStarter
	var starterPrize:Int = 5;

	public var touchStarter:Bool = false; // 有沒有碰過ApeStarter

	// 投資
	public var investNum:Int = 5;

	var investNumText:FlxText;

	// UI
	var enemyNameText:FlxText;
	var diamondText:FlxText;

	public var diamondUiText:FlxText;
	public var diamond:Float = 0;

	var alpha:Float = 0; // 淡入淡出的效果，alpha就是透明度啦
	var wait:Bool = true; // 當我們不准玩家動時就把這個設為true

	public function new()
	{
		super();

		// hud的背景
		background = new FlxSprite(0, 0, AssetPaths.combatBackground__png);
		add(background);

		// 加入敵人的人形立牌
		enemySprite = new Enemy(0, 300, shibaCoin);
		enemySprite.screenCenter(FlxAxes.X);
		enemySprite.animation.frameIndex = 0;
		enemySprite.active = false;
		add(enemySprite);

		// 字
		combatText = new Text(330, 660, 810, "text", 72, true);
		add(combatText);

		// 加入選項
		choices = new Map();
		choices[YES] = new FlxText(1275, 675, 510, "APE IN", 108);
		choices[NO] = new FlxText(choices[YES].x, choices[YES].y + choices[YES].height + 48, 510, "QUIT", 108);
		add(choices[YES]);
		add(choices[NO]);

		// 投資多少錢
		investNumText = new FlxText(choices[YES].x, choices[YES].y, 510, "5", 132);
		add(investNumText);
		investNumText.alignment = CENTER;
		investNumText.visible = false;

		// 槓桿多少倍
		rodNumText = new FlxText(choices[YES].x, choices[YES].y, 510, "2", 132);
		add(rodNumText);
		rodNumText.alignment = CENTER;
		rodNumText.color = FlxColor.YELLOW;
		rodNumText.visible = false;

		// nft花樣選擇圖示
		nftStyle = new FlxSprite(choices[YES].x + choices[YES].width / 2, choices[YES].y).loadGraphic(AssetPaths.nft__png, true, 168, 192);
		nftStyle.animation.frameIndex = 0;
		add(nftStyle);
		nftStyle.visible = false;

		// 敵人名字
		enemyNameText = new FlxText(210, 60, 0, "enemyName", 108);
		enemyNameText.font = AssetPaths.silver__ttf;
		add(enemyNameText);

		// 錢的數量
		diamondText = new FlxText(1650, 60, 0, "0", 60);
		add(diamondText);

		// 那隻箭頭
		pointer = new Pointer();
		pointer.setPointer(choices[YES].x - 48, choices[YES].y + (choices[YES].height / 2) - 48, Std.int(choices[YES].height + 48), ynCho, "ud");
		pointer.visible = false;
		add(pointer);

		// 左右箭頭
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
		*@param bananaCoin
		*@param enemy 我們打的是哪種敵人，這樣才能叫出正確的類型

	 */
	// 準備介面
	public function initCombat(diamond:Float, diamondUiText:FlxText, bananaCoin:Float, appleCoin:Float, enemy:Enemy)
	{
		this.enemy = enemy; // 把這裡的敵人設成我們在別地方拿到的敵人
		this.diamond = diamond;
		this.diamondUiText = diamondUiText;
		this.bananaCoin = bananaCoin;
		this.appleCoin = appleCoin;
		diamondText.text = Std.string(diamond);

		enemySprite.changeType(enemy.type); // 換成普通敵人或是魔王

		// 確定這些東西即使在我們之後來也不會亂動或亂出現
		wait = true;
		pointer.setPosition(choices[YES].x - 48, choices[YES].y + (choices[YES].height / 2) - 48);
		pointer.visible = false;

		choices[YES].visible = true;
		choices[NO].visible = true;

		investNum = 5;
		investNumText.text = Std.string(investNum);

		pointerLeft.visible = false;
		pointerRight.visible = false;
		switch (enemy.type)
		{
			case shibaCoin:
				enemyNameText.text = "狗狗幣";
				name = ":嘿，猩猩！要不要買點可愛的狗狗幣啊？:誰不喜歡又可愛又能賺錢的狗狗幣呢？";
				txt = false;
			case cloudMiner:
				enemyNameText.text = "雲挖礦";
				name = ":哈囉~猩猩，只要你付給我 5 能量幣，:就可以租到一台高效率機器幫你挖礦賺大錢喔！快來加入我吧！";
				txt = false;
			case nft:
				enemyNameText.text = "NFT";
				name = ":要買一張嗎？:這些獨一無二的藝術品可以留著珍藏或是賣錢，爆紅的款式還能賣出天價喔！";
				txt = false;
			case rod:
				enemyNameText.text = "槓桿";
				if (rodTalk)
				{
					name = ":你要開槓桿用香蕉幣買APS幣嗎？";
					txt = false;
				}
				else
				{
					name = AssetPaths.rodTalk__txt;
					txt = true;
					rodTalk = true;
				}
			case starter:
				enemyNameText.text = "APESTARTER";
				if (appleCoin == 0)
				{
					name = AssetPaths.starterTalk__txt;
					txt = true;
					if (touchStarter)
						starterPrize = 2;
					else
						touchStarter = true;
				}
				else if (touchStarter)
				{
					name = ":要不要投資新項目？";
					txt = false;
				}
			case spartanMiner:
		}
		combatText.show(name, txt);

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
	}

	function updateKeyboardInput()
	{
		// diamondText.text = Std.string(combatText.over);
		// 看看哪個按鍵被按下的變數
		var left:Bool = false;
		var right:Bool = false;
		var fire:Bool = false;

		if (FlxG.keys.anyJustReleased([SPACE, X, ENTER]))
			fire = true;
		else if (FlxG.keys.anyJustReleased([A, LEFT]))
			left = true;
		else if (FlxG.keys.anyJustReleased([D, RIGHT]))
			right = true;

		// 根據按鍵做不同反應
		if (fire)
		{
			// 狗狗幣
			if (enemy.type == shibaCoin)
			{
				if (state == 1)
				{
					if (combatText.over && !pointer.visible)
					{
						pointer.visible = true;
					}
					else if (pointer.visible)
					{
						state++;
						pointer.visible = false;
						switch (pointer.selected)
						{
							case "YES":
								choices[YES].visible = false;
								choices[NO].visible = false;
								investNumText.visible = true;
								lrPointer(investNumText.x, investNumText.y, investNumText.width, investNumText.height);

								name = ":請選擇你要投資多少？最少 5 能量幣。好了就按enter。";
								combatText.show(name, false);

							case "NO":
								outcome = FLEE;
								doneResultsIn();
						}
					}
				}
				else if (state == 2)
				{
					state++;

					diamond -= investNum;
					name = ":謝謝你！如果想賣掉狗狗幣的話可以去商店喔。";
					outcome = WIN;

					combatText.show(name, false);
					investNumText.visible = false;
					pointerLeft.visible = false;
					pointerRight.visible = false;
				}
				else if (state == 3)
					doneResultsIn();
			}
			// 雲挖礦
			else if (enemy.type == cloudMiner)
			{
				if (state == 1)
				{
					// 對話跑完箭頭才出現
					if (combatText.over && !pointer.visible)
						pointer.visible = true;
					else if (pointer.visible)
					{
						state++;
						pointer.visible = false;
						switch (pointer.selected)
						{
							case "YES":
								diamond += 5;
								name = ":我沒騙你吧！馬上就賺到能量幣了。:你想再多租幾台嗎？這次你出 20 能量幣就會有7台機器幫你挖礦賺錢喔！";
								outcome = LOSE;

							case "NO":
								choices[YES].visible = false;
								choices[NO].visible = false;
								pointer.visible = false;
								name = ":唉！你這隻蠢猩猩，都不懂得把握機會賺大錢。";
								outcome = FLEE;
						}
						combatText.show(name, false);
					}
				}
				else if (state == 2)
				{
					if (outcome == FLEE)
					{
						state++;
						doneResultsIn();
					}
					else
					{
						if (combatText.over && !pointer.visible)
							pointer.visible = true;
						else if (pointer.visible)
						{
							state++;
							choices[YES].visible = false;
							choices[NO].visible = false;
							pointer.visible = false;
							switch (pointer.selected)
							{
								case "YES":
									diamond -= 20;
									name = ":真是隻傻猩猩啊，這些錢我就收下了，嘿嘿嘿！";

									outcome = LOSE;

								case "NO":
									name = ":唉！你這隻蠢猩猩，都不懂得把握機會賺大錢。";
									outcome = FLEE;
							}
							combatText.show(name, false);
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
					if (combatText.over && !pointer.visible)
					{
						pointer.visible = true;
					}
					else if (pointer.visible)
					{
						state++;
						pointer.visible = false;
						switch (pointer.selected)
						{
							case "YES":
								choices[YES].visible = false;
								choices[NO].visible = false;
								nftStyle.visible = true;
								lrPointer(nftStyle.x, nftStyle.y, 168, nftStyle.height);

								name = ":選一個花樣吧。按左右鍵查看花樣。";
								combatText.show(name, false);
							case "NO":
								outcome = FLEE;
								doneResultsIn();
						}
					}
				}
				else if (state == 2)
				{
					state++;

					diamond -= investNum;
					name = ":謝謝你！如果想賣掉NFT的話可以去商店喔。";
					outcome = WIN;

					combatText.show(name, false);
					investNumText.visible = false;
					pointerLeft.visible = false;
					pointerRight.visible = false;
					nftStyle.visible = false;
				}
				else if (state == 3)
					doneResultsIn();
			}
			// 槓桿
			else if (enemy.type == rod)
			{
				if (state == 1)
				{
					if (combatText.over && !pointer.visible)
					{
						pointer.visible = true;
					}
					else if (pointer.visible)
					{
						state++;
						pointer.visible = false;
						switch (pointer.selected)
						{
							case "YES":
								choices[YES].visible = false;
								choices[NO].visible = false;
								investNumText.visible = true;
								lrPointer(investNumText.x, investNumText.y, investNumText.width, investNumText.height);

								name = ':你現在有$bananaCoin 香蕉幣。請選擇你要投資多少？最少 5 香蕉幣。好了就按enter。';
								combatText.show(name, false);

							case "NO":
								outcome = FLEE;
								doneResultsIn();
						}
					}
				}
				else if (state == 2)
				{
					state++;
					investNumText.visible = false;
					rodNum = 2;
					rodNumText.text = Std.string(rodNum);
					rodNumText.visible = true;

					name = ":請選擇你槓桿多少倍？好了就按enter。";
					combatText.show(name, false);
				}
				else if (state == 3)
				{
					state++;
					rodNumText.visible = false;
					pointerLeft.visible = false;
					pointerRight.visible = false;
					if (FlxG.random.bool(40))
					{
						appleRod += investNum * rodNum;
						appleCoin += appleRod;
						name = ':你得到 $appleRod APS幣！';
						outcome = WIN;
					}
					else
					{
						name = ":你什麼都沒得到。";
						outcome = LOSE;
					}

					bananaCoin -= investNum;
					combatText.show(name, false);
				}
				else if (state == 4)
					doneResultsIn();
			}
			// ApeStarter
			if (enemy.type == starter)
			{
				if (appleCoin == 0) // 沒有蘋果幣就問要不要買蘋果幣
				{
					if (state == 1)
					{
						if (combatText.over && !pointer.visible)
						{
							pointer.visible = true;
						}
						else if (pointer.visible)
						{
							state++;
							pointer.visible = false;
							switch (pointer.selected)
							{
								case "YES":
									choices[YES].visible = false;
									choices[NO].visible = false;
									investNumText.visible = true;
									lrPointer(investNumText.x, investNumText.y, investNumText.width, investNumText.height);

									name = ':請選擇你要投資多少？最少 5 能量幣。現在 1 能量幣可以買 $starterPrize APS幣。好了就按enter。';
									combatText.show(name, false);

								case "NO":
									outcome = FLEE;
									doneResultsIn();
							}
						}
					}
					else if (state == 2)
					{
						state++;
						diamond -= investNum;

						name = ':謝謝你！你買了' + investNum * starterPrize + 'APS幣。';
						outcome = WIN;
						combatText.show(name, false);
						investNumText.visible = false;
						pointerLeft.visible = false;
						pointerRight.visible = false;
					}
					else if (state == 3)
					{
						appleCoin += investNum * starterPrize;
						doneResultsIn();
					}
				}
				else
				{
					if (state == 1)
					{
						if (combatText.over && !pointer.visible)
						{
							pointer.visible = true;
						}
						else if (pointer.visible)
						{
							state++;
							switch (pointer.selected)
							{
								case "YES":
									pointer.visible = false;
									choices[YES].visible = false;
									choices[NO].visible = false;
									outcome = WIN;
									name = ':謝謝你買了我的新項目！';
									combatText.show(name, false);

								case "NO":
									outcome = FLEE;
									doneResultsIn();
							}
						}
					}
					else if (state == 2)
						doneResultsIn();
				}
			}
			diamond = FlxMath.roundDecimal(diamond, 2);
			diamondText.text = Std.string(diamond);
			diamondUiText.text = Std.string(diamond);
		}
		else if (left || right)
		{
			if (investNumText.visible)
			{
				// 槓桿用的是香蕉幣投資
				if (enemy.type == rod)
				{
					if (left && investNum != 5)
						investNum -= 5;
					else if (right && investNum / 5 != Std.int(bananaCoin / 5))
						investNum += 5;
					investNumText.text = Std.string(investNum);
				}
				// 其他人都用能量幣
				else
				{
					if (left && investNum != 5)
						investNum -= 5;
					else if (right && investNum / 5 != Std.int(diamond / 5))
						investNum += 5;
					investNumText.text = Std.string(investNum);
				}
			}
			else if (rodNumText.visible)
			{
				if (left && rodNum != 2)
					rodNum--;
				else if (right)
					rodNum++;
				rodNumText.text = Std.string(rodNum);
			}
			// nft花樣選擇
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

	function lrPointer(spriteX:Float, spriteY:Float, spriteW:Float, spriteH:Float)
	{
		pointerLeft.visible = true;
		pointerLeft.setPosition(spriteX - pointerLeft.width, spriteY + spriteH / 2 - 30);
		pointerRight.visible = true;
		pointerRight.setPosition(spriteX + spriteW, spriteY + spriteH / 2 - 30);
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
		if (diamond < 0)
		{
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new GameOverState());
			});
		}
		else
			FlxTween.num(1, 0, .66, {ease: FlxEase.circOut, onComplete: finishFadeOut}, updateAlpha);
	}
}
