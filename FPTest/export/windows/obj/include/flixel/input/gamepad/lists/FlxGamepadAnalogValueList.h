// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_flixel_input_gamepad_lists_FlxGamepadAnalogValueList
#define INCLUDED_flixel_input_gamepad_lists_FlxGamepadAnalogValueList

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS3(flixel,input,gamepad,FlxGamepad)
HX_DECLARE_CLASS4(flixel,input,gamepad,lists,FlxGamepadAnalogValueList)
HX_DECLARE_CLASS2(flixel,util,IFlxDestroyable)

namespace flixel{
namespace input{
namespace gamepad{
namespace lists{


class HXCPP_CLASS_ATTRIBUTES FlxGamepadAnalogValueList_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef FlxGamepadAnalogValueList_obj OBJ_;
		FlxGamepadAnalogValueList_obj();

	public:
		enum { _hx_ClassId = 0x7bd094d2 };

		void __construct( ::flixel::input::gamepad::FlxGamepad gamepad);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="flixel.input.gamepad.lists.FlxGamepadAnalogValueList")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"flixel.input.gamepad.lists.FlxGamepadAnalogValueList"); }
		static ::hx::ObjectPtr< FlxGamepadAnalogValueList_obj > __new( ::flixel::input::gamepad::FlxGamepad gamepad);
		static ::hx::ObjectPtr< FlxGamepadAnalogValueList_obj > __alloc(::hx::Ctx *_hx_ctx, ::flixel::input::gamepad::FlxGamepad gamepad);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~FlxGamepadAnalogValueList_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("FlxGamepadAnalogValueList",70,1a,8e,26); }

		 ::flixel::input::gamepad::FlxGamepad gamepad;
		Float get_LEFT_STICK_X();
		::Dynamic get_LEFT_STICK_X_dyn();

		Float get_LEFT_STICK_Y();
		::Dynamic get_LEFT_STICK_Y_dyn();

		Float get_RIGHT_STICK_X();
		::Dynamic get_RIGHT_STICK_X_dyn();

		Float get_RIGHT_STICK_Y();
		::Dynamic get_RIGHT_STICK_Y_dyn();

		Float get_LEFT_TRIGGER();
		::Dynamic get_LEFT_TRIGGER_dyn();

		Float get_RIGHT_TRIGGER();
		::Dynamic get_RIGHT_TRIGGER_dyn();

		Float get_POINTER_X();
		::Dynamic get_POINTER_X_dyn();

		Float get_POINTER_Y();
		::Dynamic get_POINTER_Y_dyn();

		Float getAxis(int id);
		::Dynamic getAxis_dyn();

		Float getXAxis(int id);
		::Dynamic getXAxis_dyn();

		Float getYAxis(int id);
		::Dynamic getYAxis_dyn();

};

} // end namespace flixel
} // end namespace input
} // end namespace gamepad
} // end namespace lists

#endif /* INCLUDED_flixel_input_gamepad_lists_FlxGamepadAnalogValueList */ 
