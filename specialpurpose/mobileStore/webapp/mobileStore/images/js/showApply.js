/**
 * Created by lijiale on 2014/11/17.
 */
$(function () {

    $.importJS('modal/modal.js');
    $.importCSS('modal/modal.css');

    $('.link-help').click(function(){
       warn('');
    });

    $('.goods-apply-service .list-item').click(function () {
        var $self = $(this), $st = $('#serviceType'), type = $self.data('type');
        if ($self.hasClass('active'))
            return console.info('skip');
        $self.addClass('active').siblings().removeClass('active');
        $('.activeSection').hide().removeClass('.activeSection');
        $st.val(type);
        $('#customerExpect').val(type);
        switch (type) {
            case 10:
                $('.goods-apply-refund,.goods-apply-gift').show().addClass('activeSection');
                break;
            case 20:
                $('.goods-apply-type,.goods-apply-size').show().addClass('activeSection');
                break;
            case 30:
                break;
        }
    });

    $('.goods-apply-refund .list-item').click(function () {
        var $self = $(this), $rt = $('#refundType'), $bf = $('#bankInfoForm'), $rf = $('#refundGenericMsg'), $pm = $('#payPassMsg'), type = $self.data('type');
        if ($self.hasClass('active'))
            return console.info('skip');
        $self.addClass('active').siblings().removeClass('active');
        $('.actRefundType').hide().removeClass('.actRefundType');
        !$self.hasClass('disable') ? $rt.val(type) : $rt.val(0);
        switch (type) {
            case 1:
                $self.hasClass('disable') && $pm.addClass('actRefundType').show();
                break;
            case 2:
                $rf.show().addClass('actRefundType');
                break;
            case 3:
                $bf.show().addClass('actRefundType');
                break;
        }
    });

    $('.goods-apply-invoice .list-item,.goods-apply-testing .list-item').click(function () {
        var $self = $(this), $radio = $self.find('span'), type = $self.data('type'), $bind = $('#' + $self.parent().data('bind')), mark = $self.parent().data('msg-mark');
        if (!$radio.hasClass('checked')) {
            $('.' + mark).hide().removeClass(mark);
            $self.siblings('li').find('span').removeClass('checked');
            $radio.addClass('checked');
            $bind.val(type);
            $('#' + $self.data('msg')).show().addClass(mark);
        }

    });

    $('.goods-apply-type .list-item,.goods-apply-size .list-item').click(function () {
        var $self = $(this), type = $self.data('type'), name = $self.data('name'), $tb = $('#' + $self.parent().data('type-bind')), $nb = $('#' + $self.parent().data('name-bind'));
        if (!$self.hasClass('active')) {
            $self.addClass('active').siblings('li').removeClass('active');
            $tb.val(type);
            $nb.val(name);
        }
    });

    //拍照支持
    $('#mobileUpload').click(function () {
        try {
            if ($("#img-wrapper").find(".img-item").length < 3) {
                var platform = $('#platform').val();
                switch (platform) {
                    case "android":
                    {
                        JDClient.openCamera();
                        break;
                    }
                    case "apple":
                    {
                        window.location.href = "objc:callCamera";
                        break;
                    }
                    case "wp":
                    {
                        window.external.Notify("callCamera_repairGoods");
                        break;
                    }
                    default :
                    {
                        JDClient.openCamera();
                        break;
                    }
                }
            } else {
                warn('\u6700\u591a\u652f\u6301\u4e0a\u4f203\u5f20\u56fe\u7247');
            }
        } catch (e) {
            warn(e.message);
        }
    });
    //删除图片
    $("#img-wrapper").delegate('.img-item', 'click', function () {
        var $it = $(this);
        cnfrm('您确认要删除这张图片吗？',function(ok) {
            if(ok) {
                $it.remove();
                var pis = [];
                $("#img-wrapper").find('.img-item').each(function(){
                    pis.push($(this).data("img"));
                });
                $('#hidtxt_questionPic').val(pis.join(','));
                var $igw = $('#img-wrapper');
                if($igw.find(".img-item").length<3){
                    $('.upload-btn-box').show();
                }

            }
        });
    });


    function init() {
        var refundType = $('#refundType').val(), $pop = $('.pop-ctm-01');
        $('.goods-apply-refund .list-item').each(function () {
            var $self = $(this), type = $self.data('type');
            if (type == refundType) {
                $self.addClass('active');
                return false;
            }
        });

        var dw = $(window).width(), pw = $pop.outerWidth();
        $pop.css({left: (dw - pw) / 2 + 'px'});
        //回退控制
        var $st = $('#serviceType');
        if($st.val()) {
            $('.goods-apply-service .list-item').each(function() {
                var $self = $(this);
                if(parseInt($self.data('type'),10) == parseInt($st.val(),10)) {
                    $self.addClass('active');
                    return false;
                }
            });
        }
        $('.goods-apply-invoice .list-item,.goods-apply-testing .list-item').each(function () {
            var $self = $(this), $radio = $self.find('span'), type = $self.data('type'), $bind = $('#' + $self.parent().data('bind')), mark = $self.parent().data('msg-mark');
            if ($bind.val() && parseInt($bind.val(),10) == parseInt(type,10)) {
                $('.' + mark).hide().removeClass(mark);
                $self.siblings('li').find('span').removeClass('checked');
                $radio.addClass('checked');
                $('#' + $self.data('msg')).show().addClass(mark);
            }

        });

    }

    $('.jd-btns').click(function () {
        if (validate()) {
            console.info('validate success');
            $('#mainForm').submit();
        } else {
            console.info('validate failed');
        }
    });

    $('#warn-close-btn').click(function () {
        closeWarn();
    });

    $('#confirm-ok-btn').click(function () {
        _CONFIRM_FN_ && _CONFIRM_FN_(true);
        closeCnfrm();
    });

    $('#confirm-close-btn').click(function () {
        _CONFIRM_FN_ && _CONFIRM_FN_(false);
        closeCnfrm();
    });

    init();
});

var _CONFIRM_FN_ = null;

function _disablePageMove(event) {
    event.preventDefault();
}

function warn(content) {
    $('#pop-warn').show().find('#warn-content').text(content);
    $('.new-shade').show();
    document.body.addEventListener('touchmove', _disablePageMove, false);
    return false;
}

function closeWarn() {
    $('#pop-warn,.new-shade').hide();
    document.body.removeEventListener('touchmove', _disablePageMove, false);
}

function cnfrm(content, fn) {
    var $pc = $('#pop-confirm');
    $pc.show().find('#confirm-content').text(content);
    $('.new-shade').show();
    document.body.addEventListener('touchmove', _disablePageMove, false);
    _CONFIRM_FN_ = fn;
    return false;
}

function closeCnfrm() {
    $('#pop-confirm,.new-shade').hide();
    document.body.removeEventListener('touchmove', _disablePageMove, false);
}

function operateWareNum(num, max) {
    var $wn = $('#wareNum'), nv = parseInt($wn.val(), 10) + num;
    if (nv < 1 || nv > max)
        return;
    $wn.val(nv);
}

function validate() {
    var st = $('#serviceType').val();
    if (!st) return warn('请选择您要申请的售后服务类型');
    st = parseInt(st,10);
    switch (st) {
        case 10 :
            var rt = parseInt($('#refundType').val(),10);
            if(rt == 0) {
                return warn('为保护您的账户安全，未启用支付密码时，不支持退款至账户余额，请选择其他退款方式。支付密码可在我的京东-账户安全中开启');
            }else if(rt == 3) {
                var patrn=/[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im;
                var bank = $('#bankSelect').val();
                console.log(bank);
                if(!bank || parseInt(bank,10) < 1) {
                    return warn('请选择您的开户银行');
                }
                var ba = $('#bankAccount').val();
                if(!ba || !$.trim(ba).length) {
                    return warn('请填写开户人姓名');
                }
                if(patrn.test(ba)){
                    return warn("请输入正确的开户人姓名");
                }

                var bn = $('#bankNo').val();
                if(!bn || !$.trim(bn).length) {
                    return warn('请填写您的银行卡号');
                }
                if(patrn.test(bn)){
                    return warn("请输入正确的银行卡号");
                }
                var bankprovince = $('#bankProvince').val();
                if(!bankprovince||bankprovince=='-1') {
                    return warn('请选择省');
                }
                var bankcity =  $('#bankCity').val();
                console.log("bankcity"+bankcity);
                if(!bankcity||bankcity =='-1') {
                    return warn('请选择市');
                }
                var branchBankName =  $('#branchBankName').val();
                if(!branchBankName||!$.trim(branchBankName).length) {
                    return warn('请填写您的银行支行名称');
                }
                if(patrn.test(branchBankName)){
                    return warn("请输入正确的银行支行名称");
                }

            }
            break;
        case 20:
            if(parseInt($('#color').val(),10) == -1) {
                return warn("请选择颜色信息");
            }
            if(parseInt($('#size').val(),10) == -1) {
                return warn("请选择尺寸信息");
            }
            break;
        case 30:
            break;
    }
    if(parseInt($('#haveInvoice').val(),10) == -1) {
        return warn("请选择发票信息");
    }
    if(parseInt($('#haveTestReport').val(),10) == -1) {
        return warn("请选择检测报告信息");
    }
    var desc = $('#questionDesc').val();
    if(!desc || !$.trim(desc)) {
        return warn("请填写问题描述信息");
    }else if($.trim(desc).length > 500) {
        return warn("问题描述请在500字以内")
    }
    return true;
}

/**
 * 拍照回调函数
 * @param img
 */
function cameraCallBack(img) {
    if (!img) {
        return warn('\u4e0a\u4f20\u56fe\u7247\u5931\u8d25');//上传图片失败
    }
    var $pic = $('#hidtxt_questionPic');
    var picsTxt = $pic.val();
    if (picsTxt) {
        var pics = picsTxt.split(",");
        if (pics.length < 3) {
            pics.push(img);
            $pic.val(pics.join(','));
        }
    } else {
        $pic.val(img);
    }
    var $igw = $('#img-wrapper');
    var $imgButton = $('.upload-btn-box');
    if ($igw.find(".img-item").length < 3) {
        var imgNode = "<div class=\"img-item\" data-img=\"" + img + "\"><span><img src=\"" + img + "\"></div>";
        $imgButton.before(imgNode);
        if($igw.find(".img-item").length==3){
            $imgButton.hide();
        }
    } else {
        warn('\u6700\u591a\u652f\u6301\u4e0a\u4f203\u5f20\u56fe\u7247');//最多支持上传3张图片
    }
}

/**
 * 拍照回调函数
 * @param data
 */
function uploadCallBack(data) {
    var img = data.fullUrl,url = data.url;
    if (!img) {
        return warn('\u4e0a\u4f20\u56fe\u7247\u5931\u8d25');//上传图片失败
    }
    var $pic = $('#hidtxt_questionPic');
    var picsTxt = $pic.val();
    if (picsTxt) {
        var pics = picsTxt.split(",");
        if (pics.length < 3) {
            pics.push(url);
            $pic.val(pics.join(','));
        }
    } else {
        $pic.val(url);
    }
    var $igw = $('#img-wrapper');
    var $imgButton = $('.upload-btn-box');
    if ($igw.find(".img-item").length < 3) {
        var imgNode = "<div class=\"img-item\" data-img=\"" + url + "\"><span><img src=\"" + img + "\"></div>";
        $imgButton.before(imgNode);
        if($igw.find(".img-item").length==3){
            $imgButton.hide();
        }
    } else {
        warn('\u6700\u591a\u652f\u6301\u4e0a\u4f203\u5f20\u56fe\u7247');//最多支持上传3张图片
    }
}

