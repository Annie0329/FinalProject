// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_Dia
#include <Dia.h>
#endif
#ifndef INCLUDED_OpeningState
#include <OpeningState.h>
#endif
#ifndef INCLUDED_WinState
#include <WinState.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxCamera
#include <flixel/FlxCamera.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxGame
#include <flixel/FlxGame.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_input_FlxKeyManager
#include <flixel/input/FlxKeyManager.h>
#endif
#ifndef INCLUDED_flixel_input_IFlxInputManager
#include <flixel/input/IFlxInputManager.h>
#endif
#ifndef INCLUDED_flixel_input_keyboard_FlxKeyboard
#include <flixel/input/keyboard/FlxKeyboard.h>
#endif
#ifndef INCLUDED_flixel_math_FlxPoint
#include <flixel/math/FlxPoint.h>
#endif
#ifndef INCLUDED_flixel_system_FlxSoundGroup
#include <flixel/system/FlxSoundGroup.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_SoundFrontEnd
#include <flixel/system/frontEnds/SoundFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_text_FlxText
#include <flixel/text/FlxText.h>
#endif
#ifndef INCLUDED_flixel_util_FlxAxes
#include <flixel/util/FlxAxes.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPooled
#include <flixel/util/IFlxPooled.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_d218b6a33df93d7a_10_new,"WinState","new",0x8ba493e7,"WinState.new","WinState.hx",10,0x86f0a569)
HX_LOCAL_STACK_FRAME(_hx_pos_d218b6a33df93d7a_44_create,"WinState","create",0x209651d5,"WinState.create","WinState.hx",44,0x86f0a569)
HX_LOCAL_STACK_FRAME(_hx_pos_d218b6a33df93d7a_20_create,"WinState","create",0x209651d5,"WinState.create","WinState.hx",20,0x86f0a569)
HX_LOCAL_STACK_FRAME(_hx_pos_d218b6a33df93d7a_56_update,"WinState","update",0x2b8c70e2,"WinState.update","WinState.hx",56,0x86f0a569)
HX_LOCAL_STACK_FRAME(_hx_pos_d218b6a33df93d7a_80_updateEnter,"WinState","updateEnter",0xd1b8f8d6,"WinState.updateEnter","WinState.hx",80,0x86f0a569)
static const int _hx_array_data_90ed1475_5[] = {
	(int)13,(int)32,(int)90,
};
HX_LOCAL_STACK_FRAME(_hx_pos_d218b6a33df93d7a_87_updateEnter,"WinState","updateEnter",0xd1b8f8d6,"WinState.updateEnter","WinState.hx",87,0x86f0a569)

void WinState_obj::__construct( ::Dynamic MaxSize){
            	HX_STACKFRAME(&_hx_pos_d218b6a33df93d7a_10_new)
HXLINE(  17)		this->end = false;
HXLINE(  10)		super::__construct(MaxSize);
            	}

Dynamic WinState_obj::__CreateEmpty() { return new WinState_obj; }

void *WinState_obj::_hx_vtable = 0;

Dynamic WinState_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< WinState_obj > _hx_result = new WinState_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool WinState_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x62817b24) {
		if (inClassId<=(int)0x435fec99) {
			return inClassId==(int)0x00000001 || inClassId==(int)0x435fec99;
		} else {
			return inClassId==(int)0x62817b24;
		}
	} else {
		return inClassId==(int)0x7c795c9f || inClassId==(int)0x7ccf8994;
	}
}

void WinState_obj::create(){
            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_0, ::WinState,_gthis) HXARGC(0)
            		void _hx_run(){
            			HX_GC_STACKFRAME(&_hx_pos_d218b6a33df93d7a_44_create)
HXLINE(  45)			_gthis->name = HX_("assets/data/endingTalk.txt",ee,8f,01,46);
HXLINE(  46)			_gthis->dia->diaUpDown = HX_("down",62,f8,6d,42);
HXLINE(  47)			_gthis->dia->show(_gthis->name,true);
HXLINE(  48)			_gthis->end = true;
            		}
            		HX_END_LOCAL_FUNC0((void))

            	HX_GC_STACKFRAME(&_hx_pos_d218b6a33df93d7a_20_create)
HXDLIN(  20)		 ::WinState _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE(  22)		this->dia =  ::Dia_obj::__alloc( HX_CTX );
HXLINE(  23)		this->add(this->dia);
HXLINE(  26)		this->creditText =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,0,(::flixel::FlxG_obj::height + 10),600,HX_W(u"\u7a0b\u5f0f\u8a2d\u8a08/Annie\n\u7f8e\u8853-\u4eba\u7269\u8a2d\u8a08/\u5473\u564c\u4e38\n\u7f8e\u8853-\u5834\u666f\u88fd\u4f5c/Penguin\n\u5340\u584a\u93c8\u77e5\u8b58\u9867\u554f/\u8ca2\u4e38\n\u97f3\u6a02/ https://www.bensound.com\nMusic Atelier Amacha\n\u97f3\u6548\uff1a\u304f\u3089\u3052\u5de5\u5320",825c,9fd5),60,null());
HXLINE(  28)		this->creditText->screenCenter(::flixel::util::FlxAxes_obj::X_dyn());
HXLINE(  29)		this->creditText->set_font(HX_("assets/data/silver.ttf",3e,fd,5b,64));
HXLINE(  30)		this->creditText->set_alignment(HX_("center",d5,25,db,05));
HXLINE(  31)		this->add(this->creditText);
HXLINE(  32)		this->creditText->set_visible(false);
HXLINE(  35)		this->thankYouText =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,0,0,::flixel::FlxG_obj::width,HX_W(u"\u611f\u8b1d\u904a\u73a9\uff01",41cc,710d),200,null());
HXLINE(  36)		this->thankYouText->screenCenter(null());
HXLINE(  37)		this->thankYouText->set_font(HX_("assets/data/silver.ttf",3e,fd,5b,64));
HXLINE(  38)		this->thankYouText->set_alignment(HX_("center",d5,25,db,05));
HXLINE(  39)		this->add(this->thankYouText);
HXLINE(  40)		this->thankYouText->set_visible(false);
HXLINE(  43)		::flixel::FlxG_obj::camera->fade(-16777216,((Float)0.33),true, ::Dynamic(new _hx_Closure_0(_gthis)),null());
HXLINE(  51)		::flixel::FlxG_obj::sound->playMusic(HX_("assets/music/creditTheme.ogg",7b,e9,04,41),((Float)0.3),true,null());
HXLINE(  52)		this->super::create();
            	}


void WinState_obj::update(Float elapsed){
            	HX_STACKFRAME(&_hx_pos_d218b6a33df93d7a_56_update)
HXLINE(  57)		this->super::update(elapsed);
HXLINE(  58)		this->updateEnter();
HXLINE(  60)		bool _hx_tmp;
HXDLIN(  60)		if (!(this->dia->visible)) {
HXLINE(  60)			_hx_tmp = this->end;
            		}
            		else {
HXLINE(  60)			_hx_tmp = false;
            		}
HXDLIN(  60)		if (_hx_tmp) {
HXLINE(  62)			this->end = false;
HXLINE(  64)			this->creditText->set_visible(true);
HXLINE(  65)			this->creditText->velocity->set_y(( (Float)(-100) ));
HXLINE(  66)			this->creditText->set_moves(true);
            		}
HXLINE(  69)		bool _hx_tmp1;
HXDLIN(  69)		Float _hx_tmp2 = this->creditText->y;
HXDLIN(  69)		if ((_hx_tmp2 < (-(this->creditText->get_height()) + 10))) {
HXLINE(  69)			_hx_tmp1 = !(this->thankYouText->visible);
            		}
            		else {
HXLINE(  69)			_hx_tmp1 = false;
            		}
HXDLIN(  69)		if (_hx_tmp1) {
HXLINE(  71)			this->creditText->set_visible(false);
HXLINE(  72)			this->thankYouText->set_visible(true);
HXLINE(  73)			this->creditText->velocity->set_y(( (Float)(0) ));
HXLINE(  74)			::flixel::FlxG_obj::camera->fade(-16777216,((Float)0.33),true,null(),null());
            		}
            	}


void WinState_obj::updateEnter(){
            	HX_STACKFRAME(&_hx_pos_d218b6a33df93d7a_80_updateEnter)
HXLINE(  81)		bool enter = ::flixel::FlxG_obj::keys->checkKeyArrayState(::Array_obj< int >::fromData( _hx_array_data_90ed1475_5,3),-1);
HXLINE(  82)		if (enter) {
HXLINE(  84)			if (this->thankYouText->visible) {
            				HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(0)
            				void _hx_run(){
            					HX_GC_STACKFRAME(&_hx_pos_d218b6a33df93d7a_87_updateEnter)
HXLINE(  87)					 ::flixel::FlxState nextState =  ::OpeningState_obj::__alloc( HX_CTX ,false);
HXDLIN(  87)					if (::flixel::FlxG_obj::game->_state->switchTo(nextState)) {
HXLINE(  87)						::flixel::FlxG_obj::game->_requestedState = nextState;
            					}
            				}
            				HX_END_LOCAL_FUNC0((void))

HXLINE(  85)				::flixel::FlxG_obj::camera->fade(-16777216,((Float).33),false, ::Dynamic(new _hx_Closure_0()),null());
            			}
HXLINE(  89)			if (this->creditText->visible) {
HXLINE(  91)				this->creditText->set_visible(false);
HXLINE(  92)				this->thankYouText->set_visible(true);
HXLINE(  93)				::flixel::FlxG_obj::camera->fade(-16777216,((Float).33),true,null(),null());
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(WinState_obj,updateEnter,(void))


::hx::ObjectPtr< WinState_obj > WinState_obj::__new( ::Dynamic MaxSize) {
	::hx::ObjectPtr< WinState_obj > __this = new WinState_obj();
	__this->__construct(MaxSize);
	return __this;
}

::hx::ObjectPtr< WinState_obj > WinState_obj::__alloc(::hx::Ctx *_hx_ctx, ::Dynamic MaxSize) {
	WinState_obj *__this = (WinState_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(WinState_obj), true, "WinState"));
	*(void **)__this = WinState_obj::_hx_vtable;
	__this->__construct(MaxSize);
	return __this;
}

WinState_obj::WinState_obj()
{
}

void WinState_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(WinState);
	HX_MARK_MEMBER_NAME(dia,"dia");
	HX_MARK_MEMBER_NAME(creditText,"creditText");
	HX_MARK_MEMBER_NAME(thankYouText,"thankYouText");
	HX_MARK_MEMBER_NAME(name,"name");
	HX_MARK_MEMBER_NAME(end,"end");
	 ::flixel::FlxState_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void WinState_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(dia,"dia");
	HX_VISIT_MEMBER_NAME(creditText,"creditText");
	HX_VISIT_MEMBER_NAME(thankYouText,"thankYouText");
	HX_VISIT_MEMBER_NAME(name,"name");
	HX_VISIT_MEMBER_NAME(end,"end");
	 ::flixel::FlxState_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val WinState_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"dia") ) { return ::hx::Val( dia ); }
		if (HX_FIELD_EQ(inName,"end") ) { return ::hx::Val( end ); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { return ::hx::Val( name ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return ::hx::Val( create_dyn() ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"creditText") ) { return ::hx::Val( creditText ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"updateEnter") ) { return ::hx::Val( updateEnter_dyn() ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"thankYouText") ) { return ::hx::Val( thankYouText ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val WinState_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"dia") ) { dia=inValue.Cast<  ::Dia >(); return inValue; }
		if (HX_FIELD_EQ(inName,"end") ) { end=inValue.Cast< bool >(); return inValue; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { name=inValue.Cast< ::String >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"creditText") ) { creditText=inValue.Cast<  ::flixel::text::FlxText >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"thankYouText") ) { thankYouText=inValue.Cast<  ::flixel::text::FlxText >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void WinState_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("dia",3c,3d,4c,00));
	outFields->push(HX_("creditText",86,ad,5d,19));
	outFields->push(HX_("thankYouText",62,a9,69,f9));
	outFields->push(HX_("name",4b,72,ff,48));
	outFields->push(HX_("end",db,03,4d,00));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo WinState_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::Dia */ ,(int)offsetof(WinState_obj,dia),HX_("dia",3c,3d,4c,00)},
	{::hx::fsObject /*  ::flixel::text::FlxText */ ,(int)offsetof(WinState_obj,creditText),HX_("creditText",86,ad,5d,19)},
	{::hx::fsObject /*  ::flixel::text::FlxText */ ,(int)offsetof(WinState_obj,thankYouText),HX_("thankYouText",62,a9,69,f9)},
	{::hx::fsString,(int)offsetof(WinState_obj,name),HX_("name",4b,72,ff,48)},
	{::hx::fsBool,(int)offsetof(WinState_obj,end),HX_("end",db,03,4d,00)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *WinState_obj_sStaticStorageInfo = 0;
#endif

static ::String WinState_obj_sMemberFields[] = {
	HX_("dia",3c,3d,4c,00),
	HX_("creditText",86,ad,5d,19),
	HX_("thankYouText",62,a9,69,f9),
	HX_("name",4b,72,ff,48),
	HX_("end",db,03,4d,00),
	HX_("create",fc,66,0f,7c),
	HX_("update",09,86,05,87),
	HX_("updateEnter",4f,d6,1e,56),
	::String(null()) };

::hx::Class WinState_obj::__mClass;

void WinState_obj::__register()
{
	WinState_obj _hx_dummy;
	WinState_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("WinState",75,14,ed,90);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(WinState_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< WinState_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = WinState_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = WinState_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}
