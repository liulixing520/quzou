<body style="background:#eaeaea;">
<div class="qzfwxq_div">
    <span>${(entity.showTitle)!}</span>
</div>     
<div class="qzfwxq_all">         
    <div class="qzfwxq_list_center">
        <img src="/quzou/upload/${(entity.showPic)!}" />
    </div> 
    <div class="qzfwxq_div_bottom">
        <p style="padding-top: 10px">
        	${StringUtil.wrapString(entity.detailContent)}
        </p>
    </div>       
</div>
