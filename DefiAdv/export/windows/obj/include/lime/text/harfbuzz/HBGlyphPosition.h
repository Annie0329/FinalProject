// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_lime_text_harfbuzz_HBGlyphPosition
#define INCLUDED_lime_text_harfbuzz_HBGlyphPosition

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_STACK_FRAME(_hx_pos_ac97e2fa85d7d054_11_new)
HX_DECLARE_CLASS3(lime,text,harfbuzz,HBGlyphPosition)

namespace lime{
namespace text{
namespace harfbuzz{


class HXCPP_CLASS_ATTRIBUTES HBGlyphPosition_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef HBGlyphPosition_obj OBJ_;
		HBGlyphPosition_obj();

	public:
		enum { _hx_ClassId = 0x0ae76535 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="lime.text.harfbuzz.HBGlyphPosition")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"lime.text.harfbuzz.HBGlyphPosition"); }

		inline static ::hx::ObjectPtr< HBGlyphPosition_obj > __new() {
			::hx::ObjectPtr< HBGlyphPosition_obj > __this = new HBGlyphPosition_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< HBGlyphPosition_obj > __alloc(::hx::Ctx *_hx_ctx) {
			HBGlyphPosition_obj *__this = (HBGlyphPosition_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(HBGlyphPosition_obj), false, "lime.text.harfbuzz.HBGlyphPosition"));
			*(void **)__this = HBGlyphPosition_obj::_hx_vtable;
{
            	HX_STACKFRAME(&_hx_pos_ac97e2fa85d7d054_11_new)
            	}
		
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~HBGlyphPosition_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("HBGlyphPosition",1b,a3,0d,8d); }

		int xAdvance;
		int xOffset;
		int yAdvance;
		int yOffset;
};

} // end namespace lime
} // end namespace text
} // end namespace harfbuzz

#endif /* INCLUDED_lime_text_harfbuzz_HBGlyphPosition */ 
