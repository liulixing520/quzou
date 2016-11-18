/**
 * ComboBoxItem widget module
*/
Std.ui.module("ComboBoxItem",{
    /*[#module option:parent]*/
    parent:"Item",
    /*[#module option:option]*/
    option:{
        className:"StdUI_ComboBoxItem"
    }
});

/**
 * ComboBox widget module
*/
Std.ui.module("ComboBox",{
    /*[#module option:parent]*/
    parent:"widget",
    /*[#module option:action]*/
    action:{
        content:"value",
        children:"append"
    },
    /*[#module option:option]*/
    option:{
        level:3,
        className:"StdUI_ComboBox",
        minWidth:60,
        minHeight:26,
        maxHeight:26,
        width:400,
        height:26,
        items:null,
        value:null,
        inputMode:"none",  //none,input
        valueMode:"text"   //text,index,item
    },
    /*[#module option:events]*/
    events:"open close select change focus blur",
    /*[#module option:protected]*/
    protected:{
        listVisible:false,
        currentMode:"",
        currentItem:null,
        selectedItem:null
    },
    /*[#module option:extend]*/
    extend:{
        /*
         * extend remove
        */
        remove:function(index){
            if(index === undefined){
                this.D.list && this.D.list.remove();
                this.delDocumentEvents();
            }
        },
        /*
         * extend height
        */
        height:function(height){
            var that = this;
            var doms = that.D;

            height = that.height() - that.boxSize.height;

            doms.input   && doms.input.css({
                height:height,
                lineHeight:height
            });
            doms.content && doms.content.css({
                height:height,
                lineHeight:height
            });
        },
        /*
         * extend width
        */
        width:function(width){
            var that = this;
            var doms = that.D;

            width = that.width() - that.boxSize.width;

            doms.input   && doms.input.css({
                width:width - 24
            });
            doms.content && doms.content.css({
                width:width - 24
            });
        }
    },
    /*[#module option:private]*/
    private:{
        /*
         * trigger list
        */
        triggerList:function(){
            var that = this;

            if(!that.enable()){
                return;
            }
            if(that._listVisible == true){
                that.close();
            }else{
                that.open();
            }
            return that;
        },
        /*
         * item mouse enter
        */
        itemMouseEnter:function(element,e){
            var that        = this;
            var index       = element.index();
            var currentItem = that.items[index];

            element.mouse({
                auto:false,
                classStatus:false,
                enter:function(){
                    that._selectedItem && that._selectedItem.removeClass("selected");
                    that._selectedItem =  currentItem.addClass("selected");
                },
                click:function(){
                    that.value(currentItem);
                    that.triggerList();
                    that.focus();
                }
            },e);

            return that;
        },
        /*
         * addDocumentEvents
        */
        addDocumentEvents:function(){
            var that  = this;
            var doms  = that.D;

            Std.dom(document).on("mousedown",that._documentEvents || (that._documentEvents = function(e){
                if(doms.list && doms.list.contains(e.target)){
                    return;
                }
                that.delDocumentEvents().close();
            }));
            return that;
        },
        /*
         * delDocumentEvents
        */
        delDocumentEvents:function(){
            var that = this;

            if(that._documentEvents){
                Std.dom(document).off("mousedown",that._documentEvents);
            }
            return that;
        },
        /*
         * init handle
        */
        initHandle:function(){
            var that = this;
            var doms = that.D;

            if(doms.handle != undefined){
                return that;
            }
            doms.handle = newDiv("_handle").appendTo(that[0]);

            return that;
        },
        /*
         * init keyboard
        */
        initKeyboard:function(){
            var that  = this;

            that.on("keydown",function(e){
                var items   = that.items;
                var index   = items.indexOf(that._currentItem);
                var which   = e.which;
                var keyCode = e.keyCode;

                if(which === 27){
                    that.close();
                }else if(which === 32){
                    that.inputMode() === "none" && that.open();
                }
                if(index == -1){
                    return;
                }
                if(keyCode === 38){
                    that.value(--index < 0 ? items[items.length - 1] : items[index]);
                    that.focus();
                }else if(keyCode === 40){
                    that.value(++index >= items.length ? items[0] : items[index]);
                    that.focus();
                }
            });
            return that;
        },
        /*
         * init events
        */
        initEvents:function(){
            var that  = this;
            var state = false;

            that[0].on("mousedown",function(e){
                if(e.target.nodeName !== "INPUT"){
                    that.triggerList();
                }
            }).on("focusin",function(){
                that.addClass("focus").emit("focus");
                if(state === false){
                    that.initKeyboard().on("focusout",function(){
                        (that.emit("blur"))[0].removeClass("focus");
                    });
                    that.D.input && that.D.input.on("change",function(){
                        that.emit("change");
                    });
                    state = true;
                }
            }).mouse({
                unselect:true
            });

            return that;
        },
        /*
         * init list
        */
        initList:function(){
            var that = this;
            var doms = that.D;

            if(doms.list !== undefined){
                return that;
            }
            doms.list = newDiv("StdUI StdUI_ComboBoxList").appendTo("body").on("mousedown",function(e){
                e.preventDefault();
            }).delegate("mouseenter",".StdUI_ComboBoxItem",function(e){
                that.itemMouseEnter(this,e);
            });
            that.items.each(function(i,item){
                item.renderTo(doms.list);
            });
            return that;
        }
    },
    /*[#module option:public]*/
    public:{
        /*
         * value valid
        */
        valid:function(){
            var that      = this;
            var validator = that.opts.validator;

            if(isEmpty(validator)){
                return true;
            }
            return Std.is(validator,that.value());
        },
        /*
         * value
        */
        value:function(value){
            var that   = this;
            var method = that[that.opts.valueMode + "Value"];

            if(isFunction(method)){
                return method.call(that,value);
            }
            if(value === undefined){
                return null;
            }
            return that;
        },
        /*
         * select
        */
        select:function(item){
            var that = this;

            if(isNumber(item)){
                item = that.items[item];
            }
            if(isWidget(item) && that._currentItem !== item){
                that._currentItem && that._currentItem.removeClass("selected");
                that._currentItem =  that._selectedItem = item.addClass("selected");
                that.emit("select");
            }
            return that;
        },
        /*
         * input mode
        */
        inputMode:function(mode){
            var that = this;
            var doms = that.D;

            return that.opt("inputMode",mode,function(){
                doms.input   && doms.input.remove();
                doms.content && doms.content.remove();

                if(that._currentMode !== ""){
                    that.removeClass(that._currentMode);
                }

                if(mode === "input"){
                    doms.input   = newDom("input", "_input").appendTo(that[0]);
                }else if(mode === "none"){
                    doms.content = newDiv("_content").appendTo(that[0]);
                }
                that.addClass(that._currentMode = mode);
            });
        },
        /*
         * text value
        */
        textValue:function(value){
            var that      = this;
            var doms      = that.D;
            var data      = value;
            var inputMode = that.inputMode();

            if(inputMode === "input"){
                if(value === undefined){
                    return doms.input.value();
                }
                if(isWidget(value)){
                    data = value.text();
                }
                doms.input && doms.input.value(data);
            }else if(inputMode === "none"){
                if(value === undefined){
                    return doms.content.text();
                }
                if(isWidget(value)){
                    data = value[0].clone().className(value.opts.className)
                }
                doms.content && doms.content.html(data);
            }
            return that.select(value);
        },
        /*
         * index value
        */
        indexValue:function(value){
            var that      = this;
            var doms      = that.D;
            var item      = null;
            var items     = that.items;
            var index     = value;
            var inputMode = that.inputMode();

            if(value === undefined){
                return that._currentItem ? items.indexOf(that._currentItem) : null;
            }
            if(isWidget(value)){
                if((index = items.indexOf(value)) === - 1){
                    return that;
                }
            }
            if(!(item = items[index])){
                return that;
            }
            if(inputMode === "input"){
                doms.input   && doms.input.value(item.text());
            }else if(inputMode === "none"){
                doms.content && doms.content.html(item[0].clone().className(item.opts.className));
            }

            return that.select(index);
        },
        /*
         * item value
        */
        itemValue:function(value){
            var that      = this;
            var doms      = that.D;
            var item      = null;
            var items     = that.items;
            var index     = -1;
            var inputMode = that.inputMode();

            if(value === undefined){
                return that._currentItem ? that._currentItem.value() : null;
            }
            if(isWidget(value)){
                if((index = items.indexOf(value)) === - 1){
                    return that;
                }
                item = value;
            }
            index == -1 && that.items.each(function(i,tempItem){
                if(tempItem.value() !== value){
                    return;
                }
                item  = tempItem;
                index = i;
                return false;
            });

            if(item === null){
                return that.select(index);
            }

            if(inputMode === "input"){
                doms.input && doms.input.value(item.text());
            }else if(inputMode === "none"){
                doms.content && doms.content.html(item[0].clone().className(item.opts.className));
            }
            return that.select(index);
        },
        /*
         * open list
        */
        open:function(){
            var that   = this;
            var doms   = that.D;
            var offset = that[0].offset();
            var height = 0;

            if(that._listVisible){
                return that;
            }
            if(!doms.list){
                that.initList();
            }

            doms.handle.addClass("open");
            doms.list.show().css({
                left     : offset.x,
                top      : offset.y + that.height(),
                width    : that[0].width() - 2,
                height   : (height = doms.list.height()) ? 0 : 0,
                opacity  : 0,
                overflow :"hidden"
            }).animate({
                100:{
                    height:height,
                    opacity:1
                }
            },{
                duration:150,
                timingFunction:"ease-in"
            },function(){
                that.addDocumentEvents();
                doms.list.removeStyle("overflow");
            });

            setTimeout(function(){
                doms.list.css("zIndex",++Std.ui.status.zIndex);
            },5);

            that._listVisible = true;

            return that.emit("open");
        },
        /*
         * close list
        */
        close:function(){
            var that  = this;
            var doms  = that.D;

            if(!that._listVisible){
                return that;
            }

            doms.handle.removeClass("open");
            doms.list && doms.list.css("overflow","hidden").animate({
                100:{
                    height:0,
                    opacity:0
                }
            },140,function(){
                doms.list.hide().removeStyle("overflow height");
                if(that._selectedItem !== null){
                    that._selectedItem.removeClass("selected");
                }
                if(that._currentItem !== null){
                    that._selectedItem = that._currentItem.addClass("selected");
                }
            });
            that.delDocumentEvents();
            that._listVisible = false;

            return that.emit("close");
        },
        /*
         * append item
        */
        append:Std.func(function(data){
            var that  = this;
            var item  = null;

            if(isString(data)){
                item = Std.ui("ComboBoxItem",{text:data});
            }else if(isWidget(data)){
                item = data;
            }else if(isObject(data)){
                item = Std.ui(data.ui || "ComboBoxItem",data);
            }

            if(!isWidget(item)){
                return;
            }
            if(that.D.list){
                item.renderTo(that.D.list);
            }
            that.items.push(item);
        },{
            each:[isArray]
        })
    },
    /*[#module option:main]*/
    main:function(that,opts,dom){
        that.D     = {};
        that.items = [];

        that.inputMode(opts.inputMode);
        that.initEvents();
        that.initHandle();

        if(opts.items !== null){
            that.append(opts.items);
        }
        that.call_opts({
            value:null
        },true);
    }
});
