// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_openfl_display_ShaderParameter_Float
#define INCLUDED_openfl_display_ShaderParameter_Float

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(lime,utils,ArrayBufferView)
HX_DECLARE_CLASS2(openfl,display,ShaderParameter_Float)
HX_DECLARE_CLASS2(openfl,display3D,Context3D)
HX_DECLARE_CLASS2(openfl,events,EventDispatcher)
HX_DECLARE_CLASS2(openfl,events,IEventDispatcher)

namespace openfl{
namespace display{


class HXCPP_CLASS_ATTRIBUTES ShaderParameter_Float_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef ShaderParameter_Float_obj OBJ_;
		ShaderParameter_Float_obj();

	public:
		enum { _hx_ClassId = 0x2004e677 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="openfl.display.ShaderParameter_Float")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"openfl.display.ShaderParameter_Float"); }
		static ::hx::ObjectPtr< ShaderParameter_Float_obj > __new();
		static ::hx::ObjectPtr< ShaderParameter_Float_obj > __alloc(::hx::Ctx *_hx_ctx);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~ShaderParameter_Float_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("ShaderParameter_Float",61,21,40,6e); }

		static void __boot();
		static  ::Dynamic __meta__;
		 ::Dynamic index;
		::String name;
		 ::Dynamic type;
		::Array< Float > value;
		int _hx___arrayLength;
		bool _hx___internal;
		bool _hx___isBool;
		bool _hx___isFloat;
		bool _hx___isInt;
		bool _hx___isUniform;
		int __length;
		 ::lime::utils::ArrayBufferView _hx___uniformMatrix;
		bool _hx___useArray;
		void _hx___disableGL( ::openfl::display3D::Context3D context);
		::Dynamic _hx___disableGL_dyn();

		void _hx___updateGL( ::openfl::display3D::Context3D context,::Array< Float > overrideValue);
		::Dynamic _hx___updateGL_dyn();

		void _hx___updateGLFromBuffer( ::openfl::display3D::Context3D context, ::lime::utils::ArrayBufferView buffer,int position,int length,int bufferOffset);
		::Dynamic _hx___updateGLFromBuffer_dyn();

		::String set_name(::String value);
		::Dynamic set_name_dyn();

};

} // end namespace openfl
} // end namespace display

#endif /* INCLUDED_openfl_display_ShaderParameter_Float */ 