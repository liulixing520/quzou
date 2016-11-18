//�����̶�
$.fn.floatNav = function floatNav( options ) {
        var settings = $.extend({
            start:             null,                // ���������߶�
            end:             null,                // ���ƽ����߶�
            fixedClass:     null,        // ����״̬class
            anchor:         null,                // ��������״̬�ڲ�����ê��
            targetEle:         null,                // ҳ�滬����Ŀ��Ԫ��ʱ���ظ�������
            range:            0                   // ������ʧ��Ӧ��Χ
        }, options);

        var that = $(this),
            navHeight = that.height(),
            navWidth = that.width(),
            wrapDiv = $('<div class="sift-tab"/>');

        // ��ֹ����
        that.css({
            height: navHeight,
            width: navWidth
        });
        if ( !that.parent().hasClass('sift-tab') ) {
            that.wrap( wrapDiv.css('height', navHeight) );
        }

        $(window).bind('scroll', function() {
            var docTop = $(document).scrollTop(),
                start = settings.start || that.parent('.sift-tab').offset().top,
                targetTop = settings.targetEle ? $(settings.targetEle).offset().top : 10000;
            if ( docTop > start && docTop < ( settings.end || targetTop ) - settings.range ) {
                 that.addClass(settings.fixedClass);
            } else {
                that.removeClass(settings.fixedClass);
            }
        });
        return this;
    }