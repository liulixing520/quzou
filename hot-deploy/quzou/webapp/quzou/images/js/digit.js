var Digit = {};
/**
 * 四舍五入法截取一个小数
 * @param float digit 要格式化的数字
 * @param integer length 要保留的小数位数
 * @return float
 */
Digit.round = function(digit, length) {
    length = length ? parseInt(length) : 0;
    if (length <= 0) return Math.round(digit);
    digit = Math.round(digit * Math.pow(10, length)) / Math.pow(10, length);
    return digit;
};
/**
 * 舍去法截取一个小数
 * @param float digit 要格式化的数字
 * @param integer length 要保留的小数位数
 * @return float
 */
Digit.floor = function(digit, length) {
    length = length ? parseInt(length) : 0;
    if (length <= 0) return Math.floor(digit);
    digit = Math.floor(digit * Math.pow(10, length)) / Math.pow(10, length);
    return digit;
};
/**
 * 进一法截取一个小数
 * @param float digit 要格式化的数字
 * @param integer length 要保留的小数位数
 * @return float
 */
Digit.ceil = function(digit, length) {
    length = length ? parseInt(length) : 0;
    if (length <= 0) return Math.ceil(digit);
    digit = Math.ceil(digit * Math.pow(10, length)) / Math.pow(10, length);
    return digit;
};
Digit.percentage = function(source,target){
	return Digit.round((source-target)/(target==0?1:target)*100,2);
};

/**
 * 求百分比
 * @param float numerator 分子
 * @param float denominator 分母
 * @return float
 */
Digit.percentage2 = function(numerator ,denominator ){
    return Digit.round(numerator /(denominator==0?1:denominator)*100,2);
};
 /*
// 使用方法
var num = 1.23456;
//四色五入保留2位小数
Digit.round(num, 2);
//舍去法保留2位小数
Digit.floor(num, 2);
//进一法保留2位小数
Digit.ceil(num, 2);
*/
