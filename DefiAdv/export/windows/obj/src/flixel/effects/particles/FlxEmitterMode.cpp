// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_flixel_effects_particles_FlxEmitterMode
#include <flixel/effects/particles/FlxEmitterMode.h>
#endif
namespace flixel{
namespace effects{
namespace particles{

::flixel::effects::particles::FlxEmitterMode FlxEmitterMode_obj::CIRCLE;

::flixel::effects::particles::FlxEmitterMode FlxEmitterMode_obj::SQUARE;

bool FlxEmitterMode_obj::__GetStatic(const ::String &inName, ::Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("CIRCLE",10,1e,90,08)) { outValue = FlxEmitterMode_obj::CIRCLE; return true; }
	if (inName==HX_("SQUARE",9d,ac,74,0b)) { outValue = FlxEmitterMode_obj::SQUARE; return true; }
	return super::__GetStatic(inName, outValue, inCallProp);
}

HX_DEFINE_CREATE_ENUM(FlxEmitterMode_obj)

int FlxEmitterMode_obj::__FindIndex(::String inName)
{
	if (inName==HX_("CIRCLE",10,1e,90,08)) return 1;
	if (inName==HX_("SQUARE",9d,ac,74,0b)) return 0;
	return super::__FindIndex(inName);
}

int FlxEmitterMode_obj::__FindArgCount(::String inName)
{
	if (inName==HX_("CIRCLE",10,1e,90,08)) return 0;
	if (inName==HX_("SQUARE",9d,ac,74,0b)) return 0;
	return super::__FindArgCount(inName);
}

::hx::Val FlxEmitterMode_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("CIRCLE",10,1e,90,08)) return CIRCLE;
	if (inName==HX_("SQUARE",9d,ac,74,0b)) return SQUARE;
	return super::__Field(inName,inCallProp);
}

static ::String FlxEmitterMode_obj_sStaticFields[] = {
	HX_("SQUARE",9d,ac,74,0b),
	HX_("CIRCLE",10,1e,90,08),
	::String(null())
};

::hx::Class FlxEmitterMode_obj::__mClass;

Dynamic __Create_FlxEmitterMode_obj() { return new FlxEmitterMode_obj; }

void FlxEmitterMode_obj::__register()
{

::hx::Static(__mClass) = ::hx::_hx_RegisterClass(HX_("flixel.effects.particles.FlxEmitterMode",1e,d4,79,e9), ::hx::TCanCast< FlxEmitterMode_obj >,FlxEmitterMode_obj_sStaticFields,0,
	&__Create_FlxEmitterMode_obj, &__Create,
	&super::__SGetClass(), &CreateFlxEmitterMode_obj, 0
#ifdef HXCPP_VISIT_ALLOCS
    , 0
#endif
#ifdef HXCPP_SCRIPTABLE
    , 0
#endif
);
	__mClass->mGetStaticField = &FlxEmitterMode_obj::__GetStatic;
}

void FlxEmitterMode_obj::__boot()
{
CIRCLE = ::hx::CreateConstEnum< FlxEmitterMode_obj >(HX_("CIRCLE",10,1e,90,08),1);
SQUARE = ::hx::CreateConstEnum< FlxEmitterMode_obj >(HX_("SQUARE",9d,ac,74,0b),0);
}


} // end namespace flixel
} // end namespace effects
} // end namespace particles
