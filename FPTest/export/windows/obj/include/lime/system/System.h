// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_lime_system_System
#define INCLUDED_lime_system_System

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(haxe,IMap)
HX_DECLARE_CLASS2(haxe,ds,IntMap)
HX_DECLARE_CLASS2(haxe,ds,StringMap)
HX_DECLARE_CLASS2(lime,_hx_system,Display)
HX_DECLARE_CLASS2(lime,_hx_system,Endian)
HX_DECLARE_CLASS2(lime,_hx_system,System)

namespace lime{
namespace _hx_system{


class HXCPP_CLASS_ATTRIBUTES System_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef System_obj OBJ_;
		System_obj();

	public:
		enum { _hx_ClassId = 0x0470bdb7 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="lime.system.System")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"lime.system.System"); }

		inline static ::hx::ObjectPtr< System_obj > __new() {
			::hx::ObjectPtr< System_obj > __this = new System_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< System_obj > __alloc(::hx::Ctx *_hx_ctx) {
			System_obj *__this = (System_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(System_obj), false, "lime.system.System"));
			*(void **)__this = System_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~System_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static bool __SetStatic(const ::String &inString, Dynamic &ioValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("System",0f,0b,77,27); }

		static void __boot();
		static bool disableCFFI;
		static ::String _hx___applicationDirectory;
		static  ::haxe::ds::StringMap _hx___applicationEntryPoint;
		static ::String _hx___applicationStorageDirectory;
		static ::String _hx___desktopDirectory;
		static ::String _hx___deviceModel;
		static ::String _hx___deviceVendor;
		static  ::haxe::ds::IntMap _hx___directories;
		static ::String _hx___documentsDirectory;
		static  ::lime::_hx_system::Endian _hx___endianness;
		static ::String _hx___fontsDirectory;
		static ::String _hx___platformLabel;
		static ::String _hx___platformName;
		static ::String _hx___platformVersion;
		static ::String _hx___userDirectory;
		static void exit(int code);
		static ::Dynamic exit_dyn();

		static  ::lime::_hx_system::Display getDisplay(int id);
		static ::Dynamic getDisplay_dyn();

		static int getTimer();
		static ::Dynamic getTimer_dyn();

		static  ::Dynamic load(::String library,::String method,::hx::Null< int >  args,::hx::Null< bool >  lazy);
		static ::Dynamic load_dyn();

		static void openFile(::String path);
		static ::Dynamic openFile_dyn();

		static void openURL(::String url,::String target);
		static ::Dynamic openURL_dyn();

		static void _hx___copyMissingFields( ::Dynamic target, ::Dynamic source);
		static ::Dynamic _hx___copyMissingFields_dyn();

		static ::String _hx___getDirectory(int type);
		static ::Dynamic _hx___getDirectory_dyn();

		static void _hx___parseArguments( ::Dynamic attributes);
		static ::Dynamic _hx___parseArguments_dyn();

		static bool _hx___parseBool(::String value);
		static ::Dynamic _hx___parseBool_dyn();

		static void _hx___registerEntryPoint(::String projectName, ::Dynamic entryPoint);
		static ::Dynamic _hx___registerEntryPoint_dyn();

		static ::String _hx___runProcess(::String command,::Array< ::String > args);
		static ::Dynamic _hx___runProcess_dyn();

		static bool get_allowScreenTimeout();
		static ::Dynamic get_allowScreenTimeout_dyn();

		static bool set_allowScreenTimeout(bool value);
		static ::Dynamic set_allowScreenTimeout_dyn();

		static ::String get_applicationDirectory();
		static ::Dynamic get_applicationDirectory_dyn();

		static ::String get_applicationStorageDirectory();
		static ::Dynamic get_applicationStorageDirectory_dyn();

		static ::String get_deviceModel();
		static ::Dynamic get_deviceModel_dyn();

		static ::String get_deviceVendor();
		static ::Dynamic get_deviceVendor_dyn();

		static ::String get_desktopDirectory();
		static ::Dynamic get_desktopDirectory_dyn();

		static ::String get_documentsDirectory();
		static ::Dynamic get_documentsDirectory_dyn();

		static  ::lime::_hx_system::Endian get_endianness();
		static ::Dynamic get_endianness_dyn();

		static ::String get_fontsDirectory();
		static ::Dynamic get_fontsDirectory_dyn();

		static int get_numDisplays();
		static ::Dynamic get_numDisplays_dyn();

		static ::String get_platformLabel();
		static ::Dynamic get_platformLabel_dyn();

		static ::String get_platformName();
		static ::Dynamic get_platformName_dyn();

		static ::String get_platformVersion();
		static ::Dynamic get_platformVersion_dyn();

		static ::String get_userDirectory();
		static ::Dynamic get_userDirectory_dyn();

};

} // end namespace lime
} // end namespace system

#endif /* INCLUDED_lime_system_System */ 
