// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_ShopChoice
#include <ShopChoice.h>
#endif

::ShopChoice ShopChoice_obj::buy;

::ShopChoice ShopChoice_obj::chat;

::ShopChoice ShopChoice_obj::exit;

::ShopChoice ShopChoice_obj::main;

::ShopChoice ShopChoice_obj::sell;

bool ShopChoice_obj::__GetStatic(const ::String &inName, ::Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("buy",46,c3,4a,00)) { outValue = ShopChoice_obj::buy; return true; }
	if (inName==HX_("chat",d8,5e,bf,41)) { outValue = ShopChoice_obj::chat; return true; }
	if (inName==HX_("exit",1e,f7,1d,43)) { outValue = ShopChoice_obj::exit; return true; }
	if (inName==HX_("main",39,38,56,48)) { outValue = ShopChoice_obj::main; return true; }
	if (inName==HX_("sell",92,8b,50,4c)) { outValue = ShopChoice_obj::sell; return true; }
	return super::__GetStatic(inName, outValue, inCallProp);
}

HX_DEFINE_CREATE_ENUM(ShopChoice_obj)

int ShopChoice_obj::__FindIndex(::String inName)
{
	if (inName==HX_("buy",46,c3,4a,00)) return 1;
	if (inName==HX_("chat",d8,5e,bf,41)) return 3;
	if (inName==HX_("exit",1e,f7,1d,43)) return 4;
	if (inName==HX_("main",39,38,56,48)) return 0;
	if (inName==HX_("sell",92,8b,50,4c)) return 2;
	return super::__FindIndex(inName);
}

int ShopChoice_obj::__FindArgCount(::String inName)
{
	if (inName==HX_("buy",46,c3,4a,00)) return 0;
	if (inName==HX_("chat",d8,5e,bf,41)) return 0;
	if (inName==HX_("exit",1e,f7,1d,43)) return 0;
	if (inName==HX_("main",39,38,56,48)) return 0;
	if (inName==HX_("sell",92,8b,50,4c)) return 0;
	return super::__FindArgCount(inName);
}

::hx::Val ShopChoice_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("buy",46,c3,4a,00)) return buy;
	if (inName==HX_("chat",d8,5e,bf,41)) return chat;
	if (inName==HX_("exit",1e,f7,1d,43)) return exit;
	if (inName==HX_("main",39,38,56,48)) return main;
	if (inName==HX_("sell",92,8b,50,4c)) return sell;
	return super::__Field(inName,inCallProp);
}

static ::String ShopChoice_obj_sStaticFields[] = {
	HX_("main",39,38,56,48),
	HX_("buy",46,c3,4a,00),
	HX_("sell",92,8b,50,4c),
	HX_("chat",d8,5e,bf,41),
	HX_("exit",1e,f7,1d,43),
	::String(null())
};

::hx::Class ShopChoice_obj::__mClass;

Dynamic __Create_ShopChoice_obj() { return new ShopChoice_obj; }

void ShopChoice_obj::__register()
{

::hx::Static(__mClass) = ::hx::_hx_RegisterClass(HX_("ShopChoice",17,29,bf,fd), ::hx::TCanCast< ShopChoice_obj >,ShopChoice_obj_sStaticFields,0,
	&__Create_ShopChoice_obj, &__Create,
	&super::__SGetClass(), &CreateShopChoice_obj, 0
#ifdef HXCPP_VISIT_ALLOCS
    , 0
#endif
#ifdef HXCPP_SCRIPTABLE
    , 0
#endif
);
	__mClass->mGetStaticField = &ShopChoice_obj::__GetStatic;
}

void ShopChoice_obj::__boot()
{
buy = ::hx::CreateConstEnum< ShopChoice_obj >(HX_("buy",46,c3,4a,00),1);
chat = ::hx::CreateConstEnum< ShopChoice_obj >(HX_("chat",d8,5e,bf,41),3);
exit = ::hx::CreateConstEnum< ShopChoice_obj >(HX_("exit",1e,f7,1d,43),4);
main = ::hx::CreateConstEnum< ShopChoice_obj >(HX_("main",39,38,56,48),0);
sell = ::hx::CreateConstEnum< ShopChoice_obj >(HX_("sell",92,8b,50,4c),2);
}


