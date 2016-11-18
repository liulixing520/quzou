function checkTime(i) {
    if (i < 10) {
        i = "0" + i
    }
    return i
}
/**
 * 日期转换
 * @param date
 * @returns {string}
 */
function formatDateTime(date) {
    var formatDate = "";
    var y = date.getFullYear();
    var n = (date.getMonth() + 1 > 12) ? 12 : date.getMonth() + 1;
    var d = date.getDate();
    var h = date.getHours();
    var m = date.getMinutes();
    var s = date.getSeconds();
    m = checkTime(m)
    s = checkTime(s)
    return y + "-" + n + "-" + d + " " + h + ":" + m + ":" + s;
}
/**
 * 订单状态转换
 * @param orderState
 * @returns {string}
 */
function orderStateEnumChange(orderState) {
    if (orderState == 0) {
        return "新订单";
    } else if (orderState == 1) {
        return "等待付款";
    } else if (orderState == 2) {
        return "等待付款确认";
    } else if (orderState == 3) {
        return "延迟付款确认";
    } else if (orderState == 4) {
        return "暂停";
    } else if (orderState == 5) {
        return "店长最终审核";
    } else if (orderState == 6) {
        return "等待打印";
    } else if (orderState == 7) {
        return "等待出库";
    } else if (orderState == 8) {
        return "等待打包";
    } else if (orderState == 9) {
        return "等待发货";
    } else if (orderState == 10) {
        return "自提途中";
    } else if (orderState == 11) {
        return "上门提货";
    } else if (orderState == 12) {
        return "自提退货";
    } else if (orderState == 13) {
        return "确认自提";
    } else if (orderState == 15) {
        return "等待确认收货";
    } else if (orderState == 16) {
        return "配送退货";
    } else if (orderState == 18) {
        return "完成";
    } else if (orderState == 20) {
        return "收款确认";
    } else if (orderState == 21) {
        return "锁定";
    } else if (orderState == 22) {
        return "等待退款";
    } else if (orderState == 23) {
        return "等待客户回复";
    } else if (orderState == 28) {
        return "等待三方出库";
    } else if (orderState == 29) {
        return "等待三方发货";
    } else if (orderState == 30) {
        return "等待三方发货完成";
    } else if (orderState == -1) {
        return "未知";
    }
}