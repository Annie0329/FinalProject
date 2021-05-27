// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_openfl_ui_GameInputDevice
#define INCLUDED_openfl_ui_GameInputDevice

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(haxe,IMap)
HX_DECLARE_CLASS2(haxe,ds,IntMap)
HX_DECLARE_CLASS2(haxe,io,Bytes)
HX_DECLARE_CLASS2(lime,ui,Gamepad)
HX_DECLARE_CLASS2(openfl,_Vector,IVector)
HX_DECLARE_CLASS2(openfl,_Vector,ObjectVector)
HX_DECLARE_CLASS2(openfl,events,EventDispatcher)
HX_DECLARE_CLASS2(openfl,events,IEventDispatcher)
HX_DECLARE_CLASS2(openfl,ui,GameInputControl)
HX_DECLARE_CLASS2(openfl,ui,GameInputDevice)
HX_DECLARE_CLASS2(openfl,utils,ByteArrayData)
HX_DECLARE_CLASS2(openfl,utils,IDataInput)
HX_DECLARE_CLASS2(openfl,utils,IDataOutput)

namespace openfl{
namespace ui{


class HXCPP_CLASS_ATTRIBUTES GameInputDevice_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef GameInputDevice_obj OBJ_;
		GameInputDevice_obj();

	public:
		enum { _hx_ClassId = 0x1bd2e2aa };

		void __construct(::String id,::String name);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="openfl.ui.GameInputDevice")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"openfl.ui.GameInputDevice"); }
		static ::hx::ObjectPtr< GameInputDevice_obj > __new(::String id,::String name);
		static ::hx::ObjectPtr< GameInputDevice_obj > __alloc(::hx::Ctx *_hx_ctx,::String id,::String name);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~GameInputDevice_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("GameInputDevice",4e,e5,cf,03); }

		static void __boot();
		static int MAX_BUFFER_SIZE;
		bool enabled;
		::String id;
		::String name;
		int sampleInterval;
		 ::haxe::ds::IntMap _hx___axis;
		 ::haxe::ds::IntMap _hx___button;
		::Array< ::Dynamic> _hx___controls;
		 ::lime::ui::Gamepad _hx___gamepad;
		int getCachedSamples( ::openfl::utils::ByteArrayData data,::hx::Null< bool >  append);
		::Dynamic getCachedSamples_dyn();

		 ::openfl::ui::GameInputControl getControlAt(int i);
		::Dynamic getControlAt_dyn();

		void startCachingSamples(int numSamples, ::openfl::_Vector::ObjectVector controls);
		::Dynamic startCachingSamples_dyn();

		void stopCachingSamples();
		::Dynamic stopCachingSamples_dyn();

		int get_numControls();
		::Dynamic get_numControls_dyn();

};

} // end namespace openfl
} // end namespace ui

#endif /* INCLUDED_openfl_ui_GameInputDevice */ 
