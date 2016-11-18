<div class="wrap">
	<div class="filter_info">
        <ul class="filter_form">
        	<li class="col_form">
            	<label class="ff_label">姓名</label>
                
            	<div class="filter_select filterSelect" data-info='{"type":"select", "id":"brand"}'>
                    <input type="text" class="inp-text fs_inp fsInp" data-value="品牌" />
                    <a href="javascript:" class="fs_btn fsBtn"><b class="iconfont">&#xe602;</b></a> <!--&#xe607;-->
                </div>
            </li>
            
            <li class="col_form">
            	<label class="ff_label">会员名</label>
                
            	<div class="filter_select filterSelect" data-info='{"type":"list", "id":"purchaseMan"}'>
                    <input type="text" class="inp-text fs_inp fsInp" data-value="进货人" />
                    <a href="javascript:" class="fs_btn fsBtn"><b class="iconfont">&#xe602;</b></a> <!--&#xe607;-->
                </div>
            </li>
            
            <li class="col_form">
            	<label class="ff_label">交易所在店</label>
                
            	<div class="filter_select filterSelect" data-info='{"type":"select", "id":"adress"}'>
                    <input type="text" class="inp-text fs_inp fsInp" data-value="地址" />
                    <a href="javascript:" class="fs_btn fsBtn"><b class="iconfont">&#xe602;</b></a> <!--&#xe607;-->
                </div>
            </li>
            
            <li class="col_form">
            	<label class="ff_label">日期</label>
                
            	<input type="text" class="inp-text ff_calendar" id="reservationtime" />
            </li>
        </ul>
        
        <div class="fi_search_btn"><a href="javascript:" class="btn mm btn-confirm">查询</a></div>
    </div>
    
	<div class="filter_info merge">
        <ul class="fi_choose">
            <li>
                <span class="filterSequence">
                    <span class="label">新品</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>
            
            <li>
                <span class="filterSequence">
                    <span class="label">人气</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>
            
            <li>
                <span class="filterSequence">
                    <span class="label">销量</span>
                    <b class="iconfont">&#xe606;</b>
                </span>
            </li>
            
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
        </ul>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		setTimeout(function(){ /*js load延迟问题，套程序时删除定时*/
			var filterData = {
								"brand": ["品牌1","品牌2","品牌3","品牌4","品牌5","品牌6","品牌7","品牌1","品牌2","品牌3","品牌4","品牌5","品牌6","品牌7"],
								"purchaseMan": ["邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥","邱伟","本坤","钱敏","小卷","发哥"],
								"adress": ["广东","深圳","上海","北京"]
							 };
			
			$(".filterSelect").each(function() {
				var info = $(this).data("info");
				$(this).filterSelect(filterData, info);
			});
			
			$('#reservationtime').daterangepicker({
				timePicker: false,
				timePickerIncrement: 1,
				format: 'YYYY/MM/DD',
				singleDatePicker: true,
				showDropdowns:true
			});
			
			$('#upshelvestime').daterangepicker({
				timePicker: true,
				timePickerIncrement: 1,
				format: 'YYYY/MM/DD H:mm',
				showDropdowns:true
			});
		}, 200);
	});
</script>