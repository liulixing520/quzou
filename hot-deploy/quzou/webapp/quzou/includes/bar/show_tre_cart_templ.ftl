<#--自定义疗程模版 -->
<span class="lc_target target table">
	<div class="title"><i>自定义疗程</i><a href="#" class="num bgcor-blue treatNum">${(sessionAttributes.treatList?size)?default(0)!}</a></div>
	<div class="temporary_bar lcModule item">
	<form name="addTreatment" id="addTreatment" method="post" action="addCartAndCreateTreat">
		<input type="hidden" name="notCreatePrimary" value="Y"/>
		<input type="hidden" name="primaryProductCategoryId" value="BEAUTY_TREATMENT"/>
		<div class="t_b_tip"><input type="text" name="productName" id="liaocmc" class="inp-text" data-value="自定义疗程" /></div>
	</form>
		<div>
			<dl class="moveClone">
				<dt>
					<span style="width: 5%;text-align:center;"> <#--<input type="checkbox" class="checkAll mt12" data-name="17"  />--></span>
					<span style="width: 27%;">商品名称</span>
					<span style="width: 18%;">价格</span>
					<span style="width: 14%;">数量</span>
					<span style="width: 14%;">折扣</span>
					<span style="width: 17%;">折后价格</span>
				</dt>
			</dl>
		</div>
		<div id="barListContentInfor" style="position:relative;height:260px;overflow-y:auto;" class="" >
			<#if sessionAttributes.treatList?has_content>
				<#list sessionAttributes.treatList as item>
					<dl id="treat_${(item.getProductId())!}" <#if "${(item.getIszengsong())!}"=="Y">class="rowSelected"</#if>>
						<dd>
							<span style="width: 5%;text-align:center;" class="productId">
							<input type="checkbox" class="checkItem mt12" title="${(item.getIszengsong())!}" <#if "${(item.getIszengsong())!}"=="Y">checked="checked"</#if> data-name="17" name="treatId" value="${(item.getProductId())!}" /></span>
							<span style="width: 27%;" class="productNameSet" title="${(item.getProductName())!}">${(item.getProductName())!}</span>
							<span class="rightbar productBasePrice" style="width: 18%;">${(item.getDefaultPrice())!}</span>
							<span class="rightbar productNumber" style="width: 14%;">
								<input class="barInputUpdate inp-text" style="width:30px;" type="text" value="${(item.getQuantity())!}" />
							</span>
							<span class="rightbar productDiscount" productid="${(item.getProductId())!}" style="width: 14%;">1</span>
							<span class="rightbar productDisPrice" style="width: 17%;">
								<input class="barInputUpdate inp-text" type="text" value="${(item.getDefaultPrice())!}" />
							</span>
						</dd>
					</dl>
				</#list>
			</#if>
			<div class="table_control">
				<div style="float:right;margin-right:40px;margin-top:10px;" id="zslchj"></div>
				<div style="float:right;margin-right:40px;margin-top:10px;" id="lchj"></div>
			</div>
		</div>
		<div class="table_control mt5" style="height:30px;">
			<div class="t_c_inp">
				<input type="checkbox" data-name="17" id="checkAll"  value="Y" class="checkAll mt5 ml3">
			</div>
			<div class="t_c_btn">
				<span style="cursor:pointer;"  class="btn mm btn-default" trigger="give_all">赠送</span>
				<span style="cursor:pointer;" onclick="removeTreatItemAll();" class="btn mm btn-default">删除</span>
			</div>
		</div>
	<div class="temporary_remind" data-text="您还没有添加任何疗程！">您还没有添加任何疗程！</div>

	<div class="t_b_control">
		<#if security.hasPermission("PCPOS_Cart", session)>
			<a href="javascript:" onclick="updateCartTreatment()" class="btn btn-addcart">加入购物车</a>
		</#if>
	</div>
</div>
</span>
	<script>
		/*
		 * 赠送部分代码
		*/
		$(function(){
			//------发送赠送状态
			function ajaxPost(productId,state){
				$.post("addJsonCartTreatment",{productId: productId, quantity: 0, isType: "add",iszengsong:state});
			}

			//------赠送
			function give(checkbox){
				var row 	  = checkbox.closest("dl");
				var productId = checkbox.val();

				if(row.hasClass("rowSelected")){
					return;
				}
				checkbox.attr("title","Y");
				row.addClass("rowSelected");

				ajaxPost(productId,"Y");
				barlczj();
			}

			//------取消赠送
			function cancel_give(checkbox){
				var row 	  = checkbox.closest("dl");
				var productId = checkbox.val();

				if(!row.hasClass("rowSelected")){
					return;
				}
				if(checkbox.is(":checked")){
					checkbox.attr({
						checked:"false"
					});
				}
				checkbox.attr({
					title:"N"
				});
				row.removeClass("rowSelected");
				ajaxPost(productId,"N");
				barlczj();
			}

			//------赠送所有勾选的
			function give_all(){
				$("#barListContentInfor dd > .productId > input").each(function(){
					var checkbox   = $(this);
					var checkState = checkbox.is(":checked");

					if(checkState === true){
						give(checkbox);
					}
				});
				barlczj();
			}

			//------取消所有勾选赠送
			function cancel_give_all(){
				$("#barListContentInfor dd > .productId > input").each(function(){
					var checkbox   = $(this);
					var checkState = checkbox.is(":checked");

					cancel_give(checkbox);
				});
				barlczj();
			}

			//------赠送按钮点击
			$("body").on("click","[trigger='give_all']",function(){
				give_all();
				barlczj();
			});

			//------取消勾选按钮点击
			$("body").on("click","#checkAll",function(){
				var checkbox = $(this);

				if(checkbox.is(":checked") == false){
					cancel_give_all();
				}
				barlczj();
			});

			//------单个勾选按钮点击
			$("body").on("click","#barListContentInfor dd > .productId > input",function(){
				var checkbox   = $(this);
				var checkState = checkbox.is(":checked");

				if(checkState === false){
					cancel_give(checkbox);
				}
				barlczj();
			});
		});


	</script>
