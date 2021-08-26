package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy28:assets%2Fdata%2FbananaNo.txty4:sizei33y4:typey4:TEXTy2:idR1y7:preloadtgoR0y28:assets%2Fdata%2FbananaQ1.txtR2i198R3R4R5R7R6tgoR0y28:assets%2Fdata%2FbananaQ2.txtR2i194R3R4R5R8R6tgoR0y28:assets%2Fdata%2FbananaQ3.txtR2i204R3R4R5R9R6tgoR0y28:assets%2Fdata%2FbananaQ4.txtR2zR3R4R5R10R6tgoR0y28:assets%2Fdata%2FbananaQ5.txtR2zR3R4R5R11R6tgoR0y28:assets%2Fdata%2FbananaQ6.txtR2zR3R4R5R12R6tgoR0y28:assets%2Fdata%2FbananaQ7.txtR2zR3R4R5R13R6tgoR0y29:assets%2Fdata%2FbananaYes.txtR2i15R3R4R5R14R6tgoR0y29:assets%2Fdata%2Fc1Opening.txtR2i3051R3R4R5R15R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R16R6tgoR0y27:assets%2Fdata%2FdiaMap.jsonR2i22748R3R4R5R17R6tgoR0y33:assets%2Fdata%2FforestMission.txtR2i100R3R4R5R18R6tgoR0y39:assets%2Fdata%2FforestMissionFinish.txtR2i53R3R4R5R19R6tgoR0y27:assets%2Fdata%2Fscript.docxR2i19559R3y6:BINARYR5R20R6tgoR0y28:assets%2Fdata%2FtestMap.ogmoR2i19299R3R4R5R22R6tgoR0y33:assets%2Fdata%2F%7E%24script.docxR2i162R3R21R5R23R6tgoR0y30:assets%2Fdata%2F%7EWRL0005.tmpR2i19719R3R21R5R24R6tgoR0y28:assets%2Fimages%2Fbanana.pngR2i332R3y5:IMAGER5R25R6tgoR0y28:assets%2Fimages%2FdiaApe.pngR2i2816R3R26R5R27R6tgoR0y31:assets%2Fimages%2FdiaBanana.pngR2i2286R3R26R5R28R6tgoR0y29:assets%2Fimages%2FdiaDoge.pngR2i3037R3R26R5R29R6tgoR0y32:assets%2Fimages%2FdiaSpartan.pngR2i3368R3R26R5R30R6tgoR0y26:assets%2Fimages%2Fdoge.pngR2i702R3R26R5R31R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R32R6tgoR0y30:assets%2Fimages%2FmainMenu.pngR2i11738R3R26R5R33R6tgoR0y29:assets%2Fimages%2FmtSmall.pngR2i10480R3R26R5R34R6tgoR0y29:assets%2Fimages%2Fpointer.pngR2i182R3R26R5R35R6tgoR0y29:assets%2Fimages%2Fspartan.pngR2i902R3R26R5R36R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R37R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R38R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR40y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R39R5y28:flixel%2Fsounds%2Fflixel.mp3R41aR43y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R42R41aR40R42hgoR2i33629R3R45R5R44R41aR43R44hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R46R47y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R26R5R52R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R26R5R53R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananano_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq1_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq2_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq3_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq4_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq5_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq6_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaq7_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananayes_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_diamap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_forestmission_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_forestmissionfinish_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_testmap_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data___script_docx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data__wrl0005_tmp extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diabanana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/bananaNo.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananano_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ1.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq1_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ2.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq2_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ3.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq3_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ4.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq4_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ5.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq5_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ6.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq6_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaQ7.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaq7_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaYes.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananayes_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/c1Opening.txt") @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/diaMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_diamap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/forestMission.txt") @:noCompletion #if display private #end class __ASSET__assets_data_forestmission_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/forestMissionFinish.txt") @:noCompletion #if display private #end class __ASSET__assets_data_forestmissionfinish_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/script.docx") @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends haxe.io.Bytes {}
@:keep @:file("assets/data/testMap.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_testmap_ogmo extends haxe.io.Bytes {}
@:keep @:file("assets/data/~$script.docx") @:noCompletion #if display private #end class __ASSET__assets_data___script_docx extends haxe.io.Bytes {}
@:keep @:file("assets/data/~WRL0005.tmp") @:noCompletion #if display private #end class __ASSET__assets_data__wrl0005_tmp extends haxe.io.Bytes {}
@:keep @:image("assets/images/banana.png") @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaApe.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaBanana.png") @:noCompletion #if display private #end class __ASSET__assets_images_diabanana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaDoge.png") @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSpartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/doge.png") @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/mainMenu.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mtSmall.png") @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
