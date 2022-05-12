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

		data = '{"name":null,"assets":"aoy4:pathy31:assets%2Fdata%2FairdropTalk.txty4:sizei162y4:typey4:TEXTy2:idR1y7:preloadtgoR0y27:assets%2Fdata%2FappleAd.txtR2i173R3R4R5R7R6tgoR0y29:assets%2Fdata%2Fc1Opening.txtR2i941R3R4R5R8R6tgoR0y29:assets%2Fdata%2FcloseText.txtR2i514R3R4R5R9R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R10R6tgoR0y28:assets%2Fdata%2FdeFiMap.ogmoR2i449122R3R4R5R11R6tgoR0y27:assets%2Fdata%2FdexNews.txtR2i148R3R4R5R12R6tgoR0y30:assets%2Fdata%2FendingTalk.txtR2i167R3R4R5R13R6tgoR2i7664060R3y4:FONTy9:classNamey29:__ASSET__assets_data_font_ttfR5y24:assets%2Fdata%2Ffont.ttfR6tgoR0y29:assets%2Fdata%2FgoToMiner.txtR2i60R3R4R5R18R6tgoR0y30:assets%2Fdata%2Fhouse1Talk.txtR2i673R3R4R5R19R6tgoR0y30:assets%2Fdata%2Fhouse2Talk.txtR2i499R3R4R5R20R6tgoR0y30:assets%2Fdata%2Fhouse3Talk.txtR2i498R3R4R5R21R6tgoR0y32:assets%2Fdata%2FkingSellTalk.txtR2i187R3R4R5R22R6tgoR0y28:assets%2Fdata%2FkingTalk.txtR2i246R3R4R5R23R6tgoR0y31:assets%2Fdata%2FlakeTalking.txtR2i137R3R4R5R24R6tgoR0y29:assets%2Fdata%2FminerMap.jsonR2i85864R3R4R5R25R6tgoR0y31:assets%2Fdata%2FmingTalking.txtR2i650R3R4R5R26R6tgoR0y29:assets%2Fdata%2FmissionNo.txtR2i99R3R4R5R27R6tgoR0y31:assets%2Fdata%2FmissionText.txtR2i529R3R4R5R28R6tgoR0y30:assets%2Fdata%2FmissionYes.txtR2i490R3R4R5R29R6tgoR0y32:assets%2Fdata%2FmonumentMap.jsonR2i93665R3R4R5R30R6tgoR0y28:assets%2Fdata%2FopenText.txtR2i695R3R4R5R31R6tgoR0y27:assets%2Fdata%2FrodTalk.txtR2i416R3R4R5R32R6tgoR0y34:assets%2Fdata%2FsaveStoneIntro.txtR2i570R3R4R5R33R6tgoR0y26:assets%2Fdata%2FsbTalk.txtR2i298R3R4R5R34R6tgoR0y27:assets%2Fdata%2Fscript.docxR2i27800R3y6:BINARYR5R35R6tgoR0y26:assets%2Fdata%2FsgTalk.txtR2i193R3R4R5R37R6tgoR0y34:assets%2Fdata%2FshopBranchTalk.txtR2i88R3R4R5R38R6tgoR0y29:assets%2Fdata%2FshopGuide.txtR2i279R3R4R5R39R6tgoR0y35:assets%2Fdata%2FshopYellingTalk.txtR2i184R3R4R5R40R6tgoR2i3381148R3R14R15y31:__ASSET__assets_data_silver_ttfR5y26:assets%2Fdata%2Fsilver.ttfR6tgoR0y31:assets%2Fdata%2FspartanTalk.txtR2i877R3R4R5R43R6tgoR0y26:assets%2Fdata%2FsrTalk.txtR2i150R3R4R5R44R6tgoR0y35:assets%2Fdata%2FstarterStreetNo.txtR2i294R3R4R5R45R6tgoR0y36:assets%2Fdata%2FstarterStreetYes.txtR2i307R3R4R5R46R6tgoR0y31:assets%2Fdata%2FstarterTalk.txtR2i230R3R4R5R47R6tgoR0y30:assets%2Fdata%2FstreetMap.jsonR2i88419R3R4R5R48R6tgoR0y30:assets%2Fdata%2FstreetSign.txtR2i397R3R4R5R49R6tgoR0y27:assets%2Fdata%2FtipText.txtR2i852R3R4R5R50R6tgoR0y29:assets%2Fimages%2Fairdrop.pngR2i3504R3y5:IMAGER5R51R6tgoR0y25:assets%2Fimages%2Fape.pngR2i9154R3R52R5R53R6tgoR0y32:assets%2Fimages%2FapeStarter.pngR2i2801R3R52R5R54R6tgoR0y29:assets%2Fimages%2FbagDeal.pngR2i12482R3R52R5R55R6tgoR0y29:assets%2Fimages%2FbagItem.pngR2i15225R3R52R5R56R6tgoR0y28:assets%2Fimages%2Fbanana.pngR2i7537R3R52R5R57R6tgoR0y30:assets%2Fimages%2FboxEmpty.pngR2i1537R3R52R5R58R6tgoR0y29:assets%2Fimages%2FboxFull.pngR2i2272R3R52R5R59R6tgoR0y38:assets%2Fimages%2FclosingAnimation.pngR2i97865R3R52R5R60R6tgoR0y32:assets%2Fimages%2FcloudMiner.pngR2i2491R3R52R5R61R6tgoR0y38:assets%2Fimages%2FcombatBackground.pngR2i41511R3R52R5R62R6tgoR0y38:assets%2Fimages%2FcombatBananaIcon.pngR2i994R3R52R5R63R6tgoR0y28:assets%2Fimages%2Fcredit.pngR2i137237R3R52R5R64R6tgoR0y29:assets%2Fimages%2FdexNews.pngR2i1482R3R52R5R65R6tgoR0y28:assets%2Fimages%2FdiaApe.pngR2i6434R3R52R5R66R6tgoR0y29:assets%2Fimages%2FdiaDoge.pngR2i7586R3R52R5R67R6tgoR0y29:assets%2Fimages%2FdiaLake.pngR2i4714R3R52R5R68R6tgoR0y29:assets%2Fimages%2FdiaMing.pngR2i6945R3R52R5R69R6tgoR0y33:assets%2Fimages%2FdiamondIcon.pngR2i1197R3R52R5R70R6tgoR0y29:assets%2Fimages%2FdiaNull.pngR2i5291R3R52R5R71R6tgoR0y27:assets%2Fimages%2FdiaP1.pngR2i5645R3R52R5R72R6tgoR0y37:assets%2Fimages%2FdiaP1ApToCoMach.pngR2i17912R3R52R5R73R6tgoR0y37:assets%2Fimages%2FdiaP1BaToCoMach.pngR2i18233R3R52R5R74R6tgoR0y37:assets%2Fimages%2FdiaP1CoToApMach.pngR2i17711R3R52R5R75R6tgoR0y37:assets%2Fimages%2FdiaP1CoToDeMach.pngR2i17805R3R52R5R76R6tgoR0y37:assets%2Fimages%2FdiaP1DeToCoMach.pngR2i18079R3R52R5R77R6tgoR0y27:assets%2Fimages%2FdiaP2.pngR2i5692R3R52R5R78R6tgoR0y31:assets%2Fimages%2FdiaP2Mach.pngR2i18283R3R52R5R79R6tgoR0y27:assets%2Fimages%2FdiaP3.pngR2i5727R3R52R5R80R6tgoR0y31:assets%2Fimages%2FdiaP3Mach.pngR2i18037R3R52R5R81R6tgoR0y32:assets%2Fimages%2FdiaSbBlack.pngR2i5559R3R52R5R82R6tgoR0y31:assets%2Fimages%2FdiaSbBlue.pngR2i7463R3R52R5R83R6tgoR0y32:assets%2Fimages%2FdiaSbGreen.pngR2i7560R3R52R5R84R6tgoR0y30:assets%2Fimages%2FdiaSbRed.pngR2i7490R3R52R5R85R6tgoR0y32:assets%2Fimages%2FdiaSpartan.pngR2i8294R3R52R5R86R6tgoR0y26:assets%2Fimages%2Fdoge.pngR2i2597R3R52R5R87R6tgoR0y28:assets%2Fimages%2Fexclam.pngR2i494R3R52R5R88R6tgoR0y32:assets%2Fimages%2FexclamDoge.pngR2i505R3R52R5R89R6tgoR0y30:assets%2Fimages%2FhellYeah.pngR2i349861R3R52R5R90R6tgoR0y30:assets%2Fimages%2FhomeDoor.pngR2i8973R3R52R5R91R6tgoR0y32:assets%2Fimages%2Fhouse1Sign.pngR2i1840R3R52R5R92R6tgoR0y32:assets%2Fimages%2Fhouse2Sign.pngR2i1716R3R52R5R93R6tgoR0y32:assets%2Fimages%2Fhouse3Sign.pngR2i1944R3R52R5R94R6tgoR0y32:assets%2Fimages%2Fhouse4Sign.pngR2i1435R3R52R5R95R6tgoR0y36:assets%2Fimages%2FIDidTheMathToo.jpgR2i3532668R3R52R5R96R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R97R6tgoR0y31:assets%2Fimages%2FmathChart.pngR2i976R3R52R5R98R6tgoR0y31:assets%2Fimages%2FmenuAbout.pngR2i15103R3R52R5R99R6tgoR0y30:assets%2Fimages%2FmenuMain.pngR2i21693R3R52R5R100R6tgoR0y33:assets%2Fimages%2FmenuMainNew.pngR2i44776R3R52R5R101R6tgoR0y32:assets%2Fimages%2FminePoster.pngR2i63935R3R52R5R102R6tgoR0y31:assets%2Fimages%2FminerDoor.pngR2i8420R3R52R5R103R6tgoR0y31:assets%2Fimages%2FminerGate.pngR2i2498R3R52R5R104R6tgoR0y36:assets%2Fimages%2FminerTimerIcon.pngR2i1300R3R52R5R105R6tgoR0y30:assets%2Fimages%2FmineSign.pngR2i1131R3R52R5R106R6tgoR0y30:assets%2Fimages%2Fmonument.pngR2i2572R3R52R5R107R6tgoR0y29:assets%2Fimages%2FmtSmall.pngR2i196795R3R52R5R108R6tgoR0y25:assets%2Fimages%2Fnft.pngR2i3381R3R52R5R109R6tgoR0y29:assets%2Fimages%2FnftIcon.pngR2i2923R3R52R5R110R6tgoR0y27:assets%2Fimages%2Fnotfi.pngR2i965R3R52R5R111R6tgoR0y38:assets%2Fimages%2FopeningAnimation.pngR2i1049127R3R52R5R112R6tgoR0y24:assets%2Fimages%2Fp1.pngR2i2546R3R52R5R113R6tgoR0y34:assets%2Fimages%2Fp1ApToCoMach.pngR2i2102R3R52R5R114R6tgoR0y34:assets%2Fimages%2Fp1BaToCoMach.pngR2i2116R3R52R5R115R6tgoR0y34:assets%2Fimages%2Fp1CoToApMach.pngR2i2108R3R52R5R116R6tgoR0y34:assets%2Fimages%2Fp1CoToDeMach.pngR2i2084R3R52R5R117R6tgoR0y34:assets%2Fimages%2Fp1DeToCoMach.pngR2i2082R3R52R5R118R6tgoR0y24:assets%2Fimages%2Fp2.pngR2i2549R3R52R5R119R6tgoR0y28:assets%2Fimages%2Fp2Mach.pngR2i2106R3R52R5R120R6tgoR0y24:assets%2Fimages%2Fp3.pngR2i2606R3R52R5R121R6tgoR0y28:assets%2Fimages%2Fp3Mach.pngR2i1433R3R52R5R122R6tgoR0y29:assets%2Fimages%2Fpointer.pngR2i1598R3R52R5R123R6tgoR0y31:assets%2Fimages%2FponziFire.pngR2i11856R3R52R5R124R6tgoR0y25:assets%2Fimages%2Frod.pngR2i2907R3R52R5R125R6tgoR0y29:assets%2Fimages%2FrodIcon.pngR2i1517R3R52R5R126R6tgoR0y31:assets%2Fimages%2FsaveStone.pngR2i6236R3R52R5R127R6tgoR0y29:assets%2Fimages%2FsbBlack.pngR2i981R3R52R5R128R6tgoR0y28:assets%2Fimages%2FsbBlue.pngR2i2700R3R52R5R129R6tgoR0y29:assets%2Fimages%2FsbGreen.pngR2i2703R3R52R5R130R6tgoR0y27:assets%2Fimages%2FsbRed.pngR2i2681R3R52R5R131R6tgoR0y29:assets%2Fimages%2FsbWhite.pngR2i2384R3R52R5R132R6tgoR0y25:assets%2Fimages%2Fsea.pngR2i6879R3R52R5R133R6tgoR0y31:assets%2Fimages%2FshibaCoin.pngR2i4646R3R52R5R134R6tgoR0y35:assets%2Fimages%2FshibaCoinIcon.pngR2i1438R3R52R5R135R6tgoR0y32:assets%2Fimages%2Fshopkeeper.pngR2i23944R3R52R5R136R6tgoR0y37:assets%2Fimages%2FshopkeeperSmile.pngR2i24007R3R52R5R137R6tgoR0y36:assets%2Fimages%2FshopkeeperTalk.pngR2i23983R3R52R5R138R6tgoR0y30:assets%2Fimages%2Fshowcase.pngR2i5195R3R52R5R139R6tgoR0y29:assets%2Fimages%2Fspartan.pngR2i2905R3R52R5R140R6tgoR0y34:assets%2Fimages%2FspartanMiner.pngR2i4641R3R52R5R141R6tgoR0y27:assets%2Fimages%2Fstone.pngR2i1959R3R52R5R142R6tgoR0y31:assets%2Fimages%2FstoneIcon.pngR2i919R3R52R5R143R6tgoR0y36:assets%2Fimages%2FtheyDidTheMath.jpgR2i219113R3R52R5R144R6tgoR0y25:assets%2Fimages%2Ftip.pngR2i3427R3R52R5R145R6tgoR0y27:assets%2Fimages%2Ftorch.pngR2i3397R3R52R5R146R6tgoR0y29:assets%2Fimages%2FtreeBar.pngR2i9524R3R52R5R147R6tgoR2i317823R3y5:SOUNDR5y32:assets%2Fmusic%2FcreditTheme.oggy9:pathGroupaR149hR6tgoR2i401450R3R148R5y30:assets%2Fmusic%2FmenuTheme.oggR150aR151hR6tgoR2i616300R3R148R5y31:assets%2Fmusic%2FminerTheme.oggR150aR152hR6tgoR2i1444772R3y5:MUSICR5y34:assets%2Fmusic%2FmonumentTheme.oggR150aR154hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R155R6tgoR2i934926R3R148R5y30:assets%2Fmusic%2FshopTheme.oggR150aR156hR6tgoR2i401450R3R148R5y32:assets%2Fmusic%2FstreetTheme.oggR150aR157hR6tgoR2i4655R3R148R5y27:assets%2Fsound%2Fcancel.oggR150aR158hR6tgoR2i5950R3R148R5y26:assets%2Fsound%2Fcheck.oggR150aR159hR6tgoR2i5489R3R148R5y29:assets%2Fsound%2FdoorTele.oggR150aR160hR6tgoR2i11034R3R148R5y30:assets%2Fsound%2FgateSlide.oggR150aR161hR6tgoR2i4174R3R148R5y31:assets%2Fsound%2FminerPunch.oggR150aR162hR6tgoR2i5789R3R148R5y32:assets%2Fsound%2FmovePointer.oggR150aR163hR6tgoR2i12050R3R148R5y25:assets%2Fsound%2Fnext.oggR150aR164hR6tgoR2i10291R3R148R5y23:assets%2Fsound%2Fno.oggR150aR165hR6tgoR2i4381R3R148R5y28:assets%2Fsound%2FopenBag.oggR150aR166hR6tgoR2i4138R3R148R5y27:assets%2Fsound%2FpickUp.oggR150aR167hR6tgoR2i5341R3R148R5y25:assets%2Fsound%2Fsave.oggR150aR168hR6tgoR0y35:assets%2Fsound%2Fsounds-go-here.txtR2zR3R4R5R169R6tgoR2i3873R3R148R5y25:assets%2Fsound%2Fstep.oggR150aR170hR6tgoR2i4555R3R148R5y31:assets%2Fsound%2FtouchEnemy.oggR150aR171hR6tgoR2i3684R3R148R5y27:assets%2Fsound%2Ftyping.oggR150aR172hR6tgoR2i2114R3R153R5y26:flixel%2Fsounds%2Fbeep.mp3R150aR173y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R153R5y28:flixel%2Fsounds%2Fflixel.mp3R150aR175y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R148R5R174R150aR173R174hgoR2i33629R3R148R5R176R150aR175R176hgoR2i15744R3R14R15y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R14R15y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R52R5R181R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R52R5R182R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_airdroptalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_applead_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_closetext_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_defimap_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dexnews_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_endingtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_font_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_gotominer_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house1talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house2talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_house3talk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_kingselltalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_kingtalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_minermap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_mingtalking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_missionno_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_missiontext_txt extends null { }
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_starterstreetno_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_starterstreetyes_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_startertalk_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_streetmap_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_streetsign_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tiptext_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_airdrop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_apestarter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bagdeal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bagitem_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_closinganimation_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cloudminer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_combatbackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_combatbananaicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dexnews_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diaming_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diamondicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dianull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1aptocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1batocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1cotoapmach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1cotodemach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap1detocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap2mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_diap3mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mathchart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menumainnew_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mineposter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minerdoor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minergate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minertimericon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_minesign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1cotodemach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p1detocomach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p2mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_p3mach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ponzifire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rodicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_showcase_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spartanminer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stoneicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_theydidthemath_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_torch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_treebar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_credittheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_menutheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_minertheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_monumenttheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_shoptheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_streettheme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_cancel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_check_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_doortele_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_gateslide_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_minerpunch_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_movepointer_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_next_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_no_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_openbag_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_pickup_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_save_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_step_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_touchenemy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_typing_ogg extends null { }
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

@:keep @:file("assets/data/airdropTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_airdroptalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/appleAd.txt") @:noCompletion #if display private #end class __ASSET__assets_data_applead_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/c1Opening.txt") @:noCompletion #if display private #end class __ASSET__assets_data_c1opening_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/closeText.txt") @:noCompletion #if display private #end class __ASSET__assets_data_closetext_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/deFiMap.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_defimap_ogmo extends haxe.io.Bytes {}
@:keep @:file("assets/data/dexNews.txt") @:noCompletion #if display private #end class __ASSET__assets_data_dexnews_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/endingTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_endingtalk_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/font.ttf") @:noCompletion #if display private #end class __ASSET__assets_data_font_ttf extends lime.text.Font {}
@:keep @:file("assets/data/goToMiner.txt") @:noCompletion #if display private #end class __ASSET__assets_data_gotominer_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house1Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house1talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house2Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house2talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/house3Talk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_house3talk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/kingSellTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_kingselltalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/kingTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_kingtalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/lakeTalking.txt") @:noCompletion #if display private #end class __ASSET__assets_data_laketalking_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/minerMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_minermap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/mingTalking.txt") @:noCompletion #if display private #end class __ASSET__assets_data_mingtalking_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/missionNo.txt") @:noCompletion #if display private #end class __ASSET__assets_data_missionno_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/missionText.txt") @:noCompletion #if display private #end class __ASSET__assets_data_missiontext_txt extends haxe.io.Bytes {}
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
@:keep @:file("assets/data/starterStreetNo.txt") @:noCompletion #if display private #end class __ASSET__assets_data_starterstreetno_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/starterStreetYes.txt") @:noCompletion #if display private #end class __ASSET__assets_data_starterstreetyes_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/starterTalk.txt") @:noCompletion #if display private #end class __ASSET__assets_data_startertalk_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/streetMap.json") @:noCompletion #if display private #end class __ASSET__assets_data_streetmap_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/streetSign.txt") @:noCompletion #if display private #end class __ASSET__assets_data_streetsign_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/tipText.txt") @:noCompletion #if display private #end class __ASSET__assets_data_tiptext_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/airdrop.png") @:noCompletion #if display private #end class __ASSET__assets_images_airdrop_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ape.png") @:noCompletion #if display private #end class __ASSET__assets_images_ape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/apeStarter.png") @:noCompletion #if display private #end class __ASSET__assets_images_apestarter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bagDeal.png") @:noCompletion #if display private #end class __ASSET__assets_images_bagdeal_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bagItem.png") @:noCompletion #if display private #end class __ASSET__assets_images_bagitem_png extends lime.graphics.Image {}
@:keep @:image("assets/images/banana.png") @:noCompletion #if display private #end class __ASSET__assets_images_banana_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boxEmpty.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxempty_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boxFull.png") @:noCompletion #if display private #end class __ASSET__assets_images_boxfull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/closingAnimation.png") @:noCompletion #if display private #end class __ASSET__assets_images_closinganimation_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cloudMiner.png") @:noCompletion #if display private #end class __ASSET__assets_images_cloudminer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/combatBackground.png") @:noCompletion #if display private #end class __ASSET__assets_images_combatbackground_png extends lime.graphics.Image {}
@:keep @:image("assets/images/combatBananaIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_combatbananaicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/credit.png") @:noCompletion #if display private #end class __ASSET__assets_images_credit_png extends lime.graphics.Image {}
@:keep @:image("assets/images/dexNews.png") @:noCompletion #if display private #end class __ASSET__assets_images_dexnews_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaApe.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaape_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaDoge.png") @:noCompletion #if display private #end class __ASSET__assets_images_diadoge_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaLake.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialake_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaMing.png") @:noCompletion #if display private #end class __ASSET__assets_images_diaming_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diamondIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_diamondicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaNull.png") @:noCompletion #if display private #end class __ASSET__assets_images_dianull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1ApToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1aptocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1BaToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1batocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1CoToApMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1cotoapmach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1CoToDeMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1cotodemach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP1DeToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap1detocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP2.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP2Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap2mach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP3.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/diaP3Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_diap3mach_png extends lime.graphics.Image {}
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
@:keep @:image("assets/images/mathChart.png") @:noCompletion #if display private #end class __ASSET__assets_images_mathchart_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuAbout.png") @:noCompletion #if display private #end class __ASSET__assets_images_menuabout_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuMain.png") @:noCompletion #if display private #end class __ASSET__assets_images_menumain_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menuMainNew.png") @:noCompletion #if display private #end class __ASSET__assets_images_menumainnew_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minePoster.png") @:noCompletion #if display private #end class __ASSET__assets_images_mineposter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerDoor.png") @:noCompletion #if display private #end class __ASSET__assets_images_minerdoor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerGate.png") @:noCompletion #if display private #end class __ASSET__assets_images_minergate_png extends lime.graphics.Image {}
@:keep @:image("assets/images/minerTimerIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_minertimericon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mineSign.png") @:noCompletion #if display private #end class __ASSET__assets_images_minesign_png extends lime.graphics.Image {}
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
@:keep @:image("assets/images/p1CoToDeMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1cotodemach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p1DeToCoMach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p1detocomach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p2.png") @:noCompletion #if display private #end class __ASSET__assets_images_p2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p2Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p2mach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p3.png") @:noCompletion #if display private #end class __ASSET__assets_images_p3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/p3Mach.png") @:noCompletion #if display private #end class __ASSET__assets_images_p3mach_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pointer.png") @:noCompletion #if display private #end class __ASSET__assets_images_pointer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ponziFire.png") @:noCompletion #if display private #end class __ASSET__assets_images_ponzifire_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rod.png") @:noCompletion #if display private #end class __ASSET__assets_images_rod_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rodIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_rodicon_png extends lime.graphics.Image {}
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
@:keep @:image("assets/images/showcase.png") @:noCompletion #if display private #end class __ASSET__assets_images_showcase_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartan.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartan_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spartanMiner.png") @:noCompletion #if display private #end class __ASSET__assets_images_spartanminer_png extends lime.graphics.Image {}
@:keep @:image("assets/images/stone.png") @:noCompletion #if display private #end class __ASSET__assets_images_stone_png extends lime.graphics.Image {}
@:keep @:image("assets/images/stoneIcon.png") @:noCompletion #if display private #end class __ASSET__assets_images_stoneicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/theyDidTheMath.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_theydidthemath_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/tip.png") @:noCompletion #if display private #end class __ASSET__assets_images_tip_png extends lime.graphics.Image {}
@:keep @:image("assets/images/torch.png") @:noCompletion #if display private #end class __ASSET__assets_images_torch_png extends lime.graphics.Image {}
@:keep @:image("assets/images/treeBar.png") @:noCompletion #if display private #end class __ASSET__assets_images_treebar_png extends lime.graphics.Image {}
@:keep @:file("assets/music/creditTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_credittheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/menuTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_menutheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/minerTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_minertheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/monumentTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_monumenttheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/shopTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_shoptheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/streetTheme.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_streettheme_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/cancel.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_cancel_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/check.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_check_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/doorTele.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_doortele_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/gateSlide.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_gateslide_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/minerPunch.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_minerpunch_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/movePointer.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_movepointer_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/next.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_next_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/no.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_no_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/openBag.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_openbag_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/pickUp.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_pickup_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/save.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_save_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sound_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sound/step.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_step_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/touchEnemy.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_touchenemy_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sound/typing.ogg") @:noCompletion #if display private #end class __ASSET__assets_sound_typing_ogg extends haxe.io.Bytes {}
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
