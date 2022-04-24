// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_flixel_tweens_misc_NumTween
#define INCLUDED_flixel_tweens_misc_NumTween

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_tweens_FlxTween
#include <flixel/tweens/FlxTween.h>
#endif
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS2(flixel,tweens,FlxTween)
HX_DECLARE_CLASS2(flixel,tweens,FlxTweenManager)
HX_DECLARE_CLASS3(flixel,tweens,misc,NumTween)
HX_DECLARE_CLASS2(flixel,util,IFlxDestroyable)

namespace flixel{
namespace tweens{
namespace misc{


class HXCPP_CLASS_ATTRIBUTES NumTween_obj : public  ::flixel::tweens::FlxTween_obj
{
	public:
		typedef  ::flixel::tweens::FlxTween_obj super;
		typedef NumTween_obj OBJ_;
		NumTween_obj();

	public:
		enum { _hx_ClassId = 0x70fdc21d };

		void __construct( ::Dynamic Options, ::flixel::tweens::FlxTweenManager manager);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="flixel.tweens.misc.NumTween")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"flixel.tweens.misc.NumTween"); }
		static ::hx::ObjectPtr< NumTween_obj > __new( ::Dynamic Options, ::flixel::tweens::FlxTweenManager manager);
		static ::hx::ObjectPtr< NumTween_obj > __alloc(::hx::Ctx *_hx_ctx, ::Dynamic Options, ::flixel::tweens::FlxTweenManager manager);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~NumTween_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("NumTween",65,7a,32,b0); }

		Float value;
		 ::Dynamic _tweenFunction;
		Dynamic _tweenFunction_dyn() { return _tweenFunction;}
		Float _start;
		Float _range;
		void destroy();

		 ::flixel::tweens::misc::NumTween tween(Float fromValue,Float toValue,Float duration, ::Dynamic tweenFunction);
		::Dynamic tween_dyn();

		void update(Float elapsed);

};

} // end namespace flixel
} // end namespace tweens
} // end namespace misc

#endif /* INCLUDED_flixel_tweens_misc_NumTween */ 