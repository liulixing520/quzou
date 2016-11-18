
<div class="wrap2">
	<div class="filter_info">
        <ul class="fi_choose" style="width: 82%;float: left;">
        	<#if "${(parameters.SEARCH_CATEGORY_ID)!}"!="BEAUTYROOTCONSUME">
            <li>
                <span class="filterSequence">
                    <span class="label" onclick="showOrderBy('SortProductField:introductionDate');">新品</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>

            <li>
                <span class="filterSequence">
                    <span class="label" onclick="showOrderBy('SortProductField:totalTimesViewed');">人气</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>

            <li>
                <span class="filterSequence">
                    <span class="label" onclick="showOrderBy('SortProductField:totalQuantityOrdered');">销量</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>
            </#if>
            <#--V1.0不上此功能  modify by Ansen
            <li>
                <span class="label">价格：</span>
                <div class="filterPrice">
                    <div class="fp_box">
                        <div class="fp_enter">
                            <span class="fpStart fp_items">
                                <input type="text" class="inp-text minPrice" data-value="¥" />
                            </span>

                            <span class="fp_line">-</span>

                            <span class="fpEnd fp_items">
                                <input type="text" class="inp-text maxPrice" data-value="¥" />
                            </span>
                        </div>

                        <div class="fp_expand">
                            <a href="javascript:" class="btn sm btn-default">清空</a>
                            <a href="javascript:" class="btn sm btn-success">确定</a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <span class="label">上架时间：</span>
                <input type="text" id="upshelvestime" class="reservationtime" />
            </li>
             -->
        </ul>
       <#--后期添加之功能，暂先注释，勿删除-->
       <#-- <ul class="viewChangeList fl">
        	<li class="current">
            	<a href="findProduct">
                	<span class="iconfont">&#xe60e;</span>
                </a>
            </li>
            <li>
            	<a href="findProductList">
                	<span class="iconfont">&#xe60f;</span>
                </a>
            </li>
        </ul>-->
        <#-- V1.0不上此功能  modify by Ansen
        <div class="fi_search_btn" style="margin-top: 5px;"><a href="javascript:" onclick="showForm()" class="btn mm btn-confirm">查询</a></div>
        -->
    </div>
</div>

<script type="text/javascript">
	$(function(){
		setTimeout(function(){
			$('#upshelvestime').daterangepicker({
				timePicker: true,
				timePickerIncrement: 1,
				format: 'YYYY/MM/DD H:mm',
				showDropdowns:true
			});
		}, 500);
	});
</script>
