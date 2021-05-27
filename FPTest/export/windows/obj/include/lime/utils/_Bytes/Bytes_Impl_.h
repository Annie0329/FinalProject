// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_lime_utils__Bytes_Bytes_Impl_
#define INCLUDED_lime_utils__Bytes_Bytes_Impl_

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(haxe,io,Bytes)
HX_DECLARE_CLASS2(lime,app,Future)
HX_DECLARE_CLASS2(lime,utils,CompressionAlgorithm)
HX_DECLARE_CLASS3(lime,utils,_Bytes,Bytes_Impl_)

namespace lime{
namespace utils{
namespace _Bytes{


class HXCPP_CLASS_ATTRIBUTES Bytes_Impl__obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef Bytes_Impl__obj OBJ_;
		Bytes_Impl__obj();

	public:
		enum { _hx_ClassId = 0x0007f847 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="lime.utils._Bytes.Bytes_Impl_")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"lime.utils._Bytes.Bytes_Impl_"); }

		inline static ::hx::ObjectPtr< Bytes_Impl__obj > __new() {
			::hx::ObjectPtr< Bytes_Impl__obj > __this = new Bytes_Impl__obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< Bytes_Impl__obj > __alloc(::hx::Ctx *_hx_ctx) {
			Bytes_Impl__obj *__this = (Bytes_Impl__obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(Bytes_Impl__obj), false, "lime.utils._Bytes.Bytes_Impl_"));
			*(void **)__this = Bytes_Impl__obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~Bytes_Impl__obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("Bytes_Impl_",2b,7f,82,3d); }

		static  ::haxe::io::Bytes _new(int length,::Array< unsigned char > bytesData);
		static ::Dynamic _new_dyn();

		static  ::haxe::io::Bytes alloc(int length);
		static ::Dynamic alloc_dyn();

		static  ::haxe::io::Bytes compress( ::haxe::io::Bytes this1, ::lime::utils::CompressionAlgorithm algorithm);
		static ::Dynamic compress_dyn();

		static  ::haxe::io::Bytes decompress( ::haxe::io::Bytes this1, ::lime::utils::CompressionAlgorithm algorithm);
		static ::Dynamic decompress_dyn();

		static int fastGet(::Array< unsigned char > b,int pos);
		static ::Dynamic fastGet_dyn();

		static  ::haxe::io::Bytes fromBytes( ::haxe::io::Bytes bytes);
		static ::Dynamic fromBytes_dyn();

		static  ::haxe::io::Bytes fromFile(::String path);
		static ::Dynamic fromFile_dyn();

		static  ::lime::app::Future loadFromBytes( ::haxe::io::Bytes bytes);
		static ::Dynamic loadFromBytes_dyn();

		static  ::lime::app::Future loadFromFile(::String path);
		static ::Dynamic loadFromFile_dyn();

		static  ::haxe::io::Bytes ofData(::Array< unsigned char > b);
		static ::Dynamic ofData_dyn();

		static  ::haxe::io::Bytes ofString(::String s);
		static ::Dynamic ofString_dyn();

		static  ::haxe::io::Bytes _hx___fromNativePointer( ::Dynamic data,int length);
		static ::Dynamic _hx___fromNativePointer_dyn();

};

} // end namespace lime
} // end namespace utils
} // end namespace _Bytes

#endif /* INCLUDED_lime_utils__Bytes_Bytes_Impl_ */ 
