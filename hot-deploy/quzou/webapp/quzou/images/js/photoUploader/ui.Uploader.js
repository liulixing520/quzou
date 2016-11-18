Std.ui.module("UploadPhoto",{
    parent:"widget",
    events:"submit",
    option:{
        level:4,
        image:null,
        width:500,
        height:500,
        pickerWidth:332,
        pickerHeight:144,
        action:""
    },
    protected:{
        fileName:null,
        fileSize:0
    },
    extend:{
        render:function(){
            var that = this;

            that.layout({
                ui:"VBoxLayout",
                spacing:0,
                items:[
                    that._imageCutter,
                    that._stateWidget
                ]
            });
            return that;
        }
    },
    private:{
        initButtons:function(){
            var that = this;

            that._submitButton[0].on("click",function(){
                var data = that._imageCutter.toBase64();

                that.emit("submit",[data,that._imageCutter.attribute()],true);
            });

            that._selectButton[0].css("position","relative").readLocalImage({
                callback:function(data){
                    that._fileName = data.fileName;
                    that._fileSize = data.fileSize;
                    that.image(data.data);
                }
            });
            return that;
        }
    },
    public:{
        image:function(src){
            var that = this;

            if(src === undefined){
                return that._imageCutter.image();
            }
            that._imageCutter.image(src);
            return that;
        }
    },
    main:function(that,opts,dom){
        var slider        = new Std.dom("input[type=range][min=10][max=200][stop=100]");
        slider.on("change",function(){
            that._imageCutter.scale(this.value() / 100)
        });
        that.D            = {};
        that._imageCutter = Std.ui("ImageCutter",{
            pickerWidth:opts.pickerWidth,
            pickerHeight:opts.pickerHeight
        });
        that._stateWidget = Std.ui("widget",{
            height:40,
            layout:{
                ui:"HBoxLayout",
                spacing:10,
                items:[
                    {
                        ui:"Label",
                        value:"缩放比例:"
                    },
                    {
                        ui:"widget",
                        level:3,
                        html:slider.width("100%")
                    },
                    that._selectButton = Std.ui("Button",{
                        text:"选择本地图片"
                    }),
                    that._submitButton = Std.ui("Button",{
                        text:"确定剪裁"
                    })
                ]
            }
        });
        if(opts.image){
            that.image(opts.image);
        }
        that.initButtons();
    }
});

//-------Std Dom 文件读取扩展
Std.dom.extend({
    readLocalImage:function(options){
        var that    = this;
        var opts    = Std.extend({
            callback:null,
            maxFileSize:1024 * 1024 * 10
        },options);

        var reader  = new FileReader;
        var element = null;
        var create  = function(){
            element = new Std.dom("input[type='file']",that.parent()).css({
                position: "absolute",
                opacity : 0,
                left    : that.position().x,
                top     : that.position().y,
                zIndex  : ++Std.ui.status.zIndex
            }).on({
                change:function(){
                    fileChange();
                }
            });
        };

        var fileChange = function(){
            var files = element.dom.files;

            if(files.length < 0 || files[0].size > opts.maxFileSize){
                return;
            }
            if(!Std.url.suffix.img(Std.url(files[0].name).suffix)){
                return;
            }
            reader.readAsDataURL(files[0]);
            reader.onload = function(){
                if(isFunction(opts.callback)){
                    opts.callback.call(that,{
                        fileName:files[0].name,
                        fileSize:files[0].size,
                        data:reader.result
                    });
                }
            };
        };

        that.on("mouseenter",function(){
            var offset = that.position();
            if(element === null){
                create();
            }
            element.css({
                width   : that.outerWidth(),
                height  : that.outerHeight(),
                left    : offset.x,
                top     : offset.y
            })
        });

        return that;
    }
});