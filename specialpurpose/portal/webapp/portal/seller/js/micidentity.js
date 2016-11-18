/*产品图片弹层 开始*/
function prodoctImgView() {
	if ( !document.getElementById('prodoctImgWarp') ) {
		return;	
	}
	var imgWarp = $('#prodoctImgWarp'), nameButton = $('.prodoct-name-button'); 
	for ( var i = 0; i < nameButton.length; i++ ) {
		$(nameButton[i]).mouseenter(function(){
			imgWarp.css({ display: 'block', left:$(this).offset().left + $(this).width() + 15 , top: $(this).offset().top - 13 });
		}).mouseleave(function(){
			imgWarp.timer = setTimeout(function(){
				imgWarp.css({ display: 'none' });		
			}, 0);
		});
	}
	imgWarp.mouseenter(function(){
		if ( imgWarp.timer ) {
			clearTimeout(imgWarp.timer);
		}
	}).mouseleave(function(){
		$(this).css({ display: 'none'});
	});
}
/*产品图片弹层 结束*/

var PopUp = function(options) {
    this.SetOptions(options);
    this.Marks = $(this.options.Marks);
    this.Wrapper = $("#" + this.options.Wrapper);
    this._img = new Image();
    this.BigImage = $("#" + this.options.BigImage);
    this.ImgSrc = [];
    this.ImgWidth = this.options.ImgWidth;
    this.ImgHeight = this.options.ImgHeight;
    this.LoadingSrc = this.options.LoadingSrc;
    this.loadingImage = $("<img alt=\"loading...\" title=\"picture loading...\" src=\"" + this.LoadingSrc + "\" />");
    this.Link = $(this.options.Link);
    this.ImageLink = $("#" + this.options.ImageLink);
	$('body').append(this.Wrapper);
};
PopUp.prototype = {
    SetOptions: function(options) {
        this.options = {
            Marks: ".prodoct-name-button",
            Link: ".prodoct-name-button",
            Wrapper: "prodoctImgWarp",
            BigImage: "BigImage",
            ImageLink: "ImgLink",
            ImgWidth: 215,
            ImgHeight: 215,
            LoadingSrc: "http://www.dhresource.com/dhs/fob/img/final/loading.gif"
        };
        $.extend(this.options, options || {})
    },
    SetPosition: function() {
		prodoctImgView();
    },
    LoadImage: function() {
        var obj_this = this;
        for (var i = 0; i < this.Marks.length; i++) {
            this.ImgSrc.push($(this.Marks[i]).attr("href")); 
			(function() {
                var p = i;
                $(obj_this.Marks[p]).bind("mouseenter",
                function() {
                    obj_this.ImageLink.attr("href", "#blank");
                    obj_this.BigImage.attr("src", "http://image.dhgate.com/2009/search/images/blank.gif");
                    obj_this.BigImage.hide();
                    obj_this.BigImage.after(obj_this.loadingImage);
                    $(obj_this._img).load(function() {
                        if (obj_this._img.width == 0 || obj_this._img.height == 0) return;
                        obj_this.PreLoad(obj_this._img.src, $(obj_this.Link[p]).attr("href"));
                        this._img = new Image()
                    });
                    obj_this._img.src = $(this).attr("href");
                })
            })()
        }
    },
    PreLoad: function() {
        this.AutoScaling();
        this.BigImage.attr("src", arguments[1]);
        this.loadingImage.remove();
        this.BigImage.show();
        this.ImageLink.attr("href", arguments[1]);
    },
    AutoScaling: function() {
        if (this._img.width > 0 && this._img.height > 0) {
            if (this._img.width / this._img.height >= this.ImgWidth / this.ImgHeight) {
                if (this._img.width > this.ImgWidth) {
                    this.BigImage.width(this.ImgWidth);
                    this.BigImage.height((this._img.height * this.ImgWidth) / this._img.width)
                } else {
                    this.BigImage.width(this._img.width);
                    this.BigImage.height(this._img.height)
                }
            } else {
                if (this._img.height > this.ImgHeight) {
                    this.BigImage.height(this.ImgHeight);
                    this.BigImage.width((this._img.width * this.ImgHeight) / this._img.height)
                } else {
                    this.BigImage.width(this._img.width);
                    this.BigImage.height(this._img.height)
                }
            }
        }
        this._img = new Image()
    },
    Start: function() {
        this.SetPosition();
        this.LoadImage();
        var obj_this = this;
        for (var i = 0; i < this.Marks.length; i++) {
            $(this.Marks[i]).bind("mouseenter",
            function() {
				if ( Marks.timer ) { clearTimeout(Wrapper.timer); }
                obj_this.Wrapper.css({  display: "block" });
            }).bind("mouseleave",
            function() {
			 	Marks.timer = setTimeout(function(){
                	obj_this.Wrapper.css({  display: "none" });
				}, 0);
            })
        }
        this.Wrapper.bind("mouseenter",
        function() {
			if ( Wrapper.timer ) {
			clearTimeout(Wrapper.timer);
			}
            obj_this.Wrapper.css({  display: "block" });
        }).bind("mouseleave",
        function() {
			Wrapper.timer = setTimeout(function(){
				obj_this.Wrapper.css({ display: "none" });		
			}, 0);
            
        })
    }
};
