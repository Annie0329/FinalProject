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
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_font_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_silver_ttf);
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

		data = '{"name":null,"assets":"aoy4:pathy27:assets%2Fdata%2FappleAd.txty4:sizei173y4:typey4:TEXTy2:idR1y7:preloadtgoR0y29:assets%2Fdata%2Fc1Opening.txtR2i811R3R4R5R7R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R8R6tgoR0y28:assets%2Fdata%2FdeFiMap.ogmoR2i411448R3R4R5R9R6tgoR0y30:assets%2Fdata%2FendingTalk.txtR2i167R3R4R5R10R6tgoR2i7664060R3y4:FONTy9:classNamey29:__ASSET__assets_data_font_ttfR5y24:assets%2Fdata%2Ffont.ttfR6tgoR0y29:assets%2Fdata%2FgoToMiner.txtR2i286R3R4R5R15R6tgoR0y30:assets%2Fdata%2Fhouse1Talk.txtR2i673R3R4R5R16R6tgoR0y30:assets%2Fdata%2Fhouse2Talk.txtR2i587R3R4R5R17R6tgoR0y30:assets%2Fdata%2Fhouse3Talk.txtR2i498R3R4R5R18R6tgoR0y28:assets%2Fdata%2FkingTalk.txtR2i229R3R4R5R19R6tgoR0y31:assets%2Fdata%2FlakeTalking.txtR2i60R3R4R5R20R6tgoR0y29:assets%2Fdata%2FminerMap.jsonR2i83214R3R4R5R21R6tgoR0y31:assets%2Fdata%2FmingTalking.txtR2i650R3R4R5R22R6tgoR0y29:assets%2Fdata%2FmissionNo.txtR2i101R3R4R5R23R6tgoR0y30:assets%2Fdata%2FmissionYes.txtR2i484R3R4R5R24R6tgoR0y32:assets%2Fdata%2FmonumentMap.jsonR2i92801R3R4R5R25R6tgoR0y28:assets%2Fdata%2FopenText.txtR2i671R3R4R5R26R6tgoR0y27:assets%2Fdata%2FrodTalk.txtR2i433R3R4R5R27R6tgoR0y34:assets%2Fdata%2FsaveStoneIntro.txtR2i570R3R4R5R28R6tgoR0y26:assets%2Fdata%2FsbTalk.txtR2i298R3R4R5R29R6tgoR0y27:assets%2Fdata%2Fscript.docxR2i27800R3y6:BINARYR5R30R6tgoR0y26:assets%2Fdata%2FsgTalk.txtR2i193R3R4R5R32R6tgoR0y34:assets%2Fdata%2FshopBranchTalk.txtR2i88R3R4R5R33R6tgoR0y29:assets%2Fdata%2FshopGuide.txtR2i247R3R4R5R34R6tgoR0y35:assets%2Fdata%2FshopYellingTalk.txtR2i184R3R4R5R35R6tgoR2i3381148R3R11R12y31:__ASSET__assets_data_silver_ttfR5y26:assets%2Fdata%2Fsilver.ttfR6tgoR0y31:assets%2Fdata%2FspartanTalk.txtR2i810R3R4R5R38R6tgoR0y26:assets%2Fdata%2FsrTalk.txtR2i150R3R4R5R39R6tgoR0y31:assets%2Fdata%2FstarterTalk.txtR2i309R3R4R5R40R6tgoR0y30:assets%2Fdata%2FstreetMap.jsonR2i87780R3R4R5R41R6tgoR0y30:assets%2Fdata%2FstreetSign.txtR2i400R3R4R5R42R6tgoR0y25:assets%2Fimages%2Fape.pngR2i9154R3y5:IMAGER5R43R6tgoR0y32:assets%2Fimages%2FapeStarter.pngR2i2801R3R44R5R45R6tgoR0y35:assets%2Fimages%2FappleCoinIcon.pngR2i2020R3R44R5R46R6tgoR0y29:assets%2Fimages%2FbagDeal.pngR2i14200R3R44R5R47R6tgoR0y29:assets%2Fimages%2FbagItem.pngR2i14001R3R44R5R48R6tgoR0y28:assets%2Fimages%2Fbanana.pngR2i7537R3R44R5R49R6tgoR0y36:assets%2Fimages%2FbananaCoinIcon.pngR2i2025R3R44R5R50R6tgoR0y32:assets%2Fimages%2FbananaIcon.pngR2i1979R3R44R5R51R6tgoR0y30:assets%2Fimages%2FboxEmpty.pngR2i2773R3R44R5R52R6tgoR0y29:assets%2Fimages%2FboxFull.pngR2i3565R3R44R5R53R6tgoR0y32:assets%2Fimages%2FcloudMiner.pngR2i2491R3R44R5R54R6tgoR0y38:assets%2Fimages%2FcombatBackground.pngR2i39507R3R44R5R55R6tgoR0y29:assets%2Fimages%2FdiaDoge.pngR2i7586R3R44R5R56R6tgoR0y29:assets%2Fimages%2FdiaLake.pngR2i5812R3R44R5R57R6tgoR0y29:assets%2Fimages%2FdiaMing.pngR2i6945R3R44R5R58R6tgoR0y33:assets%2Fimages%2FdiamondIcon.pngR2i1031R3R44R5R59R6tgoR0y29:assets%2Fimages%2FdiaNull.pngR2i5291R3R44R5R60R6tgoR0y27:assets%2Fimages%2FdiaP1.pngR2i5645R3R44R5R61R6tgoR0y27:assets%2Fimages%2FdiaP2.pngR2i5692R3R44R5R62R6tgoR0y27:assets%2Fimages%2FdiaP3.pngR2i5727R3R44R5R63R6tgoR0y32:assets%2Fimages%2FdiaSbBlack.pngR2i5559R3R44R5R64R6tgoR0y31:assets%2Fimages%2FdiaSbBlue.pngR2i7463R3R44R5R65R6tgoR0y32:assets%2Fimages%2FdiaSbGreen.pngR2i7560R3R44R5R66R6tgoR0y30:assets%2Fimages%2FdiaSbRed.pngR2i7490R3R44R5R67R6tgoR0y32:assets%2Fimages%2FdiaSpartan.pngR2i8294R3R44R5R68R6tgoR0y26:assets%2Fimages%2Fdoge.pngR2i2597R3R44R5R69R6tgoR0y28:assets%2Fimages%2Fexclam.pngR2i494R3R44R5R70R6tgoR0y32:assets%2Fimages%2FexclamDoge.pngR2i505R3R44R5R71R6tgoR0y30:assets%2Fimages%2FhellYeah.pngR2i349861R3R44R5R72R6tgoR0y30:assets%2Fimages%2FhomeDoor.pngR2i8973R3R44R5R73R6tgoR0y32:assets%2Fimages%2Fhouse1Sign.pngR2i1776R3R44R5R74R6tgoR0y32:assets%2Fimages%2Fhouse2Sign.pngR2i1716R3R44R5R75R6tgoR0y32:assets%2Fimages%2Fhouse3Sign.pngR2i2047R3R44R5R76R6tgoR0y32:assets%2Fimages%2Fhouse4Sign.pngR2i1435R3R44R5R77R6tgoR0y36:assets%2Fimages%2FIDidTheMathToo.jpgR2i3532668R3R44R5R78R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R79R6tgoR0y31:assets%2Fimages%2FmenuAbout.pngR2i7570R3R44R5R80R6tgoR0y30:assets%2Fimages%2FmenuMain.pngR2i21693R3R44R5R81R6tgoR0y33:assets%2Fimages%2FmenuMainNew.pngR2i44776R3R44R5R82R6tgoR0y31:assets%2Fimages%2FminerDoor.pngR2i8420R3R44R5R83R6tgoR0y31:assets%2Fimages%2FminerGate.pngR2i3047R3R44R5R84R6tgoR0y36:assets%2Fimages%2FminerTimerIcon.pngR2i2297R3R44R5R85R6tgoR0y30:assets%2Fimages%2Fmonument.pngR2i2572R3R44R5R86R6tgoR0y29:assets%2Fimages%2FmtSmall.pngR2i185105R3R44R5R87R6tgoR0y25:assets%2Fimages%2Fnft.pngR2i3381R3R44R5R88R6tgoR0y29:assets%2Fimages%2FnftIcon.pngR2i2923R3R44R5R89R6tgoR0y27:assets%2Fimages%2Fnotfi.pngR2i965R3R44R5R90R6tgoR0y38:assets%2Fimages%2FopeningAnimation.pngR2i1054649R3R44R5R91R6tgoR0y24:assets%2Fimages%2Fp1.pngR2i2546R3R44R5R92R6tgoR0y34:assets%2Fimages%2Fp1ApToCoMach.pngR2i2085R3R44R5R93R6tgoR0y34:assets%2Fimages%2Fp1BaToCoMach.pngR2i2104R3R44R5R94R6tgoR0y34:assets%2Fimages%2Fp1CoToApMach.pngR2i2079R3R44R5R95R6tgoR0y24:assets%2Fimages%2Fp2.pngR2i2549R3R44R5R96R6tgoR0y28:assets%2Fimages%2Fp2Mach.pngR2i2096R3R44R5R97R6tgoR0y24:assets%2Fimages%2Fp3.pngR2i2606R3R44R5R98R6tgoR0y28:assets%2Fimages%2Fp3Mach.pngR2i1433R3R44R5R99R6tgoR0y29:assets%2Fimages%2Fpointer.pngR2i1598R3R44R5R100R6tgoR0y31:assets%2Fimages%2FponziFire.pngR2i11856R3R44R5R101R6tgoR0y25:assets%2Fimages%2Frod.pngR2i2907R3R44R5R102R6tgoR0y31:assets%2Fimages%2FsaveStone.pngR2i6236R3R44R5R103R6tgoR0y29:assets%2Fimages%2FsbBlack.pngR2i981R3R44R5R104R6tgoR0y28:assets%2Fimages%2FsbBlue.pngR2i2700R3R44R5R105R6tgoR0y29:assets%2Fimages%2FsbGreen.pngR2i2703R3R44R5R106R6tgoR0y27:assets%2Fimages%2FsbRed.pngR2i2681R3R44R5R107R6tgoR0y29:assets%2Fimages%2FsbWhite.pngR2i2384R3R44R5R108R6tgoR0y25:assets%2Fimages%2Fsea.pngR2i6879R3R44R5R109R6tgoR0y31:assets%2Fimages%2FshibaCoin.pngR2i5281R3R44R5R110R6tgoR0y35:assets%2Fimages%2FshibaCoinIcon.pngR2i1231R3R44R5R111R6tgoR0y32:assets%2Fimages%2Fshopkeeper.pngR2i23944R3R44R5R112R6tgoR0y37:assets%2Fimages%2FshopkeeperSmile.pngR2i24007R3R44R5R113R6tgoR0y36:assets%2Fimages%2FshopkeeperTalk.pngR2i23983R3R44R5R114R6tgoR0y29:assets%2Fimages%2Fspartan.pngR2i2905R3R44R5R115R6tgoR0y34:assets%2Fimages%2FspartanMiner.pngR2i4641R3R44R5R116R6tgoR0y27:assets%2Fimages%2Fstone.pngR2i1959R3R44R5R117R6tgoR0y31:assets%2Fimages%2FstoneIcon.pngR2i2241R3R44R5R118R6tgoR0y36:assets%2Fimages%2FtheyDidTheMath.jpgR2i219113R3R44R5R119R6tgoR0y27:assets%2Fimages%2Ftorch.pngR2i3397R3R44R5R120R6tgoR0y29:assets%2Fimages%2FtreeBar.pngR2i9524R3R44R5R121R6tgoR2i1467245R3y5:MUSICR5y30:assets%2Fmusic%2FgameTheme.mp3y9:pathGroupaR123hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R125R6tgoR2i2924R3R122R5y26:assets%2Fsounds%2Fbeep.mp3R124aR126hR6tgoR2i23978R3y5:SOUNDR5y26:assets%2Fsounds%2Fcoin.wavR124aR128hR6tgoR2i39300R3R127R5y28:assets%2Fsounds%2Fcombat.wavR124aR129hR6tgoR2i34298R3R127R5y26:assets%2Fsounds%2Ffled.wavR124aR130hR6tgoR2i10188R3R127R5y31:assets%2Fsounds%2FgetBanana.wavR124aR131hR6tgoR2i20012R3R127R5y26:assets%2Fsounds%2Fhurt.wavR124aR132hR6tgoR2i33516R3R127R5y26:assets%2Fsounds%2Flose.wavR124aR133hR6tgoR2i24158R3R127R5y26:assets%2Fsounds%2Fmiss.wavR124aR134hR6tgoR2i10518R3R127R5y28:assets%2Fsounds%2Fselect.wavR124aR135hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R136R6tgoR2i10188R3R127R5y28:assets%2Fsounds%2Fspeech.wavR124aR137hR6tgoR2i10188R3R127R5y26:assets%2Fsounds%2Fstep.wavR124aR138hR6tgoR2i54320R3R127R5y25:assets%2Fsounds%2Fwin.wavR124aR139hR6tgoR2i2114R3R122R5y26:flixel%2Fsounds%2Fbeep.mp3R124aR140y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R122R5y28:flixel%2Fsounds%2Fflixel.mp3R124aR142y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R127R5R141R124aR140R141hgoR2i33629R3R127R5R143R124aR142R143hgoR2i15744R3R11R12y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R11R12y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R44R5R148R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R44R5R149R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_applead_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_defimap_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_endingtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_font_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_gotominer_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house1talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house2talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house3talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_kingtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_minermap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_mingtalking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_missionno_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_missionyes_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_monumentmap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_opentext_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_rodtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_savestoneintro_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_sbtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_sgtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_shopbranchtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_shopguide_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_shopyellingtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_silver_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_spartantalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_srtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_startertalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_streetmap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_streetsign_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_apestarter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_applecoinicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bagdeal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bagitem_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bananacoinicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bananaicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cloudminer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_combatbackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaming_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diamondicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dianull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diasbblack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diasbblue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diasbgreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diasbred_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_exclam_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_exclamdoge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hellyeah_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_homedoor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_house1sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_house2sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_house3sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_house4sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ididthemathtoo_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menumainnew_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minerdoor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minergate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minertimericon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_monument_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_nft_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_nfticon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_notfi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_openinganimation_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1aptocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1batocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1cotoapmach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p2mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p3mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ponzifire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_savestone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sbblack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sbblue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sbgreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sbred_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sbwhite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sea_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shibacoin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shibacoinicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shopkeeper_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shopkeepersmile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shopkeepertalk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartanminer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stoneicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_theydidthemath_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_torch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_treebar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_gametheme_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_combat_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_fled_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_getbanana_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hurt_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_lose_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_miss_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_select_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_speech_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_step_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_win_wav extends null { }
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

@:keep @:file("assets/data/appleAd.txt") @:noCompletion #if display private #end class __ASSET__assets_data_applead_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/c1Opening.txt") @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/deFiMap.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_defimap_ogmo extends haxe.io.Bytes {}
@:keep @:file("assets/data/endingTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_endingtalk_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/font.ttf") @:noCompletion #if display private #end class __ASSET__assets_data_font_ttf extends lime.text.Font {}
@:keep @:file("assets/data/goToMiner.txt") @:noCompletion #if display private #end class __ASSET__assets_data_gotominer_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house1Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house1talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house2Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house2talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house3Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house3talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/kingTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_kingtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/lakeTalking.txt") @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/minerMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_minermap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/mingTalking.txt") @:noCompletion #if display private #end class __ASSET__assets_data_mingtalking_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/missionNo.txt") @:noCompletion #if display private #end class __ASSET__assets_data_missionno_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/missionYes.txt") @:noCompletion #if display private #end class __ASSET__assets_data_missionyes_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/monumentMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_monumentmap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/openText.txt") @:noCompletion #if display private #end class __ASSET__assets_data_opentext_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/rodTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_rodtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/saveStoneIntro.txt") @:noCompletion #if display private #end class __ASSET__assets_data_savestoneintro_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/sbTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_sbtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/script.docx") @:noCompletion #if display private #end class __ASSET__assets_data_script_docx extends haxe.io.Bytes {}
@:keep @:file("assets/data/sgTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_sgtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/shopBranchTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_shopbranchtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/shopGuide.txt") @:noCompletion #if display private #end class __ASSET__assets_data_shopguide_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/shopYellingTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_shopyellingtalk_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/silver.ttf") @:noCompletion #if display private #end class __ASSET__assets_data_silver_ttf extends lime.text.Font {}
@:keep @:file("assets/data/spartanTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_spartantalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/srTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_srtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/starterTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_startertalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/streetMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_streetmap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/streetSign.txt") @:noCompletion #if display private #end class __ASSET__assets_data_streetsign_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/ape.png") @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/apeStarter.png") @:noCompletion #if display private #end class __ASSET__assets_images_apestarter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/appleCoinIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_applecoinicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bagDeal.png") @:noCompletion #if display private #end class __ASSET__assets_images_bagdeal_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bagItem.png") @:noCompletion #if display private #end class __ASSET__assets_images_bagitem_png extends lime.graphics.Image {}
@:keep @:image("assets/images/banana.png") @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bananaCoinIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_bananacoinicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bananaIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_bananaicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boxEmpty.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boxFull.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cloudMiner.png") @:noCompletion #if display private #end class __ASSET__assets_images_cloudminer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/combatBackground.png") @:noCompletion #if display private #end class __ASSET__assets_images_combatbackground_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaDoge.png") @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaLake.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaMing.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaming_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diamondIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_diamondicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaNull.png") @:noCompletion #if display private #end class __ASSET__assets_images_dianull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP2.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP3.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSbBlack.png") @:noCompletion #if display private #end class __ASSET__assets_images_diasbblack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSbBlue.png") @:noCompletion #if display private #end class __ASSET__assets_images_diasbblue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSbGreen.png") @:noCompletion #if display private #end class __ASSET__assets_images_diasbgreen_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSbRed.png") @:noCompletion #if display private #end class __ASSET__assets_images_diasbred_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaSpartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaspartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/doge.png") @:noCompletion #if display private #end class __ASSET__assets_images_doge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/exclam.png") @:noCompletion #if display private #end class __ASSET__assets_images_exclam_png extends lime.graphics.Image {}
@:keep @:image("assets/images/exclamDoge.png") @:noCompletion #if display private #end class __ASSET__assets_images_exclamdoge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/hellYeah.png") @:noCompletion #if display private #end class __ASSET__assets_images_hellyeah_png extends lime.graphics.Image {}
@:keep @:image("assets/images/homeDoor.png") @:noCompletion #if display private #end class __ASSET__assets_images_homedoor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/house1Sign.png") @:noCompletion #if display private #end class __ASSET__assets_images_house1sign_png extends lime.graphics.Image {}
@:keep @:image("assets/images/house2Sign.png") @:noCompletion #if display private #end class __ASSET__assets_images_house2sign_png extends lime.graphics.Image {}
@:keep @:image("assets/images/house3Sign.png") @:noCompletion #if display private #end class __ASSET__assets_images_house3sign_png extends lime.graphics.Image {}
@:keep @:image("assets/images/house4Sign.png") @:noCompletion #if display private #end class __ASSET__assets_images_house4sign_png extends lime.graphics.Image {}
@:keep @:image("assets/images/IDidTheMathToo.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_ididthemathtoo_jpg extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/menuAbout.png") @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuMain.png") @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuMainNew.png") @:noCompletion #if display private #end class __ASSET__assets_images_menumainnew_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerDoor.png") @:noCompletion #if display private #end class __ASSET__assets_images_minerdoor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerGate.png") @:noCompletion #if display private #end class __ASSET__assets_images_minergate_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerTimerIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_minertimericon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/monument.png") @:noCompletion #if display private #end class __ASSET__assets_images_monument_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mtSmall.png") @:noCompletion #if display private #end class __ASSET__assets_images_mtsmall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/nft.png") @:noCompletion #if display private #end class __ASSET__assets_images_nft_png extends lime.graphics.Image {}
@:keep @:image("assets/images/nftIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_nfticon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/notfi.png") @:noCompletion #if display private #end class __ASSET__assets_images_notfi_png extends lime.graphics.Image {}
@:keep @:image("assets/images/openingAnimation.png") @:noCompletion #if display private #end class __ASSET__assets_images_openinganimation_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p1.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p1ApToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1aptocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p1BaToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1batocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p1CoToApMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1cotoapmach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p2.png") @:noCompletion #if display private #end class __ASSET__assets_images_p2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p2Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p2mach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p3.png") @:noCompletion #if display private #end class __ASSET__assets_images_p3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p3Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p3mach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ponziFire.png") @:noCompletion #if display private #end class __ASSET__assets_images_ponzifire_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rod.png") @:noCompletion #if display private #end class __ASSET__assets_images_rod_png extends lime.graphics.Image {}
@:keep @:image("assets/images/saveStone.png") @:noCompletion #if display private #end class __ASSET__assets_images_savestone_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sbBlack.png") @:noCompletion #if display private #end class __ASSET__assets_images_sbblack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sbBlue.png") @:noCompletion #if display private #end class __ASSET__assets_images_sbblue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sbGreen.png") @:noCompletion #if display private #end class __ASSET__assets_images_sbgreen_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sbRed.png") @:noCompletion #if display private #end class __ASSET__assets_images_sbred_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sbWhite.png") @:noCompletion #if display private #end class __ASSET__assets_images_sbwhite_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sea.png") @:noCompletion #if display private #end class __ASSET__assets_images_sea_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shibaCoin.png") @:noCompletion #if display private #end class __ASSET__assets_images_shibacoin_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shibaCoinIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_shibacoinicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shopkeeper.png") @:noCompletion #if display private #end class __ASSET__assets_images_shopkeeper_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shopkeeperSmile.png") @:noCompletion #if display private #end class __ASSET__assets_images_shopkeepersmile_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shopkeeperTalk.png") @:noCompletion #if display private #end class __ASSET__assets_images_shopkeepertalk_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartanMiner.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartanminer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/stone.png") @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends lime.graphics.Image {}
@:keep @:image("assets/images/stoneIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_stoneicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/theyDidTheMath.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_theydidthemath_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/torch.png") @:noCompletion #if display private #end class __ASSET__assets_images_torch_png extends lime.graphics.Image {}
@:keep @:image("assets/images/treeBar.png") @:noCompletion #if display private #end class __ASSET__assets_images_treebar_png extends lime.graphics.Image {}
@:keep @:file("assets/music/gameTheme.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_gametheme_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/coin.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/combat.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_combat_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/fled.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_fled_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/getBanana.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_getbanana_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hurt.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_hurt_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/lose.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_lose_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/miss.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_miss_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/select.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_select_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/speech.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_speech_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/step.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_step_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/win.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_win_wav extends haxe.io.Bytes {}
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

@:keep @:expose('__ASSET__assets_data_font_ttf') @:noCompletion #if display private #end class __ASSET__assets_data_font_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/font"; #else ascender = 871; descender = -153; height = 1024; numGlyphs = 10038; underlinePosition = -100; underlineThickness = 50; unitsPerEM = 1024; #end name = "jf open 粉圓 1.1"; super (); }}
@:keep @:expose('__ASSET__assets_data_silver_ttf') @:noCompletion #if display private #end class __ASSET__assets_data_silver_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/silver"; #else ascender = 1200; descender = -900; height = 2100; numGlyphs = 12333; underlinePosition = -150; underlineThickness = 100; unitsPerEM = 1900; #end name = "Silver"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_data_font_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_font_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_font_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_data_silver_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_silver_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_silver_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_data_font_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_font_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_font_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_data_silver_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_silver_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_silver_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
