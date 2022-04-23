// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_flixel_util_FlxPool_flixel_util_LabelValuePair
#include <flixel/util/FlxPool_flixel_util_LabelValuePair.h>
#endif
#ifndef INCLUDED_flixel_util_FlxStringUtil
#include <flixel/util/FlxStringUtil.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxPool
#include <flixel/util/IFlxPool.h>
#endif
#ifndef INCLUDED_flixel_util_LabelValuePair
#include <flixel/util/LabelValuePair.h>
#endif
#ifndef INCLUDED_flixel_util_helpers_FlxBounds
#include <flixel/util/helpers/FlxBounds.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_85edadf37d18a05f_8_new,"flixel.util.helpers.FlxBounds","new",0x7ac2a156,"flixel.util.helpers.FlxBounds.new","flixel/util/helpers/FlxBounds.hx",8,0x3d29a4bb)
HX_LOCAL_STACK_FRAME(_hx_pos_85edadf37d18a05f_45_set,"flixel.util.helpers.FlxBounds","set",0x7ac66c98,"flixel.util.helpers.FlxBounds.set","flixel/util/helpers/FlxBounds.hx",45,0x3d29a4bb)
HX_LOCAL_STACK_FRAME(_hx_pos_85edadf37d18a05f_59_equals,"flixel.util.helpers.FlxBounds","equals",0x1d409b09,"flixel.util.helpers.FlxBounds.equals","flixel/util/helpers/FlxBounds.hx",59,0x3d29a4bb)
HX_LOCAL_STACK_FRAME(_hx_pos_85edadf37d18a05f_67_toString,"flixel.util.helpers.FlxBounds","toString",0xc618c3f6,"flixel.util.helpers.FlxBounds.toString","flixel/util/helpers/FlxBounds.hx",67,0x3d29a4bb)
namespace flixel{
namespace util{
namespace helpers{

void FlxBounds_obj::__construct( ::Dynamic min, ::Dynamic max){
            	HX_STACKFRAME(&_hx_pos_85edadf37d18a05f_8_new)
HXLINE(  23)		this->active = true;
HXLINE(  33)		this->min = min;
HXLINE(  34)		 ::Dynamic _hx_tmp;
HXDLIN(  34)		if (::hx::IsNull( max )) {
HXLINE(  34)			_hx_tmp = min;
            		}
            		else {
HXLINE(  34)			_hx_tmp = max;
            		}
HXDLIN(  34)		this->max = _hx_tmp;
            	}

Dynamic FlxBounds_obj::__CreateEmpty() { return new FlxBounds_obj; }

void *FlxBounds_obj::_hx_vtable = 0;

Dynamic FlxBounds_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxBounds_obj > _hx_result = new FlxBounds_obj();
	_hx_result->__construct(inArgs[0],inArgs[1]);
	return _hx_result;
}

bool FlxBounds_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x71239120;
}

 ::flixel::util::helpers::FlxBounds FlxBounds_obj::set( ::Dynamic min, ::Dynamic max){
            	HX_STACKFRAME(&_hx_pos_85edadf37d18a05f_45_set)
HXLINE(  46)		this->min = min;
HXLINE(  47)		 ::Dynamic _hx_tmp;
HXDLIN(  47)		if (::hx::IsNull( max )) {
HXLINE(  47)			_hx_tmp = min;
            		}
            		else {
HXLINE(  47)			_hx_tmp = max;
            		}
HXDLIN(  47)		this->max = _hx_tmp;
HXLINE(  48)		return ::hx::ObjectPtr<OBJ_>(this);
            	}


HX_DEFINE_DYNAMIC_FUNC2(FlxBounds_obj,set,return )

bool FlxBounds_obj::equals( ::flixel::util::helpers::FlxBounds otherBounds){
            	HX_STACKFRAME(&_hx_pos_85edadf37d18a05f_59_equals)
HXDLIN(  59)		if (::hx::IsEq( this->min,otherBounds->min )) {
HXDLIN(  59)			return ::hx::IsEq( this->max,otherBounds->max );
            		}
            		else {
HXDLIN(  59)			return false;
            		}
HXDLIN(  59)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxBounds_obj,equals,return )

::String FlxBounds_obj::toString(){
            	HX_STACKFRAME(&_hx_pos_85edadf37d18a05f_67_toString)
HXDLIN(  67)		 ::Dynamic value = this->min;
HXDLIN(  67)		 ::flixel::util::LabelValuePair _this = ::flixel::util::LabelValuePair_obj::_pool->get();
HXDLIN(  67)		_this->label = HX_("min",92,11,53,00);
HXDLIN(  67)		_this->value = value;
HXDLIN(  67)		 ::Dynamic value1 = this->max;
HXDLIN(  67)		 ::flixel::util::LabelValuePair _this1 = ::flixel::util::LabelValuePair_obj::_pool->get();
HXDLIN(  67)		_this1->label = HX_("max",a4,0a,53,00);
HXDLIN(  67)		_this1->value = value1;
HXDLIN(  67)		return ::flixel::util::FlxStringUtil_obj::getDebugString(::Array_obj< ::Dynamic>::__new(2)->init(0,_this)->init(1,_this1));
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxBounds_obj,toString,return )


::hx::ObjectPtr< FlxBounds_obj > FlxBounds_obj::__new( ::Dynamic min, ::Dynamic max) {
	::hx::ObjectPtr< FlxBounds_obj > __this = new FlxBounds_obj();
	__this->__construct(min,max);
	return __this;
}

::hx::ObjectPtr< FlxBounds_obj > FlxBounds_obj::__alloc(::hx::Ctx *_hx_ctx, ::Dynamic min, ::Dynamic max) {
	FlxBounds_obj *__this = (FlxBounds_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FlxBounds_obj), true, "flixel.util.helpers.FlxBounds"));
	*(void **)__this = FlxBounds_obj::_hx_vtable;
	__this->__construct(min,max);
	return __this;
}

FlxBounds_obj::FlxBounds_obj()
{
}

void FlxBounds_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(FlxBounds);
	HX_MARK_MEMBER_NAME(min,"min");
	HX_MARK_MEMBER_NAME(max,"max");
	HX_MARK_MEMBER_NAME(active,"active");
	HX_MARK_END_CLASS();
}

void FlxBounds_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(min,"min");
	HX_VISIT_MEMBER_NAME(max,"max");
	HX_VISIT_MEMBER_NAME(active,"active");
}

::hx::Val FlxBounds_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"min") ) { return ::hx::Val( min ); }
		if (HX_FIELD_EQ(inName,"max") ) { return ::hx::Val( max ); }
		if (HX_FIELD_EQ(inName,"set") ) { return ::hx::Val( set_dyn() ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"active") ) { return ::hx::Val( active ); }
		if (HX_FIELD_EQ(inName,"equals") ) { return ::hx::Val( equals_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"toString") ) { return ::hx::Val( toString_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val FlxBounds_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"min") ) { min=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"max") ) { max=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"active") ) { active=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void FlxBounds_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("min",92,11,53,00));
	outFields->push(HX_("max",a4,0a,53,00));
	outFields->push(HX_("active",c6,41,46,16));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo FlxBounds_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(FlxBounds_obj,min),HX_("min",92,11,53,00)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(FlxBounds_obj,max),HX_("max",a4,0a,53,00)},
	{::hx::fsBool,(int)offsetof(FlxBounds_obj,active),HX_("active",c6,41,46,16)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *FlxBounds_obj_sStaticStorageInfo = 0;
#endif

static ::String FlxBounds_obj_sMemberFields[] = {
	HX_("min",92,11,53,00),
	HX_("max",a4,0a,53,00),
	HX_("active",c6,41,46,16),
	HX_("set",a2,9b,57,00),
	HX_("equals",3f,ee,f2,bf),
	HX_("toString",ac,d0,6e,38),
	::String(null()) };

::hx::Class FlxBounds_obj::__mClass;

void FlxBounds_obj::__register()
{
	FlxBounds_obj _hx_dummy;
	FlxBounds_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.util.helpers.FlxBounds",64,fe,1d,2e);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(FlxBounds_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< FlxBounds_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxBounds_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxBounds_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace util
} // end namespace helpers
