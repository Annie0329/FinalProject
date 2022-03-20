package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

enum TipText
{
	startTalk;
	talkSch;
	talkFin;
	monuFin;
	cloud;
	nft;
	shiba;
	fraud;
	shibaNews;
	nftNews;
	miner;
	minerSign;
	loan;
}

class Tip extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var text:FlxText;
	var i:Int;
	var j:String = "oui";
	var dilog_boxes:Array<String>;
	var tipTimer:FlxTimer;

	public function new()
	{
		super();

		background = new FlxSprite(990, 795, AssetPaths.tip__png);
		add(background);

		text = new FlxText(background.x + 33, background.y + 126, background.width - 30, "text", 60, true);
		text.font = AssetPaths.silver__ttf;
		add(text);

		dilog_boxes = openfl.Assets.getText(AssetPaths.tipText__txt).split(":");

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		visible = false;
		active = false;
	}

	// 透過陣列告訴你該顯示哪個提醒的聰明小程式
	public function tipGetText(title:TipText)
	{
		if (visible)
			tipTimer.cancel();
		else
		{
			visible = true;
			active = true;
		}
		j = Std.string(title);
		for (i in 0...dilog_boxes.length)
		{
			if (j == dilog_boxes[i])
			{
				text.text = dilog_boxes[i + 1];
			}
		}

		tipTimer = new FlxTimer().start(10, function(timer:FlxTimer)
		{
			visible = false;
			active = false;
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
