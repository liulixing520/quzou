(function (window) {
    function review() {
    }

    review.show_review_pop = function (pid, orderid, callback) {
        var content_obj = $("#review_pop_" + orderid + pid);

        if (content_obj.attr("data-is-get") !== "yes") {

            $.ajax({
                type: 'post',
                dataType: 'json',
                url: "/Review/getReviewPidOid",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {product_id: pid, order_id: orderid},
                success: function (returnData) {

                    if (returnData.flag > 0) {
                        var review_content_list = returnData.list;
                        var image_server = $("#image_server").val();

                        var review_content = review_content_list[0].comment;
                        var review_create_time = review_content_list[0].creation_time;
                        var _score = review_content_list[0].score;



                        //评论图片
                        var image_list = "";
                        content_obj.find(".review_img_list").empty();
                        //$.each(review_content_list, function (idx, item) {
                        //image_list += "<img style='max-width:150px;' class='one_pic review_img' src='" + image_server + item.url + "' />";
                        //});
                        if (review_content_list[0].url != null && review_content_list[0].url.length > 10)
                            image_list = "<img style='max-width:150px;' class='one_pic review_img' src='" + image_server + review_content_list[0].url + "' />";

                        if (image_list == "") {
                            content_obj.find(".review_img_list").next().removeClass("one_pic_right").addClass("no_pic");
                            content_obj.find(".review_img_list").remove();//无图片
                        }
                        else
                            content_obj.find(".review_img_list").html(image_list);//评论图

                        //创建时间
                        content_obj.find(".comment_msg_box_time").find("span:eq(0)").html(review_create_time.split(" ")[0]);


                        //笑脸
                        content_obj.find(".comment_msg_box_xx").empty();
                        var _score_html = ""
                        if (_score) {
                            _score_html = '<img alt="" src="/Public/images/mychunbo/xl_2.png" />';
                        }
                        content_obj.find(".comment_msg_box_xx").append(_score_html);//笑脸
                        content_obj.find(".comment_msg_box_xx").append(review_content);//评论内容

                        //标注选中状态
                        content_obj.attr("data-is-get", "yes");

                        if (typeof (callback) == 'function')
                            callback();
                    }

                }
            });

        }
        else
        {
            if (typeof (callback) == 'function')
                callback();
        }

    }

    window.Review = review;

})(window);

