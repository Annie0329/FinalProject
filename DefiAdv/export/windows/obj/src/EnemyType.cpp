// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_EnemyType
#include <EnemyType.h>
#endif

::EnemyType EnemyType_obj::cloudMiner;

::EnemyType EnemyType_obj::nft;

::EnemyType EnemyType_obj::rod;

::EnemyType EnemyType_obj::shibaCoin;

::EnemyType EnemyType_obj::spartanMiner;

::EnemyType EnemyType_obj::starter;

bool EnemyType_obj::__GetStatic(const ::String &inName, ::Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("cloudMiner",ca,60,19,c0)) { outValue = EnemyType_obj::cloudMiner; return true; }
	if (inName==HX_("nft",3c,d1,53,00)) { outValue = EnemyType_obj::nft; return true; }
	if (inName==HX_("rod",07,e2,56,00)) { outValue = EnemyType_obj::rod; return true; }
	if (inName==HX_("shibaCoin",24,c0,b3,42)) { outValue = EnemyType_obj::shibaCoin; return true; }
	if (inName==HX_("spartanMiner",2c,a1,5a,f9)) { outValue = EnemyType_obj::spartanMiner; return true; }
	if (inName==HX_("starter",4f,29,1b,35)) { outValue = EnemyType_obj::starter; return true; }
	return super::__GetStatic(inName, outValue, inCallProp);
}

HX_DEFINE_CREATE_ENUM(EnemyType_obj)

int EnemyType_obj::__FindIndex(::String inName)
{
	if (inName==HX_("cloudMiner",ca,60,19,c0)) return 1;
	if (inName==HX_("nft",3c,d1,53,00)) return 2;
	if (inName==HX_("rod",07,e2,56,00)) return 4;
	if (inName==HX_("shibaCoin",24,c0,b3,42)) return 0;
	if (inName==HX_("spartanMiner",2c,a1,5a,f9)) return 3;
	if (inName==HX_("starter",4f,29,1b,35)) return 5;
	return super::__FindIndex(inName);
}

int EnemyType_obj::__FindArgCount(::String inName)
{
	if (inName==HX_("cloudMiner",ca,60,19,c0)) return 0;
	if (inName==HX_("nft",3c,d1,53,00)) return 0;
	if (inName==HX_("rod",07,e2,56,00)) return 0;
	if (inName==HX_("shibaCoin",24,c0,b3,42)) return 0;
	if (inName==HX_("spartanMiner",2c,a1,5a,f9)) return 0;
	if (inName==HX_("starter",4f,29,1b,35)) return 0;
	return super::__FindArgCount(inName);
}

::hx::Val EnemyType_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("cloudMiner",ca,60,19,c0)) return cloudMiner;
	if (inName==HX_("nft",3c,d1,53,00)) return nft;
	if (inName==HX_("rod",07,e2,56,00)) return rod;
	if (inName==HX_("shibaCoin",24,c0,b3,42)) return shibaCoin;
	if (inName==HX_("spartanMiner",2c,a1,5a,f9)) return spartanMiner;
	if (inName==HX_("starter",4f,29,1b,35)) return starter;
	return super::__Field(inName,inCallProp);
}

static ::String EnemyType_obj_sStaticFields[] = {
	HX_("shibaCoin",24,c0,b3,42),
	HX_("cloudMiner",ca,60,19,c0),
	HX_("nft",3c,d1,53,00),
	HX_("spartanMiner",2c,a1,5a,f9),
	HX_("rod",07,e2,56,00),
	HX_("starter",4f,29,1b,35),
	::String(null())
};

::hx::Class EnemyType_obj::__mClass;

Dynamic __Create_EnemyType_obj() { return new EnemyType_obj; }

void EnemyType_obj::__register()
{

::hx::Static(__mClass) = ::hx::_hx_RegisterClass(HX_("EnemyType",02,d5,fa,4e), ::hx::TCanCast< EnemyType_obj >,EnemyType_obj_sStaticFields,0,
	&__Create_EnemyType_obj, &__Create,
	&super::__SGetClass(), &CreateEnemyType_obj, 0
#ifdef HXCPP_VISIT_ALLOCS
    , 0
#endif
#ifdef HXCPP_SCRIPTABLE
    , 0
#endif
);
	__mClass->mGetStaticField = &EnemyType_obj::__GetStatic;
}

void EnemyType_obj::__boot()
{
cloudMiner = ::hx::CreateConstEnum< EnemyType_obj >(HX_("cloudMiner",ca,60,19,c0),1);
nft = ::hx::CreateConstEnum< EnemyType_obj >(HX_("nft",3c,d1,53,00),2);
rod = ::hx::CreateConstEnum< EnemyType_obj >(HX_("rod",07,e2,56,00),4);
shibaCoin = ::hx::CreateConstEnum< EnemyType_obj >(HX_("shibaCoin",24,c0,b3,42),0);
spartanMiner = ::hx::CreateConstEnum< EnemyType_obj >(HX_("spartanMiner",2c,a1,5a,f9),3);
starter = ::hx::CreateConstEnum< EnemyType_obj >(HX_("starter",4f,29,1b,35),5);
}


