// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_ShopChoice
#define INCLUDED_ShopChoice

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(ShopChoice)


class ShopChoice_obj : public ::hx::EnumBase_obj
{
	typedef ::hx::EnumBase_obj super;
		typedef ShopChoice_obj OBJ_;

	public:
		ShopChoice_obj() {};
		HX_DO_ENUM_RTTI;
		static void __boot();
		static void __register();
		static bool __GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		::String GetEnumName( ) const { return HX_("ShopChoice",17,29,bf,fd); }
		::String __ToString() const { return HX_("ShopChoice.",37,cb,84,09) + _hx_tag; }

		static ::ShopChoice buy;
		static inline ::ShopChoice buy_dyn() { return buy; }
		static ::ShopChoice chat;
		static inline ::ShopChoice chat_dyn() { return chat; }
		static ::ShopChoice exit;
		static inline ::ShopChoice exit_dyn() { return exit; }
		static ::ShopChoice main;
		static inline ::ShopChoice main_dyn() { return main; }
		static ::ShopChoice sell;
		static inline ::ShopChoice sell_dyn() { return sell; }
};


#endif /* INCLUDED_ShopChoice */ 