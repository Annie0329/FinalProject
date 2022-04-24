// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_MinerState
#define INCLUDED_MinerState

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
HX_DECLARE_CLASS0(Bag)
HX_DECLARE_CLASS0(CombatHUD)
HX_DECLARE_CLASS0(Dia)
HX_DECLARE_CLASS0(Enemy)
HX_DECLARE_CLASS0(MinerState)
HX_DECLARE_CLASS0(NPC)
HX_DECLARE_CLASS0(NpcType)
HX_DECLARE_CLASS0(Player)
HX_DECLARE_CLASS0(Tip)
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS4(flixel,addons,editors,ogmo,FlxOgmo3Loader)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,_hx_system,FlxSound)
HX_DECLARE_CLASS2(flixel,text,FlxText)
HX_DECLARE_CLASS2(flixel,tile,FlxBaseTilemap)
HX_DECLARE_CLASS2(flixel,tile,FlxTilemap)
HX_DECLARE_CLASS2(flixel,util,FlxSave)
HX_DECLARE_CLASS2(flixel,util,FlxTimer)
HX_DECLARE_CLASS2(flixel,util,IFlxDestroyable)



class HXCPP_CLASS_ATTRIBUTES MinerState_obj : public  ::flixel::FlxState_obj
{
	public:
		typedef  ::flixel::FlxState_obj super;
		typedef MinerState_obj OBJ_;
		MinerState_obj();

	public:
		enum { _hx_ClassId = 0x1aba2df2 };

		void __construct( ::Dynamic MaxSize);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="MinerState")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"MinerState"); }
		static ::hx::ObjectPtr< MinerState_obj > __new( ::Dynamic MaxSize);
		static ::hx::ObjectPtr< MinerState_obj > __alloc(::hx::Ctx *_hx_ctx, ::Dynamic MaxSize);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~MinerState_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("MinerState",32,0b,f7,02); }

		 ::Player player;
		 ::Tip tip;
		 ::Bag bag;
		 ::flixel::_hx_system::FlxSound cancel;
		 ::flixel::_hx_system::FlxSound minerPunch;
		 ::flixel::_hx_system::FlxSound gateSlide;
		 ::flixel::_hx_system::FlxSound touchEnemy;
		 ::flixel::_hx_system::FlxSound openBag;
		 ::flixel::_hx_system::FlxSound doorTele;
		 ::flixel::_hx_system::FlxSound saveNoise;
		int stoneGoal;
		 ::Dia dia;
		::String diaUpDown;
		::String name;
		bool txt;
		bool talkYes;
		 ::flixel::group::FlxTypedGroup enemy;
		bool inCombat;
		 ::CombatHUD combatHud;
		 ::flixel::group::FlxTypedGroup npc;
		 ::NpcType npcType;
		bool meetStarter;
		 ::flixel::FlxSprite shop;
		 ::flixel::FlxSprite monumentDoor;
		 ::flixel::FlxSprite streetDoor;
		 ::flixel::FlxSprite minerGate;
		Float minerGateX;
		bool streetOpen;
		bool streetYes;
		 ::flixel::FlxSprite box;
		int roadStart;
		int roadEnd;
		Float boxPos;
		 ::flixel::group::FlxTypedGroup stone;
		int stoneCounter;
		 ::flixel::text::FlxText stoneCounterText;
		 ::flixel::FlxSprite stoneCounterIcon;
		bool stoneYes;
		 ::flixel::text::FlxText minerTimerText;
		 ::flixel::FlxSprite minerTimerIcon;
		 ::flixel::util::FlxTimer timer;
		int minerTimeSet;
		 ::flixel::_hx_system::FlxSound stoneSound;
		int finalScore;
		 ::flixel::addons::editors::ogmo::FlxOgmo3Loader map;
		 ::flixel::tile::FlxTilemap through;
		 ::flixel::tile::FlxTilemap walls;
		 ::flixel::tile::FlxTilemap road;
		 ::flixel::tile::FlxTilemap ground;
		 ::flixel::group::FlxTypedGroup torch;
		 ::flixel::text::FlxText ufo;
		 ::flixel::util::FlxSave save;
		void create();

		void placeEntities( ::Dynamic entity);
		::Dynamic placeEntities_dyn();

		void saveFile();
		::Dynamic saveFile_dyn();

		void loadFile();
		::Dynamic loadFile_dyn();

		void update(Float elapsed);

		void npcTalk( ::Player player, ::NPC npc);
		::Dynamic npcTalk_dyn();

		void goToMonument( ::Player player, ::flixel::FlxSprite monumentDoor);
		::Dynamic goToMonument_dyn();

		void goToStreet( ::Player player, ::flixel::FlxSprite streetDoor);
		::Dynamic goToStreet_dyn();

		void timeToStop( ::Player player, ::flixel::FlxSprite minerGate);
		::Dynamic timeToStop_dyn();

		void playerGotStone( ::Player player, ::flixel::FlxSprite stone);
		::Dynamic playerGotStone_dyn();

		void enemyGotStone( ::Enemy enemy, ::flixel::FlxSprite stone);
		::Dynamic enemyGotStone_dyn();

		void touchMiner( ::Player player, ::Enemy enemy);
		::Dynamic touchMiner_dyn();

		void updateInCombat();
		::Dynamic updateInCombat_dyn();

		void stoneInsideBox( ::Player player, ::flixel::FlxSprite box);
		::Dynamic stoneInsideBox_dyn();

		void updateTimer();
		::Dynamic updateTimer_dyn();

		void minerGameOver();
		::Dynamic minerGameOver_dyn();

		void shopOpen( ::Player player, ::flixel::FlxSprite shop);
		::Dynamic shopOpen_dyn();

		void updateTalking();
		::Dynamic updateTalking_dyn();

		void updateWhenDiaInvisible();
		::Dynamic updateWhenDiaInvisible_dyn();

		void playerUpDown();
		::Dynamic playerUpDown_dyn();

		void updateF4();
		::Dynamic updateF4_dyn();

		void updateC();
		::Dynamic updateC_dyn();

};


#endif /* INCLUDED_MinerState */ 