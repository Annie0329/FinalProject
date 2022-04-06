package;

import flixel.FlxG;
import flixel.addons.text.FlxTypeText;

class Text extends FlxTypeText
{
	var i:Int = 1;

	public var dilog_boxes:Array<String>;

	var txt:Bool = true;

	public var textRunDone = false;

	public var over:Bool = false;

	public function new(X:Float, Y:Float, Width:Int, Text:String, Size:Int, EmbeddedFont:Bool)
	{
		super(X, Y, Width, Text, Size, EmbeddedFont);
		font = AssetPaths.silver__ttf;
		sounds = [FlxG.sound.load(AssetPaths.typing__mp3)];
		finishSounds = true;
		delay = 0.05;
		skipKeys = ["X", "SHIFT"];
	}

	// 文字出現
	public function show(name, txt:Bool)
	{
		dilog_boxes = if (txt) openfl.Assets.getText(name).split(":") else dilog_boxes = name.split(":");
		i = 1;

		active = true;
		visible = true;
		over = false;

		textRunDone = false;
		resetText(dilog_boxes[i]);
		start(false, false, function()
		{
			textRunDone = true;
		});
	}

	// 更新啦
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateEnter();
		// 對話結束就離開
		if (dilog_boxes != null && i >= dilog_boxes.length - 1)
			over = true;
	}

	// 按Enter或空白鍵換行
	function updateEnter()
	{
		var enter = FlxG.keys.anyJustReleased([ENTER, SPACE]);

		// 換行
		if (enter && textRunDone)
		{
			i++;
			if (!(i >= dilog_boxes.length))
			{
				textRunDone = false;
				resetText(dilog_boxes[i]);
				start(false, false, function()
				{
					textRunDone = true;
				});
			}
		}
	}
}
