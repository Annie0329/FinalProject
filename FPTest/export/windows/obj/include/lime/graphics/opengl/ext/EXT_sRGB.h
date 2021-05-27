// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_lime_graphics_opengl_ext_EXT_sRGB
#define INCLUDED_lime_graphics_opengl_ext_EXT_sRGB

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_STACK_FRAME(_hx_pos_36f3917dca2bced0_5_new)
HX_DECLARE_CLASS4(lime,graphics,opengl,ext,EXT_sRGB)

namespace lime{
namespace graphics{
namespace opengl{
namespace ext{


class HXCPP_CLASS_ATTRIBUTES EXT_sRGB_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef EXT_sRGB_obj OBJ_;
		EXT_sRGB_obj();

	public:
		enum { _hx_ClassId = 0x2a1af842 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="lime.graphics.opengl.ext.EXT_sRGB")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"lime.graphics.opengl.ext.EXT_sRGB"); }

		inline static ::hx::ObjectPtr< EXT_sRGB_obj > __new() {
			::hx::ObjectPtr< EXT_sRGB_obj > __this = new EXT_sRGB_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< EXT_sRGB_obj > __alloc(::hx::Ctx *_hx_ctx) {
			EXT_sRGB_obj *__this = (EXT_sRGB_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(EXT_sRGB_obj), false, "lime.graphics.opengl.ext.EXT_sRGB"));
			*(void **)__this = EXT_sRGB_obj::_hx_vtable;
{
            	HX_STACKFRAME(&_hx_pos_36f3917dca2bced0_5_new)
HXLINE(  10)		( ( ::lime::graphics::opengl::ext::EXT_sRGB)(__this) )->FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING_EXT = 33296;
HXLINE(   9)		( ( ::lime::graphics::opengl::ext::EXT_sRGB)(__this) )->SRGB8_ALPHA8_EXT = 35907;
HXLINE(   8)		( ( ::lime::graphics::opengl::ext::EXT_sRGB)(__this) )->SRGB_ALPHA_EXT = 35906;
HXLINE(   7)		( ( ::lime::graphics::opengl::ext::EXT_sRGB)(__this) )->SRGB_EXT = 35904;
            	}
		
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~EXT_sRGB_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("EXT_sRGB",18,00,47,4b); }

		int SRGB_EXT;
		int SRGB_ALPHA_EXT;
		int SRGB8_ALPHA8_EXT;
		int FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING_EXT;
};

} // end namespace lime
} // end namespace graphics
} // end namespace opengl
} // end namespace ext

#endif /* INCLUDED_lime_graphics_opengl_ext_EXT_sRGB */ 
