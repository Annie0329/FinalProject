// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_EnemyType
#define INCLUDED_EnemyType

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(EnemyType)


class EnemyType_obj : public ::hx::EnumBase_obj
{
	typedef ::hx::EnumBase_obj super;
		typedef EnemyType_obj OBJ_;

	public:
		EnemyType_obj() {};
		HX_DO_ENUM_RTTI;
		static void __boot();
		static void __register();
		static bool __GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		::String GetEnumName( ) const { return HX_("EnemyType",02,d5,fa,4e); }
		::String __ToString() const { return HX_("EnemyType.",ec,8c,7f,cc) + _hx_tag; }

		static ::EnemyType cloudMiner;
		static inline ::EnemyType cloudMiner_dyn() { return cloudMiner; }
		static ::EnemyType nft;
		static inline ::EnemyType nft_dyn() { return nft; }
		static ::EnemyType rod;
		static inline ::EnemyType rod_dyn() { return rod; }
		static ::EnemyType shibaCoin;
		static inline ::EnemyType shibaCoin_dyn() { return shibaCoin; }
		static ::EnemyType spartanMiner;
		static inline ::EnemyType spartanMiner_dyn() { return spartanMiner; }
		static ::EnemyType starter;
		static inline ::EnemyType starter_dyn() { return starter; }
};


#endif /* INCLUDED_EnemyType */ 