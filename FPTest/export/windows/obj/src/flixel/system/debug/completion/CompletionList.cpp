// Generated by Haxe 4.2.1+bf9ff69
#include <hxcpp.h>

#ifndef INCLUDED_EReg
#include <EReg.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_StringTools
#include <StringTools.h>
#endif
#ifndef INCLUDED_flixel_system_debug_completion_CompletionList
#include <flixel/system/debug/completion/CompletionList.h>
#endif
#ifndef INCLUDED_flixel_system_debug_completion_CompletionListEntry
#include <flixel/system/debug/completion/CompletionListEntry.h>
#endif
#ifndef INCLUDED_flixel_system_debug_completion_CompletionListScrollBar
#include <flixel/system/debug/completion/CompletionListScrollBar.h>
#endif
#ifndef INCLUDED_lime_app_IModule
#include <lime/app/IModule.h>
#endif
#ifndef INCLUDED_openfl_Lib
#include <openfl/Lib.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_MovieClip
#include <openfl/display/MovieClip.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_display_Stage
#include <openfl/display/Stage.h>
#endif
#ifndef INCLUDED_openfl_events_Event
#include <openfl/events/Event.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_KeyboardEvent
#include <openfl/events/KeyboardEvent.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_26f69c8799845277_11_new,"flixel.system.debug.completion.CompletionList","new",0x2d62f836,"flixel.system.debug.completion.CompletionList.new","flixel/system/debug/completion/CompletionList.hx",11,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_45_show,"flixel.system.debug.completion.CompletionList","show",0x8c868867,"flixel.system.debug.completion.CompletionList.show","flixel/system/debug/completion/CompletionList.hx",45,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_56_setY,"flixel.system.debug.completion.CompletionList","setY",0x8c8445e1,"flixel.system.debug.completion.CompletionList.setY","flixel/system/debug/completion/CompletionList.hx",56,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_60_close,"flixel.system.debug.completion.CompletionList","close",0x356c610e,"flixel.system.debug.completion.CompletionList.close","flixel/system/debug/completion/CompletionList.hx",60,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_70_createPopupEntries,"flixel.system.debug.completion.CompletionList","createPopupEntries",0x28517e8a,"flixel.system.debug.completion.CompletionList.createPopupEntries","flixel/system/debug/completion/CompletionList.hx",70,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_80_createScrollBar,"flixel.system.debug.completion.CompletionList","createScrollBar",0x8887a200,"flixel.system.debug.completion.CompletionList.createScrollBar","flixel/system/debug/completion/CompletionList.hx",80,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_86_onKeyDown,"flixel.system.debug.completion.CompletionList","onKeyDown",0xde49ce98,"flixel.system.debug.completion.CompletionList.onKeyDown","flixel/system/debug/completion/CompletionList.hx",86,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_113_updateIndices,"flixel.system.debug.completion.CompletionList","updateIndices",0x00d63b74,"flixel.system.debug.completion.CompletionList.updateIndices","flixel/system/debug/completion/CompletionList.hx",113,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_135_bound,"flixel.system.debug.completion.CompletionList","bound",0xa405f994,"flixel.system.debug.completion.CompletionList.bound","flixel/system/debug/completion/CompletionList.hx",135,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_139_updateEntries,"flixel.system.debug.completion.CompletionList","updateEntries",0x96e1219d,"flixel.system.debug.completion.CompletionList.updateEntries","flixel/system/debug/completion/CompletionList.hx",139,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_147_updateLabels,"flixel.system.debug.completion.CompletionList","updateLabels",0x98d4fc52,"flixel.system.debug.completion.CompletionList.updateLabels","flixel/system/debug/completion/CompletionList.hx",147,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_157_updateSelectedItem,"flixel.system.debug.completion.CompletionList","updateSelectedItem",0x02be39a1,"flixel.system.debug.completion.CompletionList.updateSelectedItem","flixel/system/debug/completion/CompletionList.hx",157,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_167_setItems,"flixel.system.debug.completion.CompletionList","setItems",0x6843c568,"flixel.system.debug.completion.CompletionList.setItems","flixel/system/debug/completion/CompletionList.hx",167,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_182_filterItems,"flixel.system.debug.completion.CompletionList","filterItems",0xe29aeefe,"flixel.system.debug.completion.CompletionList.filterItems","flixel/system/debug/completion/CompletionList.hx",182,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_203_sortItems,"flixel.system.debug.completion.CompletionList","sortItems",0x34d82c18,"flixel.system.debug.completion.CompletionList.sortItems","flixel/system/debug/completion/CompletionList.hx",203,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_198_sortItems,"flixel.system.debug.completion.CompletionList","sortItems",0x34d82c18,"flixel.system.debug.completion.CompletionList.sortItems","flixel/system/debug/completion/CompletionList.hx",198,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_222_startsWithExt,"flixel.system.debug.completion.CompletionList","startsWithExt",0x5b78f7c0,"flixel.system.debug.completion.CompletionList.startsWithExt","flixel/system/debug/completion/CompletionList.hx",222,0x5d64787a)
HX_LOCAL_STACK_FRAME(_hx_pos_26f69c8799845277_231_set_filter,"flixel.system.debug.completion.CompletionList","set_filter",0x1b994cdf,"flixel.system.debug.completion.CompletionList.set_filter","flixel/system/debug/completion/CompletionList.hx",231,0x5d64787a)
namespace flixel{
namespace _hx_system{
namespace debug{
namespace completion{

void CompletionList_obj::__construct(int capacity){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_11_new)
HXLINE(  25)		this->upperVisibleIndex = 0;
HXLINE(  24)		this->lowerVisibleIndex = 0;
HXLINE(  23)		this->selectedIndex = 0;
HXLINE(  21)		this->entries = ::Array_obj< ::Dynamic>::__new(0);
HXLINE(  31)		super::__construct();
HXLINE(  33)		this->set_visible(false);
HXLINE(  34)		this->upperVisibleIndex = (capacity - 1);
HXLINE(  35)		this->actualHeight = (capacity * 20);
HXLINE(  37)		this->createPopupEntries(capacity);
HXLINE(  38)		this->createScrollBar();
HXLINE(  39)		this->updateSelectedItem();
HXLINE(  41)		::openfl::Lib_obj::get_current()->stage->addEventListener(HX_("keyDown",a1,69,47,9c),this->onKeyDown_dyn(),null(),null(),null());
            	}

Dynamic CompletionList_obj::__CreateEmpty() { return new CompletionList_obj; }

void *CompletionList_obj::_hx_vtable = 0;

Dynamic CompletionList_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< CompletionList_obj > _hx_result = new CompletionList_obj();
	_hx_result->__construct(inArgs[0]);
	return _hx_result;
}

bool CompletionList_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x1f4df417) {
		if (inClassId<=(int)0x0c89e854) {
			if (inClassId<=(int)0x0330636f) {
				return inClassId==(int)0x00000001 || inClassId==(int)0x0330636f;
			} else {
				return inClassId==(int)0x0c89e854;
			}
		} else {
			return inClassId==(int)0x1f4df417;
		}
	} else {
		if (inClassId<=(int)0x6b353933) {
			return inClassId==(int)0x4af7dd8e || inClassId==(int)0x6b353933;
		} else {
			return inClassId==(int)0x6d9b049a;
		}
	}
}

void CompletionList_obj::show(Float x,::Array< ::String > items){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_45_show)
HXLINE(  46)		this->set_visible(true);
HXLINE(  47)		this->set_x(x);
HXLINE(  48)		this->originalItems = items;
HXLINE(  49)		this->set_filter(HX_("",00,00,00,00));
HXLINE(  51)		this->updateEntries();
            	}


HX_DEFINE_DYNAMIC_FUNC2(CompletionList_obj,show,(void))

void CompletionList_obj::setY(Float y){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_56_setY)
HXDLIN(  56)		this->set_y((y - ( (Float)(this->actualHeight) )));
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,setY,(void))

void CompletionList_obj::close(){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_60_close)
HXLINE(  61)		this->set_visible(false);
HXLINE(  62)		this->set_filter(null());
HXLINE(  64)		if (::hx::IsNotNull( this->closed )) {
HXLINE(  65)			this->closed();
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CompletionList_obj,close,(void))

void CompletionList_obj::createPopupEntries(int amount){
            	HX_GC_STACKFRAME(&_hx_pos_26f69c8799845277_70_createPopupEntries)
HXDLIN(  70)		int _g = 0;
HXDLIN(  70)		int _g1 = amount;
HXDLIN(  70)		while((_g < _g1)){
HXDLIN(  70)			_g = (_g + 1);
HXDLIN(  70)			int i = (_g - 1);
HXLINE(  72)			 ::flixel::_hx_system::debug::completion::CompletionListEntry entry =  ::flixel::_hx_system::debug::completion::CompletionListEntry_obj::__alloc( HX_CTX );
HXLINE(  73)			this->entries->push(entry);
HXLINE(  74)			this->addChild(entry);
HXLINE(  75)			entry->set_y(( (Float)((20 * i)) ));
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,createPopupEntries,(void))

void CompletionList_obj::createScrollBar(){
            	HX_GC_STACKFRAME(&_hx_pos_26f69c8799845277_80_createScrollBar)
HXLINE(  81)		this->scrollBar =  ::flixel::_hx_system::debug::completion::CompletionListScrollBar_obj::__alloc( HX_CTX ,150,0,5,this->actualHeight);
HXLINE(  82)		this->addChild(this->scrollBar);
            	}


HX_DEFINE_DYNAMIC_FUNC0(CompletionList_obj,createScrollBar,(void))

void CompletionList_obj::onKeyDown( ::openfl::events::KeyboardEvent e){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_86_onKeyDown)
HXLINE(  87)		if (!(this->get_visible())) {
HXLINE(  88)			return;
            		}
HXLINE(  90)		switch((int)(e->keyCode)){
            			case (int)13: {
HXLINE(  99)				if (::hx::IsNotNull( this->completed )) {
HXLINE( 100)					this->completed(this->items->__get(this->selectedIndex));
            				}
HXLINE( 101)				this->close();
HXLINE( 102)				return;
            			}
            			break;
            			case (int)27: {
HXLINE( 105)				this->close();
HXLINE( 106)				return;
            			}
            			break;
            			case (int)38: {
HXLINE(  96)				this->updateIndices(-1);
            			}
            			break;
            			case (int)40: {
HXLINE(  93)				this->updateIndices(1);
            			}
            			break;
            		}
HXLINE( 109)		this->updateEntries();
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,onKeyDown,(void))

void CompletionList_obj::updateIndices(int modifier){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_113_updateIndices)
HXLINE( 114)		this->selectedIndex = this->bound((this->selectedIndex + modifier));
HXLINE( 115)		Float Value = ( (Float)(this->selectedIndex) );
HXDLIN( 115)		 ::Dynamic Min = this->lowerVisibleIndex;
HXDLIN( 115)		 ::Dynamic Max = this->upperVisibleIndex;
HXDLIN( 115)		bool _hx_tmp;
HXDLIN( 115)		bool _hx_tmp1;
HXDLIN( 115)		if (::hx::IsNotNull( Min )) {
HXLINE( 115)			_hx_tmp1 = ::hx::IsGreaterEq( Value,Min );
            		}
            		else {
HXLINE( 115)			_hx_tmp1 = true;
            		}
HXDLIN( 115)		if (_hx_tmp1) {
HXLINE( 115)			if (::hx::IsNotNull( Max )) {
HXLINE( 115)				_hx_tmp = ::hx::IsLessEq( Value,Max );
            			}
            			else {
HXLINE( 115)				_hx_tmp = true;
            			}
            		}
            		else {
HXLINE( 115)			_hx_tmp = false;
            		}
HXDLIN( 115)		if (_hx_tmp) {
HXLINE( 116)			return;
            		}
HXLINE( 119)		this->lowerVisibleIndex = this->bound((this->lowerVisibleIndex + modifier));
HXLINE( 120)		this->upperVisibleIndex = this->bound((this->upperVisibleIndex + modifier));
HXLINE( 121)		int range = (this->upperVisibleIndex - this->lowerVisibleIndex);
HXLINE( 123)		if ((range == this->items->length)) {
HXLINE( 124)			return;
            		}
HXLINE( 127)		if ((this->lowerVisibleIndex == 0)) {
HXLINE( 128)			this->upperVisibleIndex = (this->entries->length - 1);
            		}
            		else {
HXLINE( 129)			if ((this->upperVisibleIndex == (this->items->length - 1))) {
HXLINE( 130)				this->lowerVisibleIndex = (this->items->length - this->entries->length);
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,updateIndices,(void))

int CompletionList_obj::bound(int index){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_135_bound)
HXDLIN( 135)		 ::Dynamic Max = (this->items->length - 1);
HXDLIN( 135)		Float lowerBound;
HXDLIN( 135)		if ((index < 0)) {
HXDLIN( 135)			lowerBound = ( (Float)(0) );
            		}
            		else {
HXDLIN( 135)			lowerBound = ( (Float)(index) );
            		}
HXDLIN( 135)		Float _hx_tmp;
HXDLIN( 135)		bool _hx_tmp1;
HXDLIN( 135)		if (::hx::IsNotNull( Max )) {
HXDLIN( 135)			_hx_tmp1 = ::hx::IsGreater( lowerBound,Max );
            		}
            		else {
HXDLIN( 135)			_hx_tmp1 = false;
            		}
HXDLIN( 135)		if (_hx_tmp1) {
HXDLIN( 135)			_hx_tmp = ( (Float)(Max) );
            		}
            		else {
HXDLIN( 135)			_hx_tmp = lowerBound;
            		}
HXDLIN( 135)		return ::Std_obj::_hx_int(_hx_tmp);
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,bound,return )

void CompletionList_obj::updateEntries(){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_139_updateEntries)
HXLINE( 140)		this->updateLabels();
HXLINE( 141)		this->updateSelectedItem();
HXLINE( 142)		this->scrollBar->updateHandle(this->lowerVisibleIndex,this->items->length,this->entries->length);
            	}


HX_DEFINE_DYNAMIC_FUNC0(CompletionList_obj,updateEntries,(void))

void CompletionList_obj::updateLabels(){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_147_updateLabels)
HXDLIN( 147)		int _g = 0;
HXDLIN( 147)		int _g1 = this->entries->length;
HXDLIN( 147)		while((_g < _g1)){
HXDLIN( 147)			_g = (_g + 1);
HXDLIN( 147)			int i = (_g - 1);
HXLINE( 149)			::String selectedItem = this->items->__get((this->lowerVisibleIndex + i));
HXLINE( 150)			if (::hx::IsNull( selectedItem )) {
HXLINE( 151)				selectedItem = HX_("",00,00,00,00);
            			}
HXLINE( 152)			this->entries->__get(i).StaticCast<  ::flixel::_hx_system::debug::completion::CompletionListEntry >()->setItem(selectedItem);
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CompletionList_obj,updateLabels,(void))

void CompletionList_obj::updateSelectedItem(){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_157_updateSelectedItem)
HXLINE( 158)		{
HXLINE( 158)			int _g = 0;
HXDLIN( 158)			::Array< ::Dynamic> _g1 = this->entries;
HXDLIN( 158)			while((_g < _g1->length)){
HXLINE( 158)				 ::flixel::_hx_system::debug::completion::CompletionListEntry entry = _g1->__get(_g).StaticCast<  ::flixel::_hx_system::debug::completion::CompletionListEntry >();
HXDLIN( 158)				_g = (_g + 1);
HXLINE( 159)				entry->set_selected(false);
            			}
            		}
HXLINE( 160)		this->entries->__get((this->selectedIndex - this->lowerVisibleIndex)).StaticCast<  ::flixel::_hx_system::debug::completion::CompletionListEntry >()->set_selected(true);
HXLINE( 162)		if (::hx::IsNotNull( this->selectionChanged )) {
HXLINE( 163)			this->selectionChanged(this->items->__get(this->selectedIndex));
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CompletionList_obj,updateSelectedItem,(void))

void CompletionList_obj::setItems(::Array< ::String > items){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_167_setItems)
HXLINE( 168)		if (::hx::IsNull( items )) {
HXLINE( 169)			return;
            		}
HXLINE( 170)		if ((items->length == 0)) {
HXLINE( 171)			this->close();
            		}
HXLINE( 173)		this->items = items;
HXLINE( 175)		this->selectedIndex = 0;
HXLINE( 176)		this->lowerVisibleIndex = 0;
HXLINE( 177)		this->upperVisibleIndex = (this->entries->length - 1);
HXLINE( 178)		this->updateEntries();
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,setItems,(void))

::Array< ::String > CompletionList_obj::filterItems(::String filter){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_182_filterItems)
HXLINE( 183)		if (::hx::IsNull( filter )) {
HXLINE( 184)			filter = HX_("",00,00,00,00);
            		}
HXLINE( 186)		::Array< ::String > _g = ::Array_obj< ::String >::__new(0);
HXDLIN( 186)		{
HXLINE( 186)			int _g1 = 0;
HXDLIN( 186)			::Array< ::String > _g2 = this->originalItems;
HXDLIN( 186)			while((_g1 < _g2->length)){
HXLINE( 186)				::String v = _g2->__get(_g1);
HXDLIN( 186)				_g1 = (_g1 + 1);
HXLINE( 188)				::String s = v.toLowerCase();
HXLINE( 186)				if ((s.indexOf(filter.toLowerCase(),null()) != -1)) {
HXLINE( 186)					_g->push(v);
            				}
            			}
            		}
HXDLIN( 186)		return this->sortItems(filter,_g);
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,filterItems,return )

::Array< ::String > CompletionList_obj::sortItems(::String filter,::Array< ::String > items){
            		HX_BEGIN_LOCAL_FUNC_S2(::hx::LocalFunc,_hx_Closure_0, ::flixel::_hx_system::debug::completion::CompletionList,_gthis,::String,filter) HXARGC(2)
            		int _hx_run(::String a,::String b){
            			HX_STACKFRAME(&_hx_pos_26f69c8799845277_203_sortItems)
HXLINE( 204)			int valueA = _gthis->startsWithExt(a,filter);
HXLINE( 205)			int valueB = _gthis->startsWithExt(b,filter);
HXLINE( 206)			if ((valueA > valueB)) {
HXLINE( 207)				return -(valueA);
            			}
HXLINE( 208)			if ((valueB > valueA)) {
HXLINE( 209)				return valueB;
            			}
HXLINE( 211)			if ((valueA == valueB)) {
HXLINE( 212)				return ::Std_obj::_hx_int(( (Float)((a.length - b.length)) ));
            			}
HXLINE( 213)			return 0;
            		}
            		HX_END_LOCAL_FUNC2(return)

            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_198_sortItems)
HXDLIN( 198)		 ::flixel::_hx_system::debug::completion::CompletionList _gthis = ::hx::ObjectPtr<OBJ_>(this);
HXLINE( 199)		if ((filter == HX_("",00,00,00,00))) {
HXLINE( 200)			return items;
            		}
HXLINE( 202)		items->sort( ::Dynamic(new _hx_Closure_0(_gthis,filter)));
HXLINE( 215)		return items;
            	}


HX_DEFINE_DYNAMIC_FUNC2(CompletionList_obj,sortItems,return )

int CompletionList_obj::startsWithExt(::String s,::String start){
            	HX_GC_STACKFRAME(&_hx_pos_26f69c8799845277_222_startsWithExt)
HXLINE( 223)		if (::StringTools_obj::startsWith(s,start)) {
HXLINE( 224)			return 2;
            		}
HXLINE( 225)		if (::StringTools_obj::startsWith( ::EReg_obj::__alloc( HX_CTX ,HX_("^[_]+",30,59,19,5c),HX_("",00,00,00,00))->replace(s,HX_("",00,00,00,00)),start)) {
HXLINE( 226)			return 1;
            		}
HXLINE( 227)		return 0;
            	}


HX_DEFINE_DYNAMIC_FUNC2(CompletionList_obj,startsWithExt,return )

::String CompletionList_obj::set_filter(::String filter){
            	HX_STACKFRAME(&_hx_pos_26f69c8799845277_231_set_filter)
HXLINE( 232)		if ((filter == this->filter)) {
HXLINE( 233)			return filter;
            		}
HXLINE( 235)		this->setItems(this->filterItems(filter));
HXLINE( 236)		return (this->filter = filter);
            	}


HX_DEFINE_DYNAMIC_FUNC1(CompletionList_obj,set_filter,return )


::hx::ObjectPtr< CompletionList_obj > CompletionList_obj::__new(int capacity) {
	::hx::ObjectPtr< CompletionList_obj > __this = new CompletionList_obj();
	__this->__construct(capacity);
	return __this;
}

::hx::ObjectPtr< CompletionList_obj > CompletionList_obj::__alloc(::hx::Ctx *_hx_ctx,int capacity) {
	CompletionList_obj *__this = (CompletionList_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(CompletionList_obj), true, "flixel.system.debug.completion.CompletionList"));
	*(void **)__this = CompletionList_obj::_hx_vtable;
	__this->__construct(capacity);
	return __this;
}

CompletionList_obj::CompletionList_obj()
{
}

void CompletionList_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(CompletionList);
	HX_MARK_MEMBER_NAME(completed,"completed");
	HX_MARK_MEMBER_NAME(selectionChanged,"selectionChanged");
	HX_MARK_MEMBER_NAME(closed,"closed");
	HX_MARK_MEMBER_NAME(filter,"filter");
	HX_MARK_MEMBER_NAME(items,"items");
	HX_MARK_MEMBER_NAME(entries,"entries");
	HX_MARK_MEMBER_NAME(originalItems,"originalItems");
	HX_MARK_MEMBER_NAME(selectedIndex,"selectedIndex");
	HX_MARK_MEMBER_NAME(lowerVisibleIndex,"lowerVisibleIndex");
	HX_MARK_MEMBER_NAME(upperVisibleIndex,"upperVisibleIndex");
	HX_MARK_MEMBER_NAME(scrollBar,"scrollBar");
	HX_MARK_MEMBER_NAME(actualHeight,"actualHeight");
	 ::openfl::display::Sprite_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void CompletionList_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(completed,"completed");
	HX_VISIT_MEMBER_NAME(selectionChanged,"selectionChanged");
	HX_VISIT_MEMBER_NAME(closed,"closed");
	HX_VISIT_MEMBER_NAME(filter,"filter");
	HX_VISIT_MEMBER_NAME(items,"items");
	HX_VISIT_MEMBER_NAME(entries,"entries");
	HX_VISIT_MEMBER_NAME(originalItems,"originalItems");
	HX_VISIT_MEMBER_NAME(selectedIndex,"selectedIndex");
	HX_VISIT_MEMBER_NAME(lowerVisibleIndex,"lowerVisibleIndex");
	HX_VISIT_MEMBER_NAME(upperVisibleIndex,"upperVisibleIndex");
	HX_VISIT_MEMBER_NAME(scrollBar,"scrollBar");
	HX_VISIT_MEMBER_NAME(actualHeight,"actualHeight");
	 ::openfl::display::Sprite_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val CompletionList_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"show") ) { return ::hx::Val( show_dyn() ); }
		if (HX_FIELD_EQ(inName,"setY") ) { return ::hx::Val( setY_dyn() ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"items") ) { return ::hx::Val( items ); }
		if (HX_FIELD_EQ(inName,"close") ) { return ::hx::Val( close_dyn() ); }
		if (HX_FIELD_EQ(inName,"bound") ) { return ::hx::Val( bound_dyn() ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"closed") ) { return ::hx::Val( closed ); }
		if (HX_FIELD_EQ(inName,"filter") ) { return ::hx::Val( filter ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"entries") ) { return ::hx::Val( entries ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"setItems") ) { return ::hx::Val( setItems_dyn() ); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"completed") ) { return ::hx::Val( completed ); }
		if (HX_FIELD_EQ(inName,"scrollBar") ) { return ::hx::Val( scrollBar ); }
		if (HX_FIELD_EQ(inName,"onKeyDown") ) { return ::hx::Val( onKeyDown_dyn() ); }
		if (HX_FIELD_EQ(inName,"sortItems") ) { return ::hx::Val( sortItems_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"set_filter") ) { return ::hx::Val( set_filter_dyn() ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"filterItems") ) { return ::hx::Val( filterItems_dyn() ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"actualHeight") ) { return ::hx::Val( actualHeight ); }
		if (HX_FIELD_EQ(inName,"updateLabels") ) { return ::hx::Val( updateLabels_dyn() ); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"originalItems") ) { return ::hx::Val( originalItems ); }
		if (HX_FIELD_EQ(inName,"selectedIndex") ) { return ::hx::Val( selectedIndex ); }
		if (HX_FIELD_EQ(inName,"updateIndices") ) { return ::hx::Val( updateIndices_dyn() ); }
		if (HX_FIELD_EQ(inName,"updateEntries") ) { return ::hx::Val( updateEntries_dyn() ); }
		if (HX_FIELD_EQ(inName,"startsWithExt") ) { return ::hx::Val( startsWithExt_dyn() ); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"createScrollBar") ) { return ::hx::Val( createScrollBar_dyn() ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"selectionChanged") ) { return ::hx::Val( selectionChanged ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"lowerVisibleIndex") ) { return ::hx::Val( lowerVisibleIndex ); }
		if (HX_FIELD_EQ(inName,"upperVisibleIndex") ) { return ::hx::Val( upperVisibleIndex ); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"createPopupEntries") ) { return ::hx::Val( createPopupEntries_dyn() ); }
		if (HX_FIELD_EQ(inName,"updateSelectedItem") ) { return ::hx::Val( updateSelectedItem_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val CompletionList_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"items") ) { items=inValue.Cast< ::Array< ::String > >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"closed") ) { closed=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"filter") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_filter(inValue.Cast< ::String >()) );filter=inValue.Cast< ::String >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"entries") ) { entries=inValue.Cast< ::Array< ::Dynamic> >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"completed") ) { completed=inValue.Cast<  ::Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"scrollBar") ) { scrollBar=inValue.Cast<  ::flixel::_hx_system::debug::completion::CompletionListScrollBar >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"actualHeight") ) { actualHeight=inValue.Cast< int >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"originalItems") ) { originalItems=inValue.Cast< ::Array< ::String > >(); return inValue; }
		if (HX_FIELD_EQ(inName,"selectedIndex") ) { selectedIndex=inValue.Cast< int >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"selectionChanged") ) { selectionChanged=inValue.Cast<  ::Dynamic >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"lowerVisibleIndex") ) { lowerVisibleIndex=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"upperVisibleIndex") ) { upperVisibleIndex=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void CompletionList_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("filter",b8,1f,35,85));
	outFields->push(HX_("items",00,ac,0c,c2));
	outFields->push(HX_("entries",50,2d,5f,79));
	outFields->push(HX_("originalItems",ef,a1,fd,1c));
	outFields->push(HX_("selectedIndex",b7,76,56,b4));
	outFields->push(HX_("lowerVisibleIndex",e1,78,7b,b7));
	outFields->push(HX_("upperVisibleIndex",c2,a5,5c,06));
	outFields->push(HX_("scrollBar",c6,57,fc,3d));
	outFields->push(HX_("actualHeight",15,25,ab,b7));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo CompletionList_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(CompletionList_obj,completed),HX_("completed",8b,a1,38,4f)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(CompletionList_obj,selectionChanged),HX_("selectionChanged",08,c2,cb,3c)},
	{::hx::fsObject /*  ::Dynamic */ ,(int)offsetof(CompletionList_obj,closed),HX_("closed",ac,a9,51,0e)},
	{::hx::fsString,(int)offsetof(CompletionList_obj,filter),HX_("filter",b8,1f,35,85)},
	{::hx::fsObject /* ::Array< ::String > */ ,(int)offsetof(CompletionList_obj,items),HX_("items",00,ac,0c,c2)},
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(int)offsetof(CompletionList_obj,entries),HX_("entries",50,2d,5f,79)},
	{::hx::fsObject /* ::Array< ::String > */ ,(int)offsetof(CompletionList_obj,originalItems),HX_("originalItems",ef,a1,fd,1c)},
	{::hx::fsInt,(int)offsetof(CompletionList_obj,selectedIndex),HX_("selectedIndex",b7,76,56,b4)},
	{::hx::fsInt,(int)offsetof(CompletionList_obj,lowerVisibleIndex),HX_("lowerVisibleIndex",e1,78,7b,b7)},
	{::hx::fsInt,(int)offsetof(CompletionList_obj,upperVisibleIndex),HX_("upperVisibleIndex",c2,a5,5c,06)},
	{::hx::fsObject /*  ::flixel::_hx_system::debug::completion::CompletionListScrollBar */ ,(int)offsetof(CompletionList_obj,scrollBar),HX_("scrollBar",c6,57,fc,3d)},
	{::hx::fsInt,(int)offsetof(CompletionList_obj,actualHeight),HX_("actualHeight",15,25,ab,b7)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *CompletionList_obj_sStaticStorageInfo = 0;
#endif

static ::String CompletionList_obj_sMemberFields[] = {
	HX_("completed",8b,a1,38,4f),
	HX_("selectionChanged",08,c2,cb,3c),
	HX_("closed",ac,a9,51,0e),
	HX_("filter",b8,1f,35,85),
	HX_("items",00,ac,0c,c2),
	HX_("entries",50,2d,5f,79),
	HX_("originalItems",ef,a1,fd,1c),
	HX_("selectedIndex",b7,76,56,b4),
	HX_("lowerVisibleIndex",e1,78,7b,b7),
	HX_("upperVisibleIndex",c2,a5,5c,06),
	HX_("scrollBar",c6,57,fc,3d),
	HX_("actualHeight",15,25,ab,b7),
	HX_("show",fd,d4,52,4c),
	HX_("setY",77,92,50,4c),
	HX_("close",b8,17,63,48),
	HX_("createPopupEntries",a0,65,fa,73),
	HX_("createScrollBar",2a,11,f1,de),
	HX_("onKeyDown",42,22,f2,73),
	HX_("updateIndices",1e,ac,c2,ae),
	HX_("bound",3e,b0,fc,b6),
	HX_("updateEntries",47,92,cd,44),
	HX_("updateLabels",e8,ce,40,49),
	HX_("updateSelectedItem",b7,20,67,4e),
	HX_("setItems",fe,14,41,d0),
	HX_("filterItems",28,01,bf,71),
	HX_("sortItems",c2,7f,80,ca),
	HX_("startsWithExt",6a,68,65,09),
	HX_("set_filter",f5,2d,3a,79),
	::String(null()) };

::hx::Class CompletionList_obj::__mClass;

void CompletionList_obj::__register()
{
	CompletionList_obj _hx_dummy;
	CompletionList_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.system.debug.completion.CompletionList",44,65,51,72);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(CompletionList_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< CompletionList_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = CompletionList_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = CompletionList_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace system
} // end namespace debug
} // end namespace completion
