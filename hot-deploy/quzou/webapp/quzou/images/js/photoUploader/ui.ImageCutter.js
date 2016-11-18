/**
 * init imageCutter css
*/
Std.css({
    ".StdUI_ImageCutter":{
        position:"relative",
        overflow:"auto",
        background:"white",
        '>':{
            "._image":{

            },
            "._locker":{
                left:0,
                top:0,
                width:"100%",
                height:"100%",
                background:"black",
                position:"absolute"
            },
            "._picker":{
                left:0,
                top:0,
                border:"1px dashed rgba(196,17,17,0.5)",
                position:"absolute"
            }
        }
    }
});

/**
 *  imageCutter widget module
*/
Std.ui.module("ImageCutter",{
    /*[#module option:parent]*/
    parent:"widget",
    /*[#module option:events]*/
    events:"dragStart dragStop dblclick",
    /*[#module option:option]*/
    option:{
        level:4,
        width:400,
        height:300,
        pickerWidth:150,
        pickerHeight:150,
        className:"StdUI_ImageCutter",
        image:null,
        lockerOpacity:0.4,
        scale:1.5
    },
    protected:{
        positionX : 0,
        positionY : 0,
        imageData : null
    },
    extend:{
        /*
         *
        */
        render:function(){
            var that = this;

            that.initPicker();
            that.initDrag();
        },
        /*
         *
        */
        width:function(width){
            var that = this;


        },
        /*
         *
        */
        height:function(height){
            var that = this;


        }
    },
    /*[#module option:private]*/
    private:{
        /*
         * init picker
        */
        initPicker:function(){
            var that = this;
            var opts = that.opts;

            Std.dom(that.D.picker).css({
                width  : opts.pickerWidth,
                height : opts.pickerHeight
            });

            return that;
        },
        /*
         * init events
        */
        initDrag:function(){
            var that   = this;
            var opts   = that.opts;
            var posX   = 0;
            var posY   = 0;
            var rect   = null;
            var offset = null;

            var moving = function(e){
                var positionX = e.pageX - offset.x - posX + rect.left;
                var positionY = e.pageY - offset.y - posY + rect.top;

                if(positionX < 0){
                    positionX = 0;
                }else if(positionX > rect.width - opts.pickerWidth - 2){
                    positionX = rect.width - opts.pickerWidth - 2;
                }
                if(positionY < 0){
                    positionY = 0;
                }else if(positionY > rect.height - opts.pickerHeight - 2){
                    positionY = rect.height - opts.pickerHeight - 2;
                }

                Std.dom(that.D.picker).css({
                    top:positionY,
                    left:positionX
                });
                that.D.picker.getContext("2d").drawImage(that._imageData,
                    -++positionX,
                    -++positionY,
                    that._imageData.width * that.scale(),
                    that._imageData.height * that.scale()
                );
                that._positionX = positionX + 1;
                that._positionY = positionY + 1;
            };

            Std.dom(that.D.picker).mouse({
                down:function(e){
                    var pos = Std.dom(that.D.picker).position();

                    offset  = that[0].offset();
                    rect    = Std.dom(that.D.image).css(["width","height"]);
                    posX    = e.pageX - offset.x - pos.x;
                    posY    = e.pageY - offset.y - pos.y;

                    rect.top  = that[0].scrollTop();
                    rect.left = that[0].scrollLeft();

                    that.emit("dragStart",e);
                    that[0].on("mousemove",moving);
                    that[0].css("cursor","move");
                },
                up:function(e){
                    that.emit("dragStop",e);
                    that[0].off("mousemove",moving);
                    that[0].removeStyle("cursor");
                },
                dblclick:function(){
                    that.emit("dblclick");
                }
            });
            return that;
        }
    },
    /*[#module option:public]*/
    public:{
        /*
         * attribute
        */
        attribute:function(){
            var that = this;
            var opts = that.opts;

            return {
                width     : opts.pickerWidth,
                height    : opts.pickerHeight,
                positionX : that._positionX,
                positionY : that._positionY
            };
        },
        /*
         * scale
        */
        scale:function(n){
            var that  = this;
            var image = that._imageData;

            return this.opt("scale",n,function(){
                var dom_image  = that.D.image;
                var dom_picker = that.D.picker;

                if(!dom_image || !image){
                    return;
                }
                dom_image.width  = image.width * that.scale();
                dom_image.height = image.height * that.scale();
                dom_image.getContext("2d").drawImage(image,0,0,image.width * that.scale(),image.height * that.scale());

                dom_picker.width  = that.opts.pickerWidth;
                dom_picker.height = that.opts.pickerHeight;
                dom_picker.getContext("2d").drawImage(image,0,0,image.width * that.scale(),image.height * that.scale());
                Std.dom(dom_picker).css({
                    left:0,
                    top:0
                });

                that.D.locker.css({
                    width:image.width * n,
                    height:image.height * n
                });
            });
        },
        /*
         * 将选择位置的图片转换为base64
        */
        toBase64:function(){
            var that    = this;
            var opts    = that.opts;
            var data    = that._imageData;
            var canvas  = document.createElement("canvas");
            var context = canvas.getContext("2d");

            if(data === null){
                return data;
            }

            canvas.width  = opts.pickerWidth;
            canvas.height = opts.pickerHeight;

            context.drawImage(data,-that._positionX,-that._positionY,data.width * that.scale(),data.height * that.scale());

            return canvas.toDataURL();
        },
        /*
         * load image
        */
        image:function(url){
            var that = this;
            var load = function(image){
                that._imageData = image;
                that.scale(that.opts.scale);
            };

            if(url.substr(0,5) === "data:"){
                Std.loader.image(url,function(imageData){
                    load(this)
                });
            }else{
                Std.loader(url,function(image){
                    if(!(image = image.data)){
                        return;
                    }
                    load(image);
                });
            }

            return that;
        },
        /*
         * image size
        */
        imageSize:function(){
            var that = this;
            var data = that._imageData;

            return data === null ? data : {
                width:data.width,
                height:data.height
            };
        },
        /*
         * locker opacity
        */
        lockerOpacity:function(opacity){
            return this.opt("lockerOpacity",opacity,function(){
                this.D.locker.opacity(opacity);
            });
        }
    },
    /*[#module option:main]*/
    main:function(that,opts,dom){
        that.D = {
            image  : newDom("canvas","_image").dom,
            locker : newDiv("_locker"),
            picker : newDom("canvas","_picker").dom
        };

        dom.append([
            that.D.image,
            that.D.locker,
            that.D.picker
        ]);

        if(!isEmpty(opts.image)){
            that.image(opts.image);
        }
        that.lockerOpacity(opts.lockerOpacity);
    }
});
