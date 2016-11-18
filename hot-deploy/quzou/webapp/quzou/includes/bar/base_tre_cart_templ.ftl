<span class="lc_target target table">
	<div class="title"><i>新建疗程</i><a href="#" class="num bgcor-blue treatNum">${(sessionAttributes.treatList?size)?default(0)!}</a></div>
	<div class="temporary_bar lcModule item">
	<form name="addTreatment" id="addTreatment" method="post" action="addBaseAndCreateTreat">
		<input type="hidden" name="primaryProductCategoryId" value="BEAUTY_TREATMENT"/>
		<div class="t_b_tip"><input type="text" id="newTreatment" name="productName" class="inp-text" data-value="新建疗程" /></div>
	</form>
		<div>
			<dl class="moveClone">
				<dt>
					<span style="width: 5%;text-align:center;"><#--<input type="checkbox" class="checkAll mt12" data-name="17"  />--></span>
					<span style="width: 27%;">商品名称</span>
					<span style="width: 18%;">价格</span>
					<span style="width: 14%;">数量</span>
					<span style="width: 14%;">折扣</span>
					<span style="width: 17%;">折后价格</span>
				</dt>
			</dl>
		</div>
		<div id="barListContentInfor" class="" style="height:260px;overflow-y:auto;">
			<#if sessionAttributes.treatList?has_content>
				<#list sessionAttributes.treatList as item>
				 <dl id="treat_${(item.getProductId())!}"  <#if "${(item.getIszengsong())!}"=="Y">class="rowSelected"</#if>>
					<dd>
						<span style="width: 5%;text-align:center;" class="productId">
						<input type="checkbox" class="checkItem mt12" title="${(item.getIszengsong())!}" data-name="17" <#if "${(item.getIszengsong())!}"=="Y">checked="checked"</#if> name="treatId" value="${(item.getProductId())!}"/>
						</span>
						<span style="width: 27%;" class="productNameSet" title="${(item.getProductName())!}">${(item.getProductName())!}</span>
						<span class="productBasePrice" style="width: 18%;">${(item.getDefaultPrice())!}</span>
						<span class="productNumber" style="width: 14%;">
							<input class="barInputUpdate inp-text" style="width:30px" type="text" value="${(item.getQuantity())!}" />
						</span>
						<span class="productDiscount" productid="${(item.getProductId())!}" style="width: 14%;">1</span>
						<span class="productDisPrice" style="width: 17%;">
							<input class="barInputUpdate inp-text" type="text" value="${(item.getDefaultPrice())!}" />
						</span>
					</dd>
				</dl>
				</#list>
			</#if>
		  </div>
		  <div class="table_control mt5" style="display:none;height:30px;">
				<div class="t_c_inp">
					<input type="checkbox" data-name="17" id="checkAll" class="checkAll mt5 ml3">
				</div>
				<div class="t_c_btn">
					<span style="cursor:pointer;"  class="btn mm btn-default" trigger="give_all">赠送</span>
					<span style="cursor:pointer;" onclick="removeTreatItemAll();" class="btn mm btn-default">删除</span>
				</div>
		 </div>
		<div class="temporary_remind" data-text="您还没有添加任何产品！">您还没有添加任何产品！</div>

		<div class="t_b_control"><a href="javascript:" onclick="updateCartTreatment()" class="btn btn-addcart">新建疗程</a></div>
	</div>
</span>
