// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_Dia
#include <Dia.h>
#endif
#ifndef INCLUDED_MenuState
#include <MenuState.h>
#endif
#ifndef INCLUDED_OpeningState
#include <OpeningState.h>
#endif
#ifndef INCLUDED_PlayState
#include <PlayState.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
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
#ifndef INCLUDED_flixel_addons_text_FlxTypeText
#include <flixel/addons/text/FlxTypeText.h>
#endif
#ifndef INCLUDED_flixel_animation_FlxAnimationController
#include <flixel/animation/FlxAnimationController.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_input_FlxKeyManager
#include <flixel/input/FlxKeyManager.h>
#endif
#ifndef INCLUDED_flixel_input_FlxPointer
#include <flixel/input/FlxPointer.h>
#endif
#ifndef INCLUDED_flixel_input_IFlxInputManager
#include <flixel/input/IFlxInputManager.h>
#endif
#ifndef INCLUDED_flixel_input_keyboard_FlxKeyboard
#include <flixel/input/keyboard/FlxKeyboard.h>
#endif
#ifndef INCLUDED_flixel_input_keyboard__FlxKey_FlxKey_Impl_
#include <flixel/input/keyboard/_FlxKey/FlxKey_Impl_.h>
#endif
#ifndef INCLUDED_flixel_input_mouse_FlxMouse
#include <flixel/input/mouse/FlxMouse.h>
#endif
#ifndef INCLUDED_flixel_math_FlxPoint
#include <flixel/math/FlxPoint.h>
#endif
#ifndef INCLUDED_flixel_text_FlxText
#include <flixel/text/FlxText.h>
#endif
#ifndef INCLUDED_flixel_tweens_FlxTween
#include <flixel/tweens/FlxTween.h>
#endif
#ifndef INCLUDED_flixel_tweens_misc_VarTween
#include <flixel/tweens/misc/VarTween.h>
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
#ifndef INCLUDED_haxe_IMap
#include <haxe/IMap.h>
#endif
#ifndef INCLUDED_haxe_ds_StringMap
#include <haxe/ds/StringMap.h>
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
#ifndef INCLUDED_openfl_utils_Assets
#include <openfl/utils/Assets.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_34142f3ba2c526b0_12_new,"OpeningState","new",0xda73812b,"OpeningState.new","OpeningState.hx",12,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_93_create,"OpeningState","create",0x5b0c0711,"OpeningState.create","OpeningState.hx",93,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_39_create,"OpeningState","create",0x5b0c0711,"OpeningState.create","OpeningState.hx",39,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_107_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",107,0x7e1c0ca5)
static const int _hx_array_data_c6630fb9_4[] = {
	(int)69,
};
static const int _hx_array_data_c6630fb9_5[] = {
	(int)88,(int)27,
};
static const int _hx_array_data_c6630fb9_6[] = {
	(int)-2,
};
static const int _hx_array_data_c6630fb9_7[] = {
	(int)13,(int)32,(int)90,
};
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_126_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",126,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_142_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",142,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_137_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",137,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_154_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",154,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_149_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",149,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_167_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",167,0x7e1c0ca5)
HX_LOCAL_STACK_FRAME(_hx_pos_34142f3ba2c526b0_176_update,"OpeningState","update",0x6602261e,"OpeningState.update","OpeningState.hx",176,0x7e1c0ca5)

void OpeningState_obj::__construct(bool openAni){
            	HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_12_new)
HXLINE(  24)		this->diaName = HX_("assets/data/closeText.txt",6e,b9,62,45);
HXLINE(  23)		this->name = HX_("assets/data/openText.txt",92,22,05,56);
HXLINE(  21)		this->textRunDone = false;
HXLINE(  18)		this->i = 0;
HXLINE(  14)		this->openAni = true;
HXLINE(  34)		super::__construct(null());
HXLINE(  35)		this->openAni = openAni;
            	}

Dynamic OpeningState_obj::__CreateEmpty() { return new OpeningState_obj; }

void *OpeningState_obj::_hx_vtable = 0;

Dynamic OpeningState_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< OpeningState_obj > _hx_result = new OpeningState_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool OpeningState_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x62817b24) {
		if (inClassId<=(int)0x13d93141) {
			return inClassId==(int)0x00000001 || inClassId==(int)0x13d93141;
		} else {
			return inClassId==(int)0x62817b24;
		}
	} else {
		return inClassId==(int)0x7c795c9f || inClassId==(int)0x7ccf8994;
	}
}

void OpeningState_obj::create(){
            		HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_0, ::OpeningState,_gthis) HXARGC(0)
            		void _hx_run(){
            			HX_GC_STACKFRAME(&_hx_pos_34142f3ba2c526b0_93_create)
HXLINE(  93)			_gthis->textRunDone = true;
            		}
            		HX_END_LOCAL_FUNC0((void))

            	HX_GC_STACKFRAME(&_hx_pos_34142f3ba2c526b0_39_create)
HXDLIN(  39)		 ::OpeningState _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE(  41)		this->guide =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,0,0,1200,HX_W(u"\u64cd\u4f5c\u8aaa\u660e\uff1a\nENTER\u3001SPACE\u3001Z\uff1a\u8abf\u67e5\u3001\u5c0d\u8a71\u63db\u884c\u3001\u78ba\u5b9a\nX\u3001SHIFT\uff1a\u53d6\u6d88\nC\uff1a\u67e5\u770b\u6301\u6709\u7269\u54c1",9998,aac9),84,true);
HXLINE(  42)		this->guide->set_font(HX_("assets/data/silver.ttf",3e,fd,5b,64));
HXLINE(  43)		this->guide->screenCenter(null());
HXLINE(  44)		this->guide->set_visible(false);
HXLINE(  45)		this->add(this->guide);
HXLINE(  48)		this->openingAnimation =  ::flixel::FlxSprite_obj::__alloc( HX_CTX ,null(),null(),null());
HXLINE(  49)		if (this->openAni) {
HXLINE(  50)			this->openingAnimation->loadGraphic(HX_("assets/images/openingAnimation.png",f2,42,80,b8),true,1440,1080,null(),null());
            		}
            		else {
HXLINE(  52)			this->openingAnimation->loadGraphic(HX_("assets/images/closingAnimation.png",35,a9,3e,1e),true,1440,1080,null(),null());
            		}
HXLINE(  53)		this->openingAnimation->setGraphicSize(1080,810);
HXLINE(  54)		this->openingAnimation->updateHitbox();
HXLINE(  55)		this->openingAnimation->screenCenter(::flixel::util::FlxAxes_obj::X_dyn());
HXLINE(  56)		this->add(this->openingAnimation);
HXLINE(  57)		this->openingAnimation->animation->set_frameIndex(this->i);
HXLINE(  60)		Float _hx_tmp = this->openingAnimation->x;
HXDLIN(  60)		this->openText =  ::flixel::addons::text::FlxTypeText_obj::__alloc( HX_CTX ,_hx_tmp,(this->openingAnimation->get_height() + 30),1080,HX_("text",ad,cc,f9,4c),84,true);
HXLINE(  61)		this->openText->delay = ((Float)0.05);
HXLINE(  62)		int _hx_tmp1;
HXDLIN(  62)		::String s = HX_("X",58,00,00,00);
HXDLIN(  62)		s = s.toUpperCase();
HXDLIN(  62)		if (::flixel::input::keyboard::_FlxKey::FlxKey_Impl__obj::fromStringMap->exists(s)) {
HXLINE(  62)			_hx_tmp1 = ::flixel::input::keyboard::_FlxKey::FlxKey_Impl__obj::fromStringMap->get_int(s);
            		}
            		else {
HXLINE(  62)			_hx_tmp1 = -1;
            		}
HXDLIN(  62)		::String s1 = HX_("SHIFT",62,24,11,fa);
HXDLIN(  62)		s1 = s1.toUpperCase();
HXDLIN(  62)		int _hx_tmp2;
HXDLIN(  62)		if (::flixel::input::keyboard::_FlxKey::FlxKey_Impl__obj::fromStringMap->exists(s1)) {
HXLINE(  62)			_hx_tmp2 = ::flixel::input::keyboard::_FlxKey::FlxKey_Impl__obj::fromStringMap->get_int(s1);
            		}
            		else {
HXLINE(  62)			_hx_tmp2 = -1;
            		}
HXDLIN(  62)		this->openText->skipKeys = ::Array_obj< int >::__new(2)->init(0,_hx_tmp1)->init(1,_hx_tmp2);
HXLINE(  63)		this->openText->set_font(HX_("assets/data/silver.ttf",3e,fd,5b,64));
HXLINE(  66)		this->add(this->openText);
HXLINE(  68)		if (this->openAni) {
HXLINE(  69)			this->dilog_boxes = ::openfl::utils::Assets_obj::getText(this->name).split(HX_(":",3a,00,00,00));
            		}
            		else {
HXLINE(  71)			this->dilog_boxes = ::openfl::utils::Assets_obj::getText(this->diaName).split(HX_(":",3a,00,00,00));
            		}
HXLINE(  72)		this->i = 0;
HXLINE(  75)		this->dia =  ::Dia_obj::__alloc( HX_CTX );
HXLINE(  76)		this->add(this->dia);
HXLINE(  79)		this->ufo =  ::flixel::text::FlxText_obj::__alloc( HX_CTX ,0,0,600,HX_("ufo",fe,20,59,00),60,null());
HXLINE(  80)		this->ufo->scrollFactor->set(0,0);
HXLINE(  81)		this->ufo->set_color(-1);
HXLINE(  82)		this->add(this->ufo);
HXLINE(  83)		this->ufo->set_visible(false);
HXLINE(  85)		::flixel::FlxG_obj::mouse->set_visible(false);
HXLINE(  88)		this->openText->set_visible(true);
HXLINE(  89)		this->textRunDone = false;
HXLINE(  90)		this->openText->resetText(this->dilog_boxes->__get((this->i + 1)));
HXLINE(  91)		this->openText->start(null(),false,false,null(), ::Dynamic(new _hx_Closure_0(_gthis)));
HXLINE( 102)		::flixel::FlxG_obj::camera->fade(-16777216,((Float)0.33),true,null(),null());
HXLINE( 103)		this->super::create();
            	}


void OpeningState_obj::update(Float elapsed){
            	HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_107_update)
HXDLIN( 107)		 ::OpeningState _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE( 108)		this->super::update(elapsed);
HXLINE( 111)		bool e = ::flixel::FlxG_obj::keys->checkKeyArrayState(::Array_obj< int >::fromData( _hx_array_data_c6630fb9_4,1),-1);
HXLINE( 112)		if (e) {
HXLINE( 114)			this->ufo->set_visible(true);
            		}
HXLINE( 116)		bool x = ::flixel::FlxG_obj::keys->checkKeyArrayState(::Array_obj< int >::fromData( _hx_array_data_c6630fb9_5,2),-1);
HXLINE( 117)		bool any = ::flixel::FlxG_obj::keys->checkKeyArrayState(::Array_obj< int >::fromData( _hx_array_data_c6630fb9_6,1),-1);
HXLINE( 118)		bool enter = ::flixel::FlxG_obj::keys->checkKeyArrayState(::Array_obj< int >::fromData( _hx_array_data_c6630fb9_7,3),-1);
HXLINE( 120)		 ::flixel::text::FlxText _hx_tmp = this->ufo;
HXDLIN( 120)		::String _hx_tmp1 = ::Std_obj::string(this->textRunDone);
HXDLIN( 120)		_hx_tmp->set_text((_hx_tmp1 + ::Std_obj::string(enter)));
HXLINE( 122)		bool _hx_tmp2;
HXDLIN( 122)		bool _hx_tmp3;
HXDLIN( 122)		if (!(this->openingAnimation->visible)) {
HXLINE( 122)			_hx_tmp3 = any;
            		}
            		else {
HXLINE( 122)			_hx_tmp3 = false;
            		}
HXDLIN( 122)		if (!(_hx_tmp3)) {
HXLINE( 122)			_hx_tmp2 = x;
            		}
            		else {
HXLINE( 122)			_hx_tmp2 = true;
            		}
HXDLIN( 122)		if (_hx_tmp2) {
            			HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_0) HXARGC(0)
            			void _hx_run(){
            				HX_GC_STACKFRAME(&_hx_pos_34142f3ba2c526b0_126_update)
HXLINE( 126)				 ::flixel::FlxState nextState =  ::PlayState_obj::__alloc( HX_CTX ,false);
HXDLIN( 126)				if (::flixel::FlxG_obj::game->_state->switchTo(nextState)) {
HXLINE( 126)					::flixel::FlxG_obj::game->_requestedState = nextState;
            				}
            			}
            			HX_END_LOCAL_FUNC0((void))

HXLINE( 124)			::flixel::FlxG_obj::camera->fade(-16777216,((Float).33),false, ::Dynamic(new _hx_Closure_0()),null());
            		}
HXLINE( 131)		bool _hx_tmp4;
HXDLIN( 131)		if (enter) {
HXLINE( 131)			_hx_tmp4 = this->textRunDone;
            		}
            		else {
HXLINE( 131)			_hx_tmp4 = false;
            		}
HXDLIN( 131)		if (_hx_tmp4) {
HXLINE( 134)			bool _hx_tmp;
HXDLIN( 134)			if (this->openAni) {
HXLINE( 134)				_hx_tmp = (this->i > 9);
            			}
            			else {
HXLINE( 134)				_hx_tmp = false;
            			}
HXDLIN( 134)			if (_hx_tmp) {
            				HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_2, ::OpeningState,_gthis) HXARGC(0)
            				void _hx_run(){
            					HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_1) HXARGC(0)
            					void _hx_run(){
            						HX_GC_STACKFRAME(&_hx_pos_34142f3ba2c526b0_142_update)
HXLINE( 142)						 ::flixel::FlxState nextState =  ::PlayState_obj::__alloc( HX_CTX ,false);
HXDLIN( 142)						if (::flixel::FlxG_obj::game->_state->switchTo(nextState)) {
HXLINE( 142)							::flixel::FlxG_obj::game->_requestedState = nextState;
            						}
            					}
            					HX_END_LOCAL_FUNC0((void))

            					HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_137_update)
HXLINE( 138)					_gthis->openingAnimation->set_visible(false);
HXLINE( 139)					_gthis->openText->set_visible(false);
HXLINE( 140)					::flixel::FlxG_obj::camera->fade(-540,1,true, ::Dynamic(new _hx_Closure_1()),null());
            				}
            				HX_END_LOCAL_FUNC0((void))

HXLINE( 136)				::flixel::FlxG_obj::camera->fade(-540,1,false, ::Dynamic(new _hx_Closure_2(_gthis)),null());
            			}
            			else {
HXLINE( 146)				bool _hx_tmp;
HXDLIN( 146)				if (!(this->openAni)) {
HXLINE( 146)					_hx_tmp = (this->i > 6);
            				}
            				else {
HXLINE( 146)					_hx_tmp = false;
            				}
HXDLIN( 146)				if (_hx_tmp) {
            					HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_4, ::OpeningState,_gthis) HXARGC(0)
            					void _hx_run(){
            						HX_BEGIN_LOCAL_FUNC_S0(::hx::LocalFunc,_hx_Closure_3) HXARGC(0)
            						void _hx_run(){
            							HX_GC_STACKFRAME(&_hx_pos_34142f3ba2c526b0_154_update)
HXLINE( 154)							 ::flixel::FlxState nextState =  ::MenuState_obj::__alloc( HX_CTX ,null());
HXDLIN( 154)							if (::flixel::FlxG_obj::game->_state->switchTo(nextState)) {
HXLINE( 154)								::flixel::FlxG_obj::game->_requestedState = nextState;
            							}
            						}
            						HX_END_LOCAL_FUNC0((void))

            						HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_149_update)
HXLINE( 150)						_gthis->openingAnimation->set_visible(false);
HXLINE( 151)						_gthis->openText->set_visible(false);
HXLINE( 152)						::flixel::FlxG_obj::camera->fade(-16777216,1,true, ::Dynamic(new _hx_Closure_3()),null());
            					}
            					HX_END_LOCAL_FUNC0((void))

HXLINE( 148)					::flixel::FlxG_obj::camera->fade(-16777216,1,false, ::Dynamic(new _hx_Closure_4(_gthis)),null());
            				}
            				else {
            					HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_5, ::OpeningState,_gthis) HXARGC(0)
            					void _hx_run(){
            						HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_167_update)
HXLINE( 167)						_gthis->textRunDone = true;
            					}
            					HX_END_LOCAL_FUNC0((void))

HXLINE( 160)					this->i++;
HXLINE( 163)					this->textRunDone = false;
HXLINE( 164)					this->openText->resetText(this->dilog_boxes->__get((this->i + 1)));
HXLINE( 165)					this->openText->start(null(),false,false,null(), ::Dynamic(new _hx_Closure_5(_gthis)));
HXLINE( 171)					bool _hx_tmp;
HXDLIN( 171)					if (!(this->openAni)) {
HXLINE( 171)						_hx_tmp = (this->i == 3);
            					}
            					else {
HXLINE( 171)						_hx_tmp = false;
            					}
HXDLIN( 171)					if (_hx_tmp) {
HXLINE( 172)						this->openingAnimation->animation->set_frameIndex(this->i);
            					}
            					else {
            						HX_BEGIN_LOCAL_FUNC_S1(::hx::LocalFunc,_hx_Closure_6, ::OpeningState,_gthis) HXARGC(1)
            						void _hx_run( ::flixel::tweens::FlxTween _){
            							HX_STACKFRAME(&_hx_pos_34142f3ba2c526b0_176_update)
HXLINE( 177)							_gthis->openingAnimation->animation->set_frameIndex(_gthis->i);
HXLINE( 178)							::flixel::tweens::FlxTween_obj::tween(_gthis->openingAnimation, ::Dynamic(::hx::Anon_obj::Create(1)
            								->setFixed(0,HX_("alpha",5e,a7,96,21),1)),((Float).33),null());
            						}
            						HX_END_LOCAL_FUNC1((void))

HXLINE( 174)						::flixel::tweens::FlxTween_obj::tween(this->openingAnimation, ::Dynamic(::hx::Anon_obj::Create(1)
            							->setFixed(0,HX_("alpha",5e,a7,96,21),0)),((Float).33), ::Dynamic(::hx::Anon_obj::Create(1)
            							->setFixed(0,HX_("onComplete",f8,d4,7e,5d), ::Dynamic(new _hx_Closure_6(_gthis)))));
            					}
            				}
            			}
            		}
            	}



::hx::ObjectPtr< OpeningState_obj > OpeningState_obj::__new(bool openAni) {
	::hx::ObjectPtr< OpeningState_obj > __this = new OpeningState_obj();
	__this->__construct(openAni);
	return __this;
}

::hx::ObjectPtr< OpeningState_obj > OpeningState_obj::__alloc(::hx::Ctx *_hx_ctx,bool openAni) {
	OpeningState_obj *__this = (OpeningState_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(OpeningState_obj), true, "OpeningState"));
	*(void **)__this = OpeningState_obj::_hx_vtable;
	__this->__construct(openAni);
	return __this;
}

OpeningState_obj::OpeningState_obj()
{
}

void OpeningState_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(OpeningState);
	HX_MARK_MEMBER_NAME(openAni,"openAni");
	HX_MARK_MEMBER_NAME(guide,"guide");
	HX_MARK_MEMBER_NAME(openingAnimation,"openingAnimation");
	HX_MARK_MEMBER_NAME(dia,"dia");
	HX_MARK_MEMBER_NAME(i,"i");
	HX_MARK_MEMBER_NAME(openText,"openText");
	HX_MARK_MEMBER_NAME(dilog_boxes,"dilog_boxes");
	HX_MARK_MEMBER_NAME(textRunDone,"textRunDone");
	HX_MARK_MEMBER_NAME(name,"name");
	HX_MARK_MEMBER_NAME(diaName,"diaName");
	HX_MARK_MEMBER_NAME(ufo,"ufo");
	 ::flixel::FlxState_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void OpeningState_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(openAni,"openAni");
	HX_VISIT_MEMBER_NAME(guide,"guide");
	HX_VISIT_MEMBER_NAME(openingAnimation,"openingAnimation");
	HX_VISIT_MEMBER_NAME(dia,"dia");
	HX_VISIT_MEMBER_NAME(i,"i");
	HX_VISIT_MEMBER_NAME(openText,"openText");
	HX_VISIT_MEMBER_NAME(dilog_boxes,"dilog_boxes");
	HX_VISIT_MEMBER_NAME(textRunDone,"textRunDone");
	HX_VISIT_MEMBER_NAME(name,"name");
	HX_VISIT_MEMBER_NAME(diaName,"diaName");
	HX_VISIT_MEMBER_NAME(ufo,"ufo");
	 ::flixel::FlxState_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val OpeningState_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 1:
		if (HX_FIELD_EQ(inName,"i") ) { return ::hx::Val( i ); }
		break;
	case 3:
		if (HX_FIELD_EQ(inName,"dia") ) { return ::hx::Val( dia ); }
		if (HX_FIELD_EQ(inName,"ufo") ) { return ::hx::Val( ufo ); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { return ::hx::Val( name ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"guide") ) { return ::hx::Val( guide ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return ::hx::Val( create_dyn() ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"openAni") ) { return ::hx::Val( openAni ); }
		if (HX_FIELD_EQ(inName,"diaName") ) { return ::hx::Val( diaName ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"openText") ) { return ::hx::Val( openText ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"dilog_boxes") ) { return ::hx::Val( dilog_boxes ); }
		if (HX_FIELD_EQ(inName,"textRunDone") ) { return ::hx::Val( textRunDone ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"openingAnimation") ) { return ::hx::Val( openingAnimation ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val OpeningState_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 1:
		if (HX_FIELD_EQ(inName,"i") ) { i=inValue.Cast< int >(); return inValue; }
		break;
	case 3:
		if (HX_FIELD_EQ(inName,"dia") ) { dia=inValue.Cast<  ::Dia >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ufo") ) { ufo=inValue.Cast<  ::flixel::text::FlxText >(); return inValue; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { name=inValue.Cast< ::String >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"guide") ) { guide=inValue.Cast<  ::flixel::text::FlxText >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"openAni") ) { openAni=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"diaName") ) { diaName=inValue.Cast< ::String >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"openText") ) { openText=inValue.Cast<  ::flixel::addons::text::FlxTypeText >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"dilog_boxes") ) { dilog_boxes=inValue.Cast< ::Array< ::String > >(); return inValue; }
		if (HX_FIELD_EQ(inName,"textRunDone") ) { textRunDone=inValue.Cast< bool >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"openingAnimation") ) { openingAnimation=inValue.Cast<  ::flixel::FlxSprite >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void OpeningState_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("openAni",32,a9,26,40));
	outFields->push(HX_("guide",bc,ba,eb,9b));
	outFields->push(HX_("openingAnimation",8c,a0,23,f5));
	outFields->push(HX_("dia",3c,3d,4c,00));
	outFields->push(HX_("i",69,00,00,00));
	outFields->push(HX_("openText",97,a9,35,ee));
	outFields->push(HX_("dilog_boxes",d9,d5,2d,6e));
	outFields->push(HX_("textRunDone",40,00,2b,ab));
	outFields->push(HX_("name",4b,72,ff,48));
	outFields->push(HX_("diaName",a7,29,92,47));
	outFields->push(HX_("ufo",fe,20,59,00));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo OpeningState_obj_sMemberStorageInfo[] = {
	{::hx::fsBool,(int)offsetof(OpeningState_obj,openAni),HX_("openAni",32,a9,26,40)},
	{::hx::fsObject /*  ::flixel::text::FlxText */ ,(int)offsetof(OpeningState_obj,guide),HX_("guide",bc,ba,eb,9b)},
	{::hx::fsObject /*  ::flixel::FlxSprite */ ,(int)offsetof(OpeningState_obj,openingAnimation),HX_("openingAnimation",8c,a0,23,f5)},
	{::hx::fsObject /*  ::Dia */ ,(int)offsetof(OpeningState_obj,dia),HX_("dia",3c,3d,4c,00)},
	{::hx::fsInt,(int)offsetof(OpeningState_obj,i),HX_("i",69,00,00,00)},
	{::hx::fsObject /*  ::flixel::addons::text::FlxTypeText */ ,(int)offsetof(OpeningState_obj,openText),HX_("openText",97,a9,35,ee)},
	{::hx::fsObject /* ::Array< ::String > */ ,(int)offsetof(OpeningState_obj,dilog_boxes),HX_("dilog_boxes",d9,d5,2d,6e)},
	{::hx::fsBool,(int)offsetof(OpeningState_obj,textRunDone),HX_("textRunDone",40,00,2b,ab)},
	{::hx::fsString,(int)offsetof(OpeningState_obj,name),HX_("name",4b,72,ff,48)},
	{::hx::fsString,(int)offsetof(OpeningState_obj,diaName),HX_("diaName",a7,29,92,47)},
	{::hx::fsObject /*  ::flixel::text::FlxText */ ,(int)offsetof(OpeningState_obj,ufo),HX_("ufo",fe,20,59,00)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *OpeningState_obj_sStaticStorageInfo = 0;
#endif

static ::String OpeningState_obj_sMemberFields[] = {
	HX_("openAni",32,a9,26,40),
	HX_("guide",bc,ba,eb,9b),
	HX_("openingAnimation",8c,a0,23,f5),
	HX_("dia",3c,3d,4c,00),
	HX_("i",69,00,00,00),
	HX_("openText",97,a9,35,ee),
	HX_("dilog_boxes",d9,d5,2d,6e),
	HX_("textRunDone",40,00,2b,ab),
	HX_("name",4b,72,ff,48),
	HX_("diaName",a7,29,92,47),
	HX_("ufo",fe,20,59,00),
	HX_("create",fc,66,0f,7c),
	HX_("update",09,86,05,87),
	::String(null()) };

::hx::Class OpeningState_obj::__mClass;

void OpeningState_obj::__register()
{
	OpeningState_obj _hx_dummy;
	OpeningState_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("OpeningState",b9,0f,63,c6);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(OpeningState_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< OpeningState_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = OpeningState_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = OpeningState_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

