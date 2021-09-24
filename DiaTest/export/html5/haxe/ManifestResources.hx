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

		data = '{"name":null,"assets":"aoy4:pathy28:assets%2Fdata%2FbananaNo.txty4:sizei33y4:typey4:TEXTy2:idR1y7:preloadtgoR0y34:assets%2Fdata%2FbananaQuestion.txtR2i1219R3R4R5R7R6tgoR0y29:assets%2Fdata%2FbananaYes.txtR2i15R3R4R5R8R6tgoR0y29:assets%2Fdata%2Fc1Opening.txtR2i2065R3R4R5R9R6tgoR0y29:assets%2Fdata%2Fc2Opening.txtR2i1623R3R4R5R10R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R11R6tgoR0y27:assets%2Fdata%2FdiaMap.jsonR2i80297R3R4R5R12R6tgoR0y33:assets%2Fdata%2FforestMission.txtR2i283R3R4R5R13R6tgoR0y39:assets%2Fdata%2FforestMissionFinish.txtR2i1023R3R4R5R14R6tgoR0y31:assets%2Fdata%2FlakeTalking.txtR2i62R3R4R5R15R6tgoR0y29:assets%2Fdata%2FminerDoge.txtR2i12R3R4R5R16R6tgoR0y32:assets%2Fdata%2FminerSpartan.txtR2i28R3R4R5R17R6tgoR0y25:assets%2Fdata%2Froom.jsonR2i87083R3R4R5R18R6tgoR0y27:assets%2Fdata%2Fscript.docxR2i27800R3y6:BINARYR5R19R6tgoR0y32:assets%2Fdata%2FstoneExplain.txtR2i238R3R4R5R21R6tgoR0y38:assets%2Fdata%2FstoneMissionFinish.txtR2i495R3R4R5R22R6tgoR0y28:assets%2Fdata%2FtestMap.ogmoR2i40755R3R4R5R23R6tgoR0y25:assets%2Fimages%2Fape.pngR2i6217R3y5:IMAGER5R24R6tgoR0y28:assets%2Fimages%2FapeNew.pngR2i6008R3R25R5R26R6tgoR0y28:assets%2Fimages%2Fbanana.pngR2i405R3R25R5R27R6tgoR0y35:assets%2Fimages%2FbananaToStone.gifR2i8114602R3R25R5R28R6tgoR0y30:assets%2Fimages%2FboxEmpty.pngR2i458R3R25R5R29R6tgoR0y29:assets%2Fimages%2FboxFull.pngR2i1140R3R25R5R30R6tgoR0y28:assets%2Fimages%2Fbubble.pngR2i189R3R25R5R31R6tgoR0y28:assets%2Fimages%2FdiaApe.pngR2i2816R3R25R5R32R6tgoR0y31:assets%2Fimages%2FdiaBanana.pngR2i2241R3R25R5R33R6tgoR0y29:assets%2Fimages%2FdiaDoge.pngR2i3037R3R25R5R34R6tgoR0y29:assets%2Fimages%2FdiaLake.pngR2i1625R3R25R5R35R6tgoR0y32:assets%2Fimages%2FdiaSpartan.pngR2i3368R3R25R5R36R6tgoR0y26:assets%2Fimages%2Fdoge.pngR2i702R3R25R5R37R6tgoR0y30:assets%2Fimages%2Fexplain1.pngR2i10835R3R25R5R38R6tgoR0y30:assets%2Fimages%2Fexplain2.pngR2i30630R3R25R5R39R6tgoR0y30:assets%2Fimages%2Fexplain3.pngR2i10755R3R25R5R40R6tgoR0y30:assets%2Fimages%2Fexplain4.pngR2i32697R3R25R5R41R6tgoR0y30:assets%2Fimages%2Fexplain5.pngR2i12168R3R25R5R42R6tgoR0y30:assets%2Fimages%2Fexplain6.pngR2i11856R3R25R5R43R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R44R6tgoR0y31:assets%2Fimages%2FmenuAbout.pngR2i8924R3R25R5R45R6tgoR0y39:assets%2Fimages%2FmenuChapterSelect.pngR2i6417R3R25R5R46R6tgoR0y30:assets%2Fimages%2FmenuMain.pngR2i11738R3R25R5R47R6tgoR0y33:assets%2Fimages%2FmenuPointer.pngR2i173R3R25R5R48R6tgoR0y29:assets%2Fimages%2FmtSmall.pngR2i23351R3R25R5R49R6tgoR0y38:assets%2Fimages%2FopeningAnimation.pngR2i725469R3R25R5R50R6tgoR0y29:assets%2Fimages%2Fpointer.pngR2i182R3R25R5R51R6tgoR0y29:assets%2Fimages%2Fspartan.pngR2i963R3R25R5R52R6tgoR0y27:assets%2Fimages%2Fstone.pngR2i351R3R25R5R53R6tgoR0y28:assets%2Fimages%2Ftarget.pngR2i383R3R25R5R54R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R55R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R56R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR58y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R57R5y28:flixel%2Fsounds%2Fflixel.mp3R59aR61y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R60R59aR58R60hgoR2i33629R3R63R5R62R59aR61R62hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R64R65y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R25R5R70R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R25R5R71R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananaquestion_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bananayes_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_c2opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_diamap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_forestmission_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_forestmissionfinish_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_minerdoge_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_minerspartan_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_stoneexplain_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_stonemissionfinish_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_testmap_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_apenew_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bananatostone_gif extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diabanana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explain6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menuchapterselect_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menupointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_openinganimation_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_target_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:file("assets/data/bananaQuestion.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananaquestion_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/bananaYes.txt") @:noCompletion #if display private #end class __ASSET__assets_data_bananayes_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/c1Opening.txt") @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/c2Opening.txt") @:noCompletion #if display private #end class __ASSET__assets_data_c2opening_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/diaMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_diamap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/forestMission.txt") @:noCompletion #if display private #end class __ASSET__assets_data_forestmission_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/forestMissionFinish.txt") @:noCompletion #if display private #end class __ASSET__assets_data_forestmissionfinish_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/lakeTalking.txt") @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/minerDoge.txt") @:noCompletion #if display private #end class __ASSET__assets_data_minerdoge_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/minerSpartan.txt") @:noCompletion #if display private #end class __ASSET__assets_data_minerspartan_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/room.json") @:noCompletion #if display private #end class __ASSET__assets_data_room_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/script.docx") @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends haxe.io.Bytes {}
@:keep @:file("assets/data/stoneExplain.txt") @:noCompletion #if display private #end class __ASSET__assets_data_stoneexplain_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/stoneMissionFinish.txt") @:noCompletion #if display private #end class __ASSET__assets_data_stonemissionfinish_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/testMap.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_testmap_ogmo extends haxe.io.Bytes {}
@:keep @:image("assets/images/ape.png") @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/apeNew.png") @:noCompletion #if display private #end class __ASSET__assets_images_apenew_png extends lime.graphics.Image {}
@:keep @:image("assets/images/banana.png") @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bananaToStone.gif") @:noCompletion #if display private #end class __ASSET__assets_images_bananatostone_gif extends lime.graphics.Image {}
@:keep @:image("assets/images/boxEmpty.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boxFull.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bubble.png") @:noCompletion #if display private #end class __ASSET__assets_images_bubble_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaApe.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaBanana.png") @:noCompletion #if display private #end class __ASSET__assets_images_diabanana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaDoge.png") @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaLake.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSpartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/doge.png") @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain1.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain2.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain3.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain4.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain5.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explain6.png") @:noCompletion #if display private #end class __ASSET__assets_images_explain6_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/menuAbout.png") @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuChapterSelect.png") @:noCompletion #if display private #end class __ASSET__assets_images_menuchapterselect_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuMain.png") @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuPointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_menupointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mtSmall.png") @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/openingAnimation.png") @:noCompletion #if display private #end class __ASSET__assets_images_openinganimation_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/stone.png") @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends lime.graphics.Image {}
@:keep @:image("assets/images/target.png") @:noCompletion #if display private #end class __ASSET__assets_images_target_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
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
