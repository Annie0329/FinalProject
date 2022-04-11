package;

import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

enum MissionText
{
	getLeaves;
	leavesFin;
	talk;
	talkFin;
	monuFin;
	exploreMiner;
	minerFin;
	exploreStreet;
	streetFin;
}

enum TipText
{
	sellLeaves;
	monuFin;
	cloudMiner;
	nft;
	shiba;
	fraud;
	noFraud;
	shibaNews;
	nftNews;
	miner;
	minerSign;
	streetSign;
	loan;
}

class Tip extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	public var missionText:FlxText;
	var tipText:FlxTypeText;
	// var text:FlxText;
	var i:Int;

	public var j:String = "oui";
	public var k:String = "ouiMission";

	var tip_boxes:Array<String>;
	var mis_boxes:Array<String>;
	var tipTimer:FlxTimer;

	public function new()
	{
		super();

		background = new FlxSprite(990, 795, AssetPaths.tip__png);
		add(background);

		missionText = new FlxText(background.x + 33, background.y + 126, Std.int(background.width - 30), "text", 60, true);
		missionText.font = AssetPaths.silver__ttf;
		add(missionText);

		tipText = new FlxTypeText(missionText.x, missionText.y + 60, Std.int(background.width - 30), "text", 60, true);
		tipText.font = AssetPaths.silver__ttf;
		add(tipText);
		tipText.visible = false;

		tip_boxes = openfl.Assets.getText(AssetPaths.tipText__txt).split(":");
		mis_boxes = openfl.Assets.getText(AssetPaths.missionText__txt).split(":");

		// 別跟著攝影機動
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
		visible = false;
		active = false;
	}

	// 透過陣列告訴你該顯示哪個提醒的聰明小程式
	public function tipGetText(title:TipText)
	{
		if (tipText.visible)
			tipTimer.cancel();
		else
			tipText.visible = true;

		j = Std.string(title);
		for (i in 0...tip_boxes.length)
		{
			if (j == tip_boxes[i])
			{
				// text.text = tip_boxes[i + 1];
				tipText.resetText(tip_boxes[i + 1]);
				tipText.start(true);
			}
		}

		tipTimer = new FlxTimer().start(10, function(timer:FlxTimer)
		{
			tipText.visible = false;
		});
	}

	// 透過陣列告訴你該顯示哪個任務的聰明小程式
	public function missionGetText(title:MissionText)
	{
		k = Std.string(title);
		for (i in 0...mis_boxes.length)
		{
			if (k == mis_boxes[i])
				missionText.text = mis_boxes[i + 1];
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
