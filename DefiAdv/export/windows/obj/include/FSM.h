// Generated by Haxe 4.2.1+bf9ff69
#ifndef INCLUDED_FSM
#define INCLUDED_FSM

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_STACK_FRAME(_hx_pos_5de81b3c4b5a507c_30_new)
HX_DECLARE_CLASS0(FSM)



class HXCPP_CLASS_ATTRIBUTES FSM_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef FSM_obj OBJ_;
		FSM_obj();

	public:
		enum { _hx_ClassId = 0x7ed9aaf4 };

		void __construct( ::Dynamic initialState);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="FSM")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"FSM"); }

		inline static ::hx::ObjectPtr< FSM_obj > __new( ::Dynamic initialState) {
			::hx::ObjectPtr< FSM_obj > __this = new FSM_obj();
			__this->__construct(initialState);
			return __this;
		}

		inline static ::hx::ObjectPtr< FSM_obj > __alloc(::hx::Ctx *_hx_ctx, ::Dynamic initialState) {
			FSM_obj *__this = (FSM_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FSM_obj), true, "FSM"));
			*(void **)__this = FSM_obj::_hx_vtable;
{
            	HX_STACKFRAME(&_hx_pos_5de81b3c4b5a507c_30_new)
HXDLIN(  30)		( ( ::FSM)(__this) )->activeState = initialState;
            	}
		
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~FSM_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("FSM",60,66,35,00); }

		 ::Dynamic activeState;
		Dynamic activeState_dyn() { return activeState;}
		void update(Float elapsed);
		::Dynamic update_dyn();

};


#endif /* INCLUDED_FSM */ 