// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_haxe_IMap
#include <haxe/IMap.h>
#endif
#ifndef INCLUDED_haxe_ds_IntMap
#include <haxe/ds/IntMap.h>
#endif
#ifndef INCLUDED_lime_app__Event_Float_Float_Float_Void
#include <lime/app/_Event_Float_Float_Float_Void.h>
#endif
#ifndef INCLUDED_lime_system_Sensor
#include <lime/system/Sensor.h>
#endif
#ifndef INCLUDED_lime_system_SensorType
#include <lime/system/SensorType.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_f882df2140418079_9_new,"lime.system.Sensor","new",0xd4cfafd2,"lime.system.Sensor.new","lime/system/Sensor.hx",9,0x7b4cf9be)
HX_LOCAL_STACK_FRAME(_hx_pos_f882df2140418079_26_getSensors,"lime.system.Sensor","getSensors",0xecc219d1,"lime.system.Sensor.getSensors","lime/system/Sensor.hx",26,0x7b4cf9be)
HX_LOCAL_STACK_FRAME(_hx_pos_f882df2140418079_47_registerSensor,"lime.system.Sensor","registerSensor",0x90f30acb,"lime.system.Sensor.registerSensor","lime/system/Sensor.hx",47,0x7b4cf9be)
HX_LOCAL_STACK_FRAME(_hx_pos_f882df2140418079_11_boot,"lime.system.Sensor","boot",0x59032880,"lime.system.Sensor.boot","lime/system/Sensor.hx",11,0x7b4cf9be)
HX_LOCAL_STACK_FRAME(_hx_pos_f882df2140418079_12_boot,"lime.system.Sensor","boot",0x59032880,"lime.system.Sensor.boot","lime/system/Sensor.hx",12,0x7b4cf9be)
namespace lime{
namespace _hx_system{

void Sensor_obj::__construct( ::lime::_hx_system::SensorType type,int id){
            	HX_GC_STACKFRAME(&_hx_pos_f882df2140418079_9_new)
HXLINE(  15)		this->onUpdate =  ::lime::app::_Event_Float_Float_Float_Void_obj::__alloc( HX_CTX );
HXLINE(  20)		this->type = type;
HXLINE(  21)		this->id = id;
            	}

Dynamic Sensor_obj::__CreateEmpty() { return new Sensor_obj; }

void *Sensor_obj::_hx_vtable = 0;

Dynamic Sensor_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Sensor_obj > _hx_result = new Sensor_obj();
	_hx_result->__construct(inArgs[0],inArgs[1]);
	return _hx_result;
}

bool Sensor_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x6947ed9e;
}

 ::haxe::ds::IntMap Sensor_obj::sensorByID;

::Array< ::Dynamic> Sensor_obj::sensors;

::Array< ::Dynamic> Sensor_obj::getSensors( ::lime::_hx_system::SensorType type){
            	HX_STACKFRAME(&_hx_pos_f882df2140418079_26_getSensors)
HXDLIN(  26)		if (::hx::IsNull( type )) {
HXLINE(  28)			return ::lime::_hx_system::Sensor_obj::sensors->copy();
            		}
            		else {
HXLINE(  32)			::Array< ::Dynamic> result = ::Array_obj< ::Dynamic>::__new(0);
HXLINE(  34)			{
HXLINE(  34)				int _g = 0;
HXDLIN(  34)				::Array< ::Dynamic> _g1 = ::lime::_hx_system::Sensor_obj::sensors;
HXDLIN(  34)				while((_g < _g1->length)){
HXLINE(  34)					 ::lime::_hx_system::Sensor sensor = _g1->__get(_g).StaticCast<  ::lime::_hx_system::Sensor >();
HXDLIN(  34)					_g = (_g + 1);
HXLINE(  36)					if (::hx::IsPointerEq( sensor->type,type )) {
HXLINE(  38)						result->push(sensor);
            					}
            				}
            			}
HXLINE(  42)			return result;
            		}
HXLINE(  26)		return null();
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Sensor_obj,getSensors,return )

 ::lime::_hx_system::Sensor Sensor_obj::registerSensor( ::lime::_hx_system::SensorType type,int id){
            	HX_GC_STACKFRAME(&_hx_pos_f882df2140418079_47_registerSensor)
HXLINE(  48)		 ::lime::_hx_system::Sensor sensor =  ::lime::_hx_system::Sensor_obj::__alloc( HX_CTX ,type,id);
HXLINE(  50)		::lime::_hx_system::Sensor_obj::sensors->push(sensor);
HXLINE(  51)		::lime::_hx_system::Sensor_obj::sensorByID->set(id,sensor);
HXLINE(  53)		return sensor;
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(Sensor_obj,registerSensor,return )


::hx::ObjectPtr< Sensor_obj > Sensor_obj::__new( ::lime::_hx_system::SensorType type,int id) {
	::hx::ObjectPtr< Sensor_obj > __this = new Sensor_obj();
	__this->__construct(type,id);
	return __this;
}

::hx::ObjectPtr< Sensor_obj > Sensor_obj::__alloc(::hx::Ctx *_hx_ctx, ::lime::_hx_system::SensorType type,int id) {
	Sensor_obj *__this = (Sensor_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(Sensor_obj), true, "lime.system.Sensor"));
	*(void **)__this = Sensor_obj::_hx_vtable;
	__this->__construct(type,id);
	return __this;
}

Sensor_obj::Sensor_obj()
{
}

void Sensor_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Sensor);
	HX_MARK_MEMBER_NAME(id,"id");
	HX_MARK_MEMBER_NAME(onUpdate,"onUpdate");
	HX_MARK_MEMBER_NAME(type,"type");
	HX_MARK_END_CLASS();
}

void Sensor_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(id,"id");
	HX_VISIT_MEMBER_NAME(onUpdate,"onUpdate");
	HX_VISIT_MEMBER_NAME(type,"type");
}

::hx::Val Sensor_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"id") ) { return ::hx::Val( id ); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"type") ) { return ::hx::Val( type ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"onUpdate") ) { return ::hx::Val( onUpdate ); }
	}
	return super::__Field(inName,inCallProp);
}

bool Sensor_obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"sensors") ) { outValue = ( sensors ); return true; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"sensorByID") ) { outValue = ( sensorByID ); return true; }
		if (HX_FIELD_EQ(inName,"getSensors") ) { outValue = getSensors_dyn(); return true; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"registerSensor") ) { outValue = registerSensor_dyn(); return true; }
	}
	return false;
}

::hx::Val Sensor_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"id") ) { id=inValue.Cast< int >(); return inValue; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"type") ) { type=inValue.Cast<  ::lime::_hx_system::SensorType >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"onUpdate") ) { onUpdate=inValue.Cast<  ::lime::app::_Event_Float_Float_Float_Void >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

bool Sensor_obj::__SetStatic(const ::String &inName,Dynamic &ioValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"sensors") ) { sensors=ioValue.Cast< ::Array< ::Dynamic> >(); return true; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"sensorByID") ) { sensorByID=ioValue.Cast<  ::haxe::ds::IntMap >(); return true; }
	}
	return false;
}

void Sensor_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("id",db,5b,00,00));
	outFields->push(HX_("onUpdate",88,7c,b2,66));
	outFields->push(HX_("type",ba,f2,08,4d));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo Sensor_obj_sMemberStorageInfo[] = {
	{::hx::fsInt,(int)offsetof(Sensor_obj,id),HX_("id",db,5b,00,00)},
	{::hx::fsObject /*  ::lime::app::_Event_Float_Float_Float_Void */ ,(int)offsetof(Sensor_obj,onUpdate),HX_("onUpdate",88,7c,b2,66)},
	{::hx::fsObject /*  ::lime::_hx_system::SensorType */ ,(int)offsetof(Sensor_obj,type),HX_("type",ba,f2,08,4d)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo Sensor_obj_sStaticStorageInfo[] = {
	{::hx::fsObject /*  ::haxe::ds::IntMap */ ,(void *) &Sensor_obj::sensorByID,HX_("sensorByID",cc,fc,ca,0d)},
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(void *) &Sensor_obj::sensors,HX_("sensors",f9,c0,9b,b2)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static ::String Sensor_obj_sMemberFields[] = {
	HX_("id",db,5b,00,00),
	HX_("onUpdate",88,7c,b2,66),
	HX_("type",ba,f2,08,4d),
	::String(null()) };

static void Sensor_obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Sensor_obj::sensorByID,"sensorByID");
	HX_MARK_MEMBER_NAME(Sensor_obj::sensors,"sensors");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Sensor_obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Sensor_obj::sensorByID,"sensorByID");
	HX_VISIT_MEMBER_NAME(Sensor_obj::sensors,"sensors");
};

#endif

::hx::Class Sensor_obj::__mClass;

static ::String Sensor_obj_sStaticFields[] = {
	HX_("sensorByID",cc,fc,ca,0d),
	HX_("sensors",f9,c0,9b,b2),
	HX_("getSensors",03,47,fd,01),
	HX_("registerSensor",fd,b8,d1,31),
	::String(null())
};

void Sensor_obj::__register()
{
	Sensor_obj _hx_dummy;
	Sensor_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("lime.system.Sensor",e0,1e,6b,25);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Sensor_obj::__GetStatic;
	__mClass->mSetStaticField = &Sensor_obj::__SetStatic;
	__mClass->mMarkFunc = Sensor_obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Sensor_obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(Sensor_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< Sensor_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Sensor_obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Sensor_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Sensor_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

void Sensor_obj::__boot()
{
{
            	HX_GC_STACKFRAME(&_hx_pos_f882df2140418079_11_boot)
HXDLIN(  11)		sensorByID =  ::haxe::ds::IntMap_obj::__alloc( HX_CTX );
            	}
{
            	HX_STACKFRAME(&_hx_pos_f882df2140418079_12_boot)
HXDLIN(  12)		sensors = ::Array_obj< ::Dynamic>::__new();
            	}
}

} // end namespace lime
} // end namespace system
