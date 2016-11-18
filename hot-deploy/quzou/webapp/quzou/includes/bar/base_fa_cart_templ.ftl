<span class="gwc_target target table">
	<div class="title"><i>新建方案</i><a href="#" class="num bgcor-red fanganNum">${(sessionAttributes.fanganList?size)?default(0)!}</a></div>
	<div class="temporary_bar gwcModule">
		<form name="addFangan" id="addFangan" method="post" action="addBaseAndCreateFangan">
			<input type="hidden" name="primaryProductCategoryId" value="BEAUTY_FANGAN"/>
			<div class="t_b_tip"><input type="text" id="newScheme" name="productName" class="inp-text" data-value="新建方案" /></div>
		</form>
		<div>
			<dl>
				<dt>
					<span style="width: 5%;text-align:center;"><#--<input type="checkbox" class="checkAll mt12" data-name="18"  />--></span>
					<span style="width: 27%;">商品名称</span>
					<span style="width: 18%;">价格</span>
					<span style="width: 14%;">数量</span>
					<span style="width: 14%;">折扣</span>
					<span style="width: 17%;">折后价格</span>
				</dt>
			</dl>
		</div>
		<div id="barListContentInfor2" class="" style="height:260px;overflow-y:auto;">
			<#if sessionAttributes.fanganList?has_content>
				<#list sessionAttributes.fanganList as item>
					<dl id="fangan_${(item.getProductId())!}" <#if "${(item.getIszengsong())!}"=="Y">class="rowSelected"</#if>>
						<dd>
							<span style="width: 5%;text-align:center;" class="productId">
							<input type="checkbox" class="checkItem mt12" title="${(item.getIszengsong())!}" <#if "${(item.getIszengsong())!}"=="Y">checked="checked"</#if> data-name="18" name="fanganId" value="${(item.getProductId())!}"/>
							</span>
							<span style="width: 27%;" class="productNameSet" title="${(item.getProductName())!}">${(item.getProductName())!}</span>
							<span class="rightbar productBasePrice" style="width: 18%;">${(item.getDefaultPrice())!}</span>
							<span class="rightbar productNumber" style="width: 14%;">
								<input class="barInputUpdate inp-text" style="width:30px;" type="text" value="${(item.getQuantity())!}" />
							</span>
							<span class="rightbar productDiscount" productid="${(item.getProductId())!}" style="width: 14%;">1</span>
							<span class="rightbar productDisPrice" style="width: 17%;">
								<input class="barInputUpdate inp-text" type="text" value="${(item.getDefaultPrice())!}" />
							</span>
						   <!-- <span class="t_b_del out out_right" onclick="removeCart('${(item.getProductId())!}','removeCartFangan')"><b class="iconfont"></b></span>-->
						</dd>
					</dl>
				</#list>
			</#if>
		</div>
		<div class="table_control mt5" style="display:none;height:30px;">
			<div class="t_c_inp">
				<input type="checkbox" data-name="18" id="checkAll" class="checkAll mt5 ml3">
			</div>
			<div class="t_c_btn">
				<span style="cursor:pointer;"  class="btn mm btn-default" trigger="give_all">赠送</span>
				<span style="cursor:pointer;" onclick="removeFanganItemAll();" class="btn mm btn-default">删除</span>
			</div>
		</div>
		<div class="temporary_remind" data-text="您还没有添加任何产品！">您还没有添加任何产品！</div>

		<div class="t_b_control"><a href="javascript:" onclick="updateFangAn()" class="btn btn-addcart">新建方案</a></div>
	</div>
</span>
