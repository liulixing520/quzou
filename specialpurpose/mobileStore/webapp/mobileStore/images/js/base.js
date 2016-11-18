/**
 * jQuery功能强化（部分插件不支持IE6）
 * Created with IntelliJ IDEA.
 * User: lijiale
 * Date: 13-5-9
 * Time: 下午9:22
 * To change this template use File | Settings | File Templates.
 */


(function ($) {
    var debug = false, w = window, d = document;

    var FILE_NAME = 'base.js';
    /**
     * 获取元素位置及尺寸信息 不支持链式操作
     * @return {*}
     */
    $.fn.getPosAndSize = function () {
        var self = this.get(0);
        if (self == w) {
            return {width: this.width(), height: this.height(), top: 0, left: 0};
        } else if (self == d.body) {
            return {
                width: Math.max(self.offsetWidth, self.scrollWidth),
                height: Math.max(self.offsetHeight, self.scrollWidth),
                top: 0, left: 0
            };
        } else {
            return $.extend({}, (typeof self.getBoundingClientRect == 'function') ? self.getBoundingClientRect() : {
                width: self.offsetWidth, height: self.offsetHeight
            }, this.offset());
        }
    };


    /**
     * 在指定位置添加一个元素
     * option = {
     *      id : id
     *     ,position :  left | right | top | bottom | center
     *     ,content :  text | html | dom
     *     ,container : dom
     *     ,pla :  {x,y} 采用相对定位 以当前元素的位置为基准做偏移
     *     ,offsetPos :{top:..,left:...} 偏移量
     *     ,zIndex :  999
     *     ,click :  function
     * }
     * @return {*|null}
     */
    var CID = '_CV_OPT_';
    var COC = '_CV_CONF_';
    //default option
    var def = {
        position: 'bottom',
        floor: null,
        radius: true,
        zIndex: 999,
        inModal: false,
        shifty: false
    };
    $.fn.addCover = function (opt) {
        opt = merge(def, opt);
        return this.each(function () {
            var self = this, $self = $(this);
            var pos = $self.getPosAndSize();
            if (!$self.is(':visible')) {
                pos.left = 0;
                pos.top = 0;
                opt.shifty = true;
            }
            var it = $(this).data(opt.id ? CID + opt.id : CID);
            try {
                it && $(it).remove(); //clean
            } catch (err) {
                //
            }
            var $d = opt.floor ? $(opt.floor) : $(create('DIV')).css({
                position: opt.fixed ? 'fixed' : 'absolute',
                display: 'block',
                maxWidth: '2560',
                maxHeight: '1440',
                zIndex: opt.zIndex
            });
            $(opt.content).css({position: 'static', margin: 0});
            !opt.floor && $d.append(opt.content);
            !opt.radius || $d.children().css({borderRadius: "4px 4px 4px 4px"});
            self == document.body && (opt.container = self);
            opt.inModal ? $(document.body).append($d) : opt.container ? $d.appendTo(opt.container) : $d.insertAfter(self);
            var w = $d.get(0).offsetWidth || $d.get(0).scrollWidth || $d.children().width();
            var h = $d.get(0).offsetHeight || $d.get(0).scrollHeight || $d.children().height();
            $d.hide();
            var tp;
            var l = 0, t = 0, fixed = false;
            if (!opt.container) {
                var p = self;
                while (p.parentNode && p.parentNode != document.body) {
                    p = p.parentNode;
                    if ($(p).css('position') == 'absolute') {
                        var of = $(p).offset();
                        l += of.left;
                        t += of.top;
                    }
                    ($(p).css('position') == 'fixed') && (fixed = true);
                }
            }
            if (opt.pla) {
                var pl = pos.left ? pos.left : 0;
                var pr = pos.right ? pos.right : 0;
                var pt = pos.top ? pos.top : 0;
                var pb = pos.bottom ? pos.bottom : 0;
                if (!tp) {
                    tp = {};
                }
                if (opt.pla.left || opt.pla.left === 0) {
                    tp.left = pl + opt.pla.left;
                } else {
                    tp.right = pr + opt.pla.right;
                }
                if (opt.pla.top || opt.pla.top === 0) {
                    tp.top = pt + opt.pla.top;
                } else {
                    tp.bottom = pb + opt.pla.bottom;
                }
//                tp = {left: (pos.left ? pos.left : 0) + opt.pla.left, top: (pos.top ? pos.top : 0) + opt.pla.top};
            } else {
                switch (opt.position) {
                    case 'bottom':
                        tp = {top: pos.top + pos.height, left: pos.left + pos.width / 2 - w / 2};
                        break;
                    case 'top':
                        tp = {top: pos.top - h, left: pos.left + pos.width / 2 - w / 2};
                        break;
                    case 'left':
                        tp = {top: pos.top + pos.height / 2 - h / 2, left: pos.left - w};
                        break;
                    case 'right':
                        tp = {top: pos.top + pos.height / 2 - h / 2, left: pos.left + pos.width};
                        break;
                    case 'center':
                        tp = {top: pos.top + pos.height / 2 - h / 2, left: pos.left + pos.width / 2 - w / 2};
                        break;
                }
            }
            var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            var sl = Math.max(document.body.scrollLeft, document.documentElement.scrollLeft);
//            opt.initPos = fixed ? {left: tp.left - l - sl, top: tp.top - t - st} : {left: tp.left - l, top: tp.top - t};
            var initPos = {};
            if (tp.right || tp.right === 0) {
                initPos.right = opt.fixed ? tp.right - l - sl : tp.right - l;
            } else {
                initPos.left = opt.fixed ? tp.left - l - sl : tp.left - l;
            }
            if (tp.bottom || tp.bottom === 0) {
                initPos.bottom = opt.fixed ? tp.bottom - t - st : tp.bottom - t;
            } else {
                initPos.top = opt.fixed ? tp.top - t - st : tp.top - t;
            }
            initPos.height = h;
            initPos.width = w;
            opt.initPos = initPos;
            opt.initPos.height = h;
            opt.initPos.width = w;
            opt.objPos = pos;
            if (opt.offsetPos) {
                opt.offsetPos.top && (opt.initPos.top += opt.offsetPos.top);
                opt.offsetPos.left && (opt.initPos.left += opt.offsetPos.left);
            }
            $d.css({
                left: opt.initPos.left,
                top: opt.initPos.top,
                right: opt.initPos.right,
                bottom: opt.initPos.bottom
            });
            var id = opt.id ? opt.id : '';
            $self.data(CID + id, $d.get(0)).data(COC + id, opt);
            opt.click && $d.click(opt.click);
        });
    };

    /**
     * 重新计算cover的位置和尺寸信息
     * @param id
     * @returns {*}
     */
    $.fn.resetCover = function (id) {
        return this.each(function () {
            //TODO   resetSize
            var $self = $(this);
            var newPos = $self.getPosAndSize();
            id = id ? id : '';
            var it = $(this).data(CID + id);
            var opt = $(this).data(COC + id);
            var newObjPos = {};
            var st = opt.inModal ? Math.max(document.body.scrollTop, document.documentElement.scrollTop) : 0;
            var sl = opt.inModal ? Math.max(document.body.scrollLeft, document.documentElement.scrollLeft) : 0;
            if (opt.initPos.left || opt.initPos.left === 0) {
                newObjPos.left = opt.initPos.left - (opt.objPos.left - newPos.left) - (opt.modal ? 0 : sl);
            } else {
                newObjPos.right = opt.initPos.right - (opt.objPos.left - newPos.left) - (opt.modal ? 0 : sl);
            }
            if (opt.initPos.top || opt.initPos.top === 0) {
                newObjPos.top = opt.initPos.top - (opt.objPos.top - newPos.top) - (opt.modal ? 0 : st);
            } else {
                newObjPos.bottom = opt.initPos.bottom - (opt.objPos.top - newPos.top) - (opt.modal ? 0 : st);
            }
            var ih = Math.max($(it).get(0).offsetHeight, $(it).get(0).clientHeight) || $(it).get(0).scrollHeight || $(it).children().height();
            var newTop = newObjPos.top - (ih + newPos.height);
            if (opt.position == 'center' && ih) { //modal reset
                newObjPos.top += (opt.initPos.height - ih) / 2;
            }

            if (newObjPos.top + ih > $(window).height() && newTop >= 0) {    //垂直位置判定
                newObjPos.top = newTop;
                opt.reset2Top && opt.reset2Top.call(this); //set to top
//            }else if(newTop < 0){
//                newObjPos.top -= (ih - newObjPos)/2; //set to middle
//                opt.reset2Middle && opt.reset2Middle.call(this);
            } else {
                opt.recoverTop && opt.recoverTop.call(this);
            }
            $(it).css(newObjPos);

        });
    };

    /**
     * 显示cover
     * @param id
     * @return {*|null}
     */
    $.fn.showCover = function (id) {
        return this.each(function () {
            var $self = $(this);
            id = id ? id : '';
            var it = $(this).data(CID + id);
            var opt = $(this).data(COC + id);
            opt.shifty && $self.resetCover(id);
            it && $(it).show();
        });
    };

    /**
     * 获取cover设置
     * @param id
     * @returns {*}
     */
    $.fn.getCoverConfig = function (id) {
        id = id ? id : '';
        return $(this).data(COC + id);
    };

    /**
     * 隐藏cover
     * @param id
     * @return {*|null}
     */
    $.fn.hideCover = function (id) {
        return this.each(function () {
            id = id ? id : '';
            var it = $(this).data(CID + id);
            it && $(it).hide();
        });
    };

    /**
     * 是否有这个cover
     * @param id
     * @return {*|null}
     */
    $.fn.hasCover = function (id) {
        id = id ? id : '';
        return !!this.data(CID + id);
    };

    /**
     * @param expr
     * @return {*|null}
     */
    $.fn.findInCover = function (id, expr) {
        id = id || '';
        var it = $(this).data(CID + id);
        return it ? $(it).find(expr) : null;
    };

    /**
     * @param expr
     * @return {*|null}
     */
    $.fn.removeCover = function (id) {
        return this.each(function () {
            id = id ? id : '';
            var it = $(this).data(CID + id);
            it && $(it).remove();
        });
    };

    /**
     * 合并两个对象的属性  忽略父类的属性
     * @param o1
     * @param o2
     */
    $.simpleMerge = merge;

    function merge(o1, o2) {
        var o = {};
        wrap(o, o1);
        wrap(o, o2);
        return o;
    }

    /**
     * 将o2的所有属性复制到o1
     * @param o1
     * @param o2
     */
    $.simpleWrap = wrap;

    function wrap(o1, o2) {
        try {
            for (var p in o2) {
                if (o2.hasOwnProperty(p)) {
                    o1[p] = o2[p];
                }
            }
        } catch (err) {
            //do nothing
        }
    }

    /**
     * 创建dom
     * @param dom
     * @return {HTMLElement}
     */
    function create(dom) {
        return document.createElement(dom);
    }


    /**
     * 获取location
     * @return {*|Function|Function|Function|Function|string|String|Request.src|String|String|String|String|String|src|src|src|src|src}
     */
    function getLocation() {
        var s = document.getElementsByTagName("script");
        for (var i = s.length; i > 0; i--) {
            if (s[i - 1].src.indexOf(FILE_NAME) != -1) {
                return s[i - 1].src;
            }
        }
    }

    /**
     * 获取服务器域名
     * @returns {*}
     */
    $.getHost = function () {
        if (!$.__HOST__) {
            var loc = getLocation();
            loc = loc.replace('http://', '');
            $.__HOST__ = loc.substring(0, loc.indexOf('/'));
        }
        return $.__HOST__;
    };

    /**
     * 从当前目录加载css
     * @param model
     */
    $.importCSS = function (model) {
        if (model.indexOf('http') == -1) {
            model = getLocation().replace(FILE_NAME, model);
        }
        var dom = document.createElement("link");
        dom.setAttribute("type", "text/css");
        dom.setAttribute("rel", "stylesheet");
        dom.setAttribute("href", model);
        var heads = document.getElementsByTagName("head");
        if (heads.length) {
            heads[0].appendChild(dom);
        } else {
            document.documentElement.appendChild(dom);
        }
    };

    /**
     * 从当前目录加载JS
     * @param model
     */
    $.importJS = function (model) {
        var opt = {
            method: 'get',
            url: getLocation().replace(FILE_NAME, model),
            async: false,
            dataType: 'script'
        };
        $.ajax(opt);
    };


    /**
     * 断言工具
     * @type {{}}
     */
    $.assert = assert;
    var assert = {

        isNotNull: function (obj, msg) {
            if (!obj && obj !== '') {
                throw new Error(msg || 'Null error');
            }
        },

        isAvailable: function (obj, msg) {
            if (!obj) {
                throw  new Error(msg || 'Not available error');
            }
        },

        isNotEmpty: function (obj, msg) {
            if (typeof obj == "boolean") return;
            if (!obj || ($.type(obj) == 'string' && !$.trim(obj))
                || ($.type(obj) == 'array' && !obj.length)
                || ($.type(obj) == 'obj' && $.isEmptyObject(obj))
                || ($.type(obj) == 'obj' && $.isEmptyObject(obj))) {
                throw new Error(msg || 'Empty error')
            }
        }
    };

    /**
     * 获取游标位置
     * @type {Function}
     */
    $.getCursorPosition = getCursorPosition;

    function getCursorPosition(ctrl) {
        var CaretPos = 0;
        if (document.selection) {
            ctrl.focus();
            var Sel = document.selection.createRange();
            Sel.moveStart('character', -ctrl.value.length);
            CaretPos = Sel.text.length;
        } else if (ctrl.selectionStart || ctrl.selectionStart == '0')
            CaretPos = ctrl.selectionStart;
        return (CaretPos);
    }

    /**
     * 终止事件的默认行为
     * @type {Function}
     */
    $.breakEvent = breakEvent;

    function breakEvent(e) {
        e = e || window.event;
        e.returnValue = false;
        e.preventDefault();
    }

    /**
     * 数字输入辅助工具
     * @param cfg
     */
    var NUM_CFG = '__NUM__CFG';
    var NUM_DEF_CFG = {lazy: false, k: 2};
    $.fn.numInput = function (cfg) {
        return this.each(function () {
            cfg = $.simpleMerge(NUM_DEF_CFG, cfg);
            this[NUM_CFG] = cfg;
            var self = this, $self = $(this);
            if ($self.data(NUM_CFG)) return;
            window.attachEvent ? self.attachEvent('onpaste', breakEvent) : self.addEventListener('paste', breakEvent, false);
            $self.css({imeMode: 'disabled'}).keydown(function (ev) {
                ev = ev || window.event;
                var val = ev.target.value, conf = ev.target[NUM_CFG];
                var apply_dote = (val && val.indexOf('.') == -1) ? true : false;
                var apply_num = (val && val.indexOf('.') != -1
                && val.indexOf('.') == (val.length - (conf.k + 1))
                && getCursorPosition(this) == val.length) ? false : true;
                if (ev.keyCode == 110 || ev.keyCode == 190) {
                    (!apply_dote && breakEvent(ev)) || (apply_dote && (this.value = this.value + ".")), breakEvent(ev);
                } else if ((ev.keyCode > 95 && ev.keyCode < 106)
                    || (ev.keyCode > 47 && ev.keyCode < 58)
                ) {
                    !apply_num && breakEvent(ev);
                    if ((conf.min || conf.max) && !conf.lazy) {
                        var n = ev.keyCode > 95 ? ev.keyCode - 96 : ev.keyCode - 48;
                        val = parseFloat(val + '' + n);
                        conf.max < val && breakEvent(ev);
                        conf.min > val && breakEvent(ev);
                    }
                } else if (ev.keyCode == 8
                    || ev.keyCode == 46
                    || ev.keyCode == 37
                    || ev.keyCode == 39
                    || ev.keyCode == 9) {
                    //do nothing
                } else {
                    breakEvent(ev);
                }

            });
            $self.blur(function () {
                var conf = this[NUM_CFG];
                var i = $.trim($(this).val());
                if (i && i.length > 0) {
                    var p = parseFloat(i).toFixed(conf.k);
                    conf.max && p > conf.max && (p = conf.max);
                    conf.min && p < conf.min && (p = conf.min);
                    conf.k > 1 ? $(this).val(parseFloat(p).toFixed(conf.k)) : $(this).val(parseInt(p, 10))
                }
            });
        });
    };

    /**
     * 对输入动作进行监听
     * @param fn
     * @returns {*}
     */
    var OV = '__OLD_VALUE__';
    var NK = {9: true, 13: true};
    $.fn.input = function (fn) {
        return this.each(function () {
            var self = this, $self = $(this);
            self[OV] = $.trim($self.val());
            $self.keyup(function (e) {
                var val = $.trim($(this).val());
                NK[e.keyCode] || val == this[OV] || fn.call(this, e);
                this[OV] = val;
            });
        });
    };


    var _T_LIS_INIT_ = '_T_LIS_INIT_', _TLS_X_ = '_TLS_X_', _TLS_Y_ = '_TLS_Y_',_SC_ = '_SC_OFFSET_';
    var SLIDE_UP = '_TL_SLIDE_UP_', SLIDE_DOWN = '_TL_SLIDE_DOWN_', SLIDE_LEFT = '_TL_SLIDE_LEFT_', SLIDE_RIGHT = '_TL_SLIDE_RIGHT_';
    /**
     *上滑手势触发事件
     */
    $.fn.touchSlideUp = function (fn) {
        return this.each(function () {
            var self = this;
            _tl_init(self);
            !self[SLIDE_UP] && (self[SLIDE_UP] = []);
            self[SLIDE_UP].push(fn);
        });
    };

    /**
     * 扩展事件函数的解绑方法
     * @param event
     * @param fn
     */
    $.fn.unbindExt = function (event,fn) {
        return this.each(function() {
            switch (event) {
                case 'touchSlideUp' :
                    this[SLIDE_UP] = null;
                    break;
            }
        });
    };

    $.fn.unbindAllExt = function(event) {
        return this.each(function() {
            switch (event) {
                case 'touchSlideUp' :
                    this[SLIDE_UP] = null;
                    break;
            }
        });
    };

    function _tl_init(elem) {
        if (!elem[_T_LIS_INIT_]) {
            elem[_T_LIS_INIT_] = true;
            elem.addEventListener('touchstart', function (e) {
                e = e || window.event;

                var $e = $(elem);
                elem[_TLS_X_] = e.targetTouches[0].pageX;
                elem[_TLS_Y_] = e.targetTouches[0].pageY;
                if(elem == document.body || elem == document) {
                    elem[_SC_] = [$e.scrollLeft(),$(document).width() - $(window).width() - $(window).scrollLeft()
                        ,$e.scrollTop(), $(document).height() - $(window).height() - $(window).scrollTop()]
                }else {
                    elem[_SC_] = [$e.scrollLeft(),$e.width() - elem.scrollWidth + $e.scrollLeft()
                        ,$e.scrollTop(),$e.height() - elem.scrollHeight + $e.scrollTop()];
                }


            }, false);
            elem.addEventListener('touchend', function (e) {
                e = e || window.event;
                var x = e.changedTouches[0].pageX, y = e.changedTouches[0].pageY;
                var vx = x - elem[_TLS_X_], vy = y - elem[_TLS_Y_];
                var fns = null;
                if (Math.abs(vx) >= Math.abs(vy) && Math.abs(vx) > 180) {
                    fns = vx > 0 ? (Math.round(elem[_SC_][0]) === 0 && elem[SLIDE_RIGHT]) : (Math.round(elem[_SC_][1]) < 5 && elem[SLIDE_LEFT]) ;
                } else if(Math.abs(vy) > 180){
                    fns = vy > 0 ? (Math.round(elem[_SC_][2]) === 0 && elem[SLIDE_DOWN]) : (Math.round(elem[_SC_][3]) < 5 && elem[SLIDE_UP]);
                }
                if(!fns)
                    return;
                for (var i in fns) {
                    if (fns.hasOwnProperty(i)) {
                        fns[i].call(elem);
                    }
                }

            }, false);
        }
    }

    /**
     * 表单序列化
     * 针对使用了级联插件的表单在页面加载后马上执行serialize不能获取到正确结果的修正方法
     * @returns {*}
     */
    $.fn.formInitSerialize = function () {
        var $self = this, sel = this.serialize();
        sel = sel ? sel : '';
        $self.find('select,input').each(function () {
            var val = $(this).attr('val'), name = $(this).attr('name');
            var reg = new RegExp(name + '=[^&]*(&?)');
            if (val !== undefined && val !== null) {
                val = encodeURIComponent(val);
                reg.test(sel) ? (sel = sel.replace(reg, name + '=' + val + '$1')) : (sel += ('&' + name + '=' + val));
            }
        });
        var _reg = new RegExp('^\\s*&?(.*)$');
        return sel.replace(_reg, '$1');
    };

    /**
     * 使得一组checkbox的行为与radio一样，即同组中只能有一个被选中或赋值
     */
    var AR = '_AS_RADIO';
    $.fn.asRadio = function () {
        var $g = this;
        return $g.each(function () {
            var $self = $(this);
            $self.data(AR, $g).click(function () {
                var ths = this, $tg = $(this).data(AR);
                !this.checked || $tg.each(function () {
                    ths == this || $(this).attr('checked', false);
                })
            });
        });
    };

    $.fn.checked = function (ck) {
        return this.each(function () {
            ck ? (this.checked = 'checked') : (this.checked = '');
        });
    };

    /**
     * 具有全选功能的box
     * @type {string}
     */
    var CA = '__CHECK_BOX_NUM';
    $.fn.checkAllBox = function (expr) {
        return this.each(function () {
            var $c = expr.get ? expr : $(expr), $self = $(this);
            $self.data(CA, $c.find(':checked').length).click(function () {
                this.checked ? ($(this).data(CA, $c.length), $c.checked(true)) : ($(this).data(CA, 0), $c.checked(false));
            });
            $c.click(function () {
                var n = $self.data(CA);
                this.checked ? n++ : n--;
                n == $c.length ? $self.checked(true) : $self.checked(false);
                $self.data(CA, n);
            });
        });
    };

    /**
     * 获取文件大小
     * @returns {number}
     */
    $.fn.getFileSize = function () {
        var size = 0;
        this.each(function () {
            size += this.files[0].size;
        });
        return size;
    };

    /**
     * 表单各项值清空
     */
    $.fn.formClean = function () {
        return this.each(function () {
            var $self = $(this);
            $self.find(':text').each(function () {
                this.value = ''
            });
            $self.find(':checked').each(function () {
                this.checked = false
            });
            $self.find(':selected').each(function () {
                var val = $(this).attr('val');
                !val ? (this.selected = '') : $(this).resetAssort();
            });
            $self.find('textarea').val('');
            $self.find(':hidden').val('');
        });
    };

    /**
     * 使表格支持slideUp方法
     */
    $.fn.slideRowUp = function (sec, callback) {
        return this.each(function () {
            var $self = $(this);
            var $cells = $self.find('td').wrapInner('<div class="slideRowUp" />');
            var currentPadding = $cells.css('padding');
            var $cellContentWrappers = $self.find('.slideRowUp');
            $cellContentWrappers.slideUp(sec).parent().animate({
                paddingTop: '0px',
                paddingBottom: '0px'
            }, {
                complete: function () {
                    $(this).children('.slideRowUp').replaceWith($(this).children('.slideRowUp').contents());
                    $(this).parent().css({'display': 'none'});
                    $(this).css({'padding': currentPadding});
                }
            });
            window.setTimeout(function () {
                callback && callback.call($self.get(0));
            }, sec);
        });
    };

    $.fn.slideRowDown = function (sec, callback) {
        return this.each(function () {
            var $self = $(this);
            var $cells = $self.find('td');
            $cells.wrapInner('<div class="slideRowDown" style="display:none;" />');
            var $cellContentWrappers = $cells.find('.slideRowDown');
            $self.show();
            $cellContentWrappers.slideDown(sec, function () {
                $(this).replaceWith($(this).contents());
            });

            window.setTimeout(function () {
                callback && callback.call($self.get(0));
            }, sec);
            return $(this);
        });
    };

    /**
     * 为表单元素赋值 兼容select
     * @param v
     */
    $.fn.setVal = function (v) {
        return this.each(function () {
            var self = this, $self = $(this);
            if (self.tagName == 'SELECT') {
                $self.find('option').each(function () {
                    if ($(this).val() == $.trim(v)) {
                        this.selected = 'selected';
                    }
                });
            } else {
                $self.val(v);
            }
        });
    };

    /**
     * 检测浏览器是否安装了flash
     * @returns {boolean}
     */
    $.hasFlash = function () {
        var isIE = (navigator.appVersion.indexOf("MSIE") >= 0);
        var hasFlash = true;
        if (isIE) {
            try {
                new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
            } catch (e) {
                hasFlash = false;
            }
        } else {
            if (!navigator.plugins["Shockwave Flash"]) {
                hasFlash = false;
            }
        }
        return hasFlash;
    };

    /**
     * 检测脚本是否工作在移动端
     */
    $.isMobile = function() {
        var ua = navigator.userAgent.toLowerCase();
        return ua.match(/Mobile/i) !== null;
    }

})(jQuery);


//Add placeholder support for IE
function _ph_support() {
    return 'placeholder' in document.createElement('input') || document.getElementById('_ph_disabled');
}
var PH_SID = '__PH_SID';
$(function () {

    if (!_ph_support()) {
        $('select,textarea,input[type!="button"][type!="submit"][type!="reset"]').each(function () {
            var self = this, $self = $(this);
            var txt = $self.attr('placeholder'), val = $self.val();
            if (txt) {
                var h = $self.height();
                $self.addCover({
                    id: PH_SID,
                    content: '<span style="color:gray;font-size:14px">' + txt + '</span>',
                    pla: {left: 10, top: (h - 14) / 2},
                    click: function () {
                        $(this).hide();
                        window.setTimeout(function () {
                            self.focus()
                        }, 100);
                    }
                }).focus(function () {
                    $(this).hideCover(PH_SID);
                }).blur(function () {
                    var val = $(this).val();
                    val && (val = $.trim(val));
                    !val && $(this).showCover(PH_SID);
                });
                !val && $self.showCover(PH_SID);
            }
        });
    }
    //init numInput
    $('.numInput').numInput({k: 0});
    //disable enter submit
    $('form').bind("keypress", function (e) {
        var code = e.keyCode || e.which;
        if (code == 13) {
            e.preventDefault();
            return false;
        }
    });
});

document.createElement("footer"); //fix for IE


