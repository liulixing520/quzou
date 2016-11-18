<#assign actionUrlStr="createProductStore">
<#if productStore?has_content>
	<#assign actionUrlStr="updateProductStore">
</#if>
<form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" id="EditProductStore" class="basic-form" onsubmit="javascript:submitFormDisableSubmits(this)" name="EditProductStore" novalidate="novalidate">
  <input type="hidden" name="productStoreId" id="EditProductStore_productStoreId"  value="${(productStore.productStoreId)!}">
  <input type="hidden" name="oldStyleSheet" id="EditProductStore_oldStyleSheet" value="${(productStore.styleSheet)!}">
  <input type="hidden" name="oldHeaderLogo" id="EditProductStore_oldHeaderLogo" value="${(productStore.headerLogo)!}">
  <input type="hidden" name="oldHeaderMiddleBackground" id="EditProductStore_oldHeaderMiddleBackground" value="${(productStore.headerMiddleBackground)!}">
  <input type="hidden" name="oldHeaderRightBackground" id="EditProductStore_oldHeaderRightBackground" value="${(productStore.headerRightBackground)!}">
  <div class="fieldgroup" id="_G3_">
    <div class="fieldgroup-title-bar">
        
    </div>
    <div id="_G3__body" class="fieldgroup-body">
  <table cellspacing="0" class="basic-table">
  <tbody>
  <tr style="display: none;">
  <td class="label">
<span title="这个店铺属于哪个组。多个店铺能够编成组，每个店铺组使用同一个价格。如果没有设置店铺组，则不填。" id="EditProductStore_primaryStoreGroupId_title">主要店铺组标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="primaryStoreGroupId" id="EditProductStore_primaryStoreGroupId" size="1">              <option value="">&nbsp;</option>
          <option value="_NA_">不可用 [_NA_]</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="这是这个目录所代表的店铺的名称。" id="EditProductStore_storeName_title">店铺名称</span>  </td>
  <td>
<input type="text" name="storeName" class="required" size="30" maxlength="100" id="EditProductStore_storeName" value="${(productStore.storeName)!}">  
  <span class="tooltip">必须的</span>
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="这个值会显示在电子商务店铺的页眉部分。" id="EditProductStore_title_title">标题</span>  </td>
  <td>
<input type="text" name="title" size="30" maxlength="100" id="EditProductStore_title" value="${(productStore.title)!}">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="这个值会显示在电子商务店铺的页眉部分。" id="EditProductStore_subtitle_title">副标题</span>  </td>
  <td>
<input type="text" name="subtitle" size="60" maxlength="250" id="EditProductStore_subtitle" value="${(productStore.subtitle)!}">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span  title="这个这个目录所代表的公司的名称。" id="EditProductStore_companyName_title">公司名称</span>  </td>
  <td>
<input type="text" name="companyName" size="40" maxlength="60" id="EditProductStore_companyName" autocomplete="off" value="${(productStore.companyName)!}">  
  
  </td>
  </tr>
  <tr style="display: none;">
  <td class="label">
<span title="如果是，则不会发送任何新建的订单，也不会对信用卡收费等。" id="EditProductStore_isDemoStore_title">是演示店铺吗</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="isDemoStore" id="EditProductStore_isDemoStore" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr style="display: none;">
  <td class="label">
<span title="用于控制一个网店的外观感受。" id="EditProductStore_visualThemeId_title">视觉风格</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="visualThemeId" id="EditProductStore_visualThemeId" size="1">      
        <option selected="selected" value="FLAT_GREY">FLAT_GREY</option>        <option value="FLAT_GREY">---</option>        <option value="">&nbsp;</option>
          <option value="EC_DEFAULT">EC_DEFAULT - OFBiz Ecommerce Standard Floating Layout</option>          <option value="MULTIFLEX">MULTIFLEX - 电子商务的替代视觉风格</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G5_"  style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G5__body', '展开', '合拢');" title="展开">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库存</a>
          </li>
        </ul>
    </div>
    <div id="_G5__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="这是库存水平数据的来源。" id="EditProductStore_inventoryFacilityId_title">库存场所标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="inventoryFacilityId" id="EditProductStore_inventoryFacilityId" size="1">              <option value="">&nbsp;</option>
          <option value="WebStoreWarehouse">Web Store Warehouse [WebStoreWarehouse]</option>          <option value="10000">总仓库2 [10000]</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果这是一个'单一的库存'场所。对较新的或复杂度较低的业务，你会发现单一的库存概念更容易使用。" id="EditProductStore_oneInventoryFacility_title">一个库存场所</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="oneInventoryFacility" id="EditProductStore_oneInventoryFacility" size="1" class="valid">              <option value="">&nbsp;</option>
          <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是，则会在OFBiz中通过系统生成过程立即执行（如POS销售）。如果否，则会等待人工检查。" id="EditProductStore_isImmediatelyFulfilled_title">立即执行吗</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="isImmediatelyFulfilled" id="EditProductStore_isImmediatelyFulfilled" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="这会决定在处理订单时，系统是否检查库存水平。" id="EditProductStore_checkInventory_title">检查库存</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="checkInventory" id="EditProductStore_checkInventory" size="1" class="valid">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果手头库存不足，当这个标志设置为是时，将不再处理订单。" id="EditProductStore_requireInventory_title">需要库存</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="requireInventory" id="EditProductStore_requireInventory" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="指向仓库存货水平触发程序。" id="EditProductStore_requirementMethodEnumId_title">需求方法枚举标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="requirementMethodEnumId" id="EditProductStore_requirementMethodEnumId" size="1">              <option value="">&nbsp;</option>
          <option value="PRODRQM_NONE">没有已创建的请求</option>          <option value="PRODRQM_AUTO">对每个销售定单自动</option>          <option value="PRODRQM_STOCK">当现货数量达到最小库存时</option>          <option value="PRODRQM_STOCK_ATP">当承诺数量达到最小库存时</option>          <option value="PRODRQM_ATP">当承诺提供数量达到产品-场所的最小存货时的需求订单</option>          <option value="PRODRQM_DS">仅直接送货</option>          <option value="PRODRQM_DSATP">在低数量时自动直接送货</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="导致为店铺订单明细保留库存。可能手头还有库存，但是不再能用于其它订单了。" id="EditProductStore_reserveInventory_title">预订库存</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="reserveInventory" id="EditProductStore_reserveInventory" size="1" class="valid">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="选择怎样预留库存。" id="EditProductStore_reserveOrderEnumId_title">预订订单枚举标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="reserveOrderEnumId" id="EditProductStore_reserveOrderEnumId" size="1">              <option value="">&nbsp;</option>
          <option value="INVRO_FIFO_EXP">先入先出过期</option>          <option value="INVRO_FIFO_REC">先入先出收讫的</option>          <option value="INVRO_GUNIT_COST">较大的单位费用</option>          <option value="INVRO_LUNIT_COST">较小的单位费用</option>          <option value="INVRO_LIFO_EXP">后入先出过期</option>          <option value="INVRO_LIFO_REC">后入先出收讫的</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设置为是（Y），当为缺货商品新建一个销售订单时，那么会按照最晚送货日期（shipBeforeDate）指定的优先级来重新分配预留的场所/商品。" id="EditProductStore_balanceResOnOrderCreation_title">订单创建时平衡预订</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="balanceResOnOrderCreation" id="EditProductStore_balanceResOnOrderCreation" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果否（N），则不在站点上显示缺货商品" id="EditProductStore_showOutOfStockProducts_title">显示缺货商品</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="showOutOfStockProducts" id="EditProductStore_showOutOfStockProducts" size="1">                <option value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span id="EditProductStore_managedByLot_title">批次管理</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="managedByLot" id="EditProductStore_managedByLot" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G7_"  style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G7__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购物车</a>
          </li>
        </ul>
    </div>
    <div id="_G7__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="控制当向购物车添加了商品后，是否把用户立即转到购物车。" id="EditProductStore_viewCartOnAdd_title">添加时浏览购物车</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="viewCartOnAdd" id="EditProductStore_viewCartOnAdd" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="自动保存购物车内容问题的是/否（Y/N）选项的下拉框。" id="EditProductStore_autoSaveCart_title">自动保存购物车</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoSaveCart" id="EditProductStore_autoSaveCart" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是（Y），那么在添加到购物车时，会删除购物车中产品关联（ProductAssoc）记录关联自的、并且具有产品升级（PRODUCT_UPGRADE）类型的全部产品。" id="EditProductStore_addToCartReplaceUpsell_title">添加到购物车用升级产品替代</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="addToCartReplaceUpsell" id="EditProductStore_addToCartReplaceUpsell" size="0">                <option value="Y">Y</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为是（Y），那么在添加到购物车时，会删除购物车中产品关联（ProductAssoc）记录关联到的或关联自的、并且具有产品不兼容（PRODUCT_INCOMPATABLE）类型的全部产品。" id="EditProductStore_addToCartRemoveIncompat_title">添加到购物车去除不兼容产品</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="addToCartRemoveIncompat" id="EditProductStore_addToCartRemoveIncompat" size="0">                <option value="Y">Y</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为否（N），在结账时不显示与礼品（'是礼品'和'礼品信息'选项）相关的选项。" id="EditProductStore_showCheckoutGiftOptions_title">显示校验礼品选项</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="showCheckoutGiftOptions" id="EditProductStore_showCheckoutGiftOptions" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设置为是（Y），对店铺所有的商品搜索都会附加一个 isVariant!=Y（不是变型）的限制。" id="EditProductStore_prodSearchExcludeVariants_title">产品搜索不包括多样化产品</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="prodSearchExcludeVariants" id="EditProductStore_prodSearchExcludeVariants" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span id="EditProductStore_orderDecimalQuantity_title">允许订单数量有小数</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="orderDecimalQuantity" id="EditProductStore_orderDecimalQuantity" size="1">              <option value="">&nbsp;</option>
          <option value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  <span class="tooltip">可以按产品来定义是否允许小数数量订单</span>
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G9_"  style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G9__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运输</a>
          </li>
        </ul>
    </div>
    <div id="_G9__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="当送货成本的一部分由一个账户而不是记账账户支付时。" id="EditProductStore_prorateShipping_title">按比例分配送货</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="prorateShipping" id="EditProductStore_prorateShipping" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="数字产品明细必须有送货地址？注意：这仅在购物车中只有数字商品时有效。" id="EditProductStore_reqShipAddrForDigItems_title">需要数字产品明细的送货地址</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="reqShipAddrForDigItems" id="EditProductStore_reqShipAddrForDigItems" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是，允许客户为一些订单明细使用一种支付类型，为其它的明细使用另一种支付类型。" id="EditProductStore_selectPaymentTypePerItem_title">为每个明细选择支付类型</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="selectPaymentTypePerItem" id="EditProductStore_selectPaymentTypePerItem" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果否（N），如果信用卡捕获失败，捕获订单支付（captureOrderPayments）会导致一个服务错误。" id="EditProductStore_shipIfCaptureFails_title">如果捕获失败装运吗</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="shipIfCaptureFails" id="EditProductStore_shipIfCaptureFails" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是（Y），那么在存储订单之前，订单支付设置（OrderPaymentPreference）记录会被拆分，每个订单明细送货组（OrderItemShipGroup）一条记录。" id="EditProductStore_splitPayPrefPerShpGrp_title">把付款分拆给每个运输组</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="splitPayPrefPerShpGrp" id="EditProductStore_splitPayPrefPerShpGrp" size="0">                <option value="Y">Y</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G11_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G11__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支付</a>
          </li>
        </ul>
    </div>
    <div id="_G11__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="注意：这与把总账交易过账到的那个组织会员标识（organizationPartyId）有关。" id="EditProductStore_payToPartyId_title">支付给会员标识</span>  </td>
  <td>
  <!-- @renderLookupField -->
    <script type="text/javascript">
      jQuery(document).ready(function(){
        if (!jQuery('form[name="EditProductStore"]').length) {
          alert("Developer: for lookups to work you must provide a form name!")
        }
      });
    </script>
  <span class="field-lookup">
      <div id="3_lookupId_EditProductStore_payToPartyId_auto"></div><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span><input type="text" name="payToPartyId" size="25" id="3_lookupId_EditProductStore_payToPartyId" class="ui-autocomplete-input" autocomplete="off">
      <script type="text/javascript">
        jQuery(document).ready(function(){
          var options = {
            requestUrl : "LookupPartyName",
            inputFieldId : "EditProductStore_payToPartyId",
            dialogTarget : document.EditProductStore.payToPartyId,
            dialogOptionalTarget : null,
            formName : "EditProductStore",
            width : "",
            height : "",
            position : "topleft",
            modal : "true",
            ajaxUrl : "EditProductStore_payToPartyId,/catalog/control/LookupPartyName,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStore&amp;searchValueFieldName=payToPartyId",
            showDescription : "true",
            presentation : "layer",
            defaultMinLength : "2",
            defaultDelay : "300",
            args :
[]
          };
          new Lookup(options).init();
        });
      </script>
  <a href="javascript:void(0);" id="3_lookupId_button"></a></span>
  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="为店铺的信用账户退款指定类型（账单账户或财务账户）。" id="EditProductStore_storeCreditAccountEnumId_title">Store Credit Account Enum Id</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="storeCreditAccountEnumId" id="EditProductStore_storeCreditAccountEnumId" size="1" class="valid">                <option value="FIN_ACCOUNT">Financial Account</option>          <option value="BILLING_ACCOUNT">Billing Account</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="是否捕获手工授权问题的是/否（Y/N）选项的下拉框。" id="EditProductStore_manualAuthIsCapture_title">捕获人工认证</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="manualAuthIsCapture" id="EditProductStore_manualAuthIsCapture" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="允许多少次认证尝试失败？" id="EditProductStore_retryFailedAuths_title">重试失败的授权</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="retryFailedAuths" id="EditProductStore_retryFailedAuths" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="取消达到这里输入的天数后仍未付款的订单的触发器。" id="EditProductStore_daysToCancelNonPay_title">取消未支付的天数</span>  </td>
  <td>
<input type="text" name="daysToCancelNonPay" size="6" id="EditProductStore_daysToCancelNonPay" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="对于自动生成的订单，尝试其它信用卡失效日期（如果发生日期错误或类型未知的通用错误）。" id="EditProductStore_autoOrderCcTryExp_title">自动订单抄送尝试过期</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoOrderCcTryExp" id="EditProductStore_autoOrderCcTryExp" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="对于自动生成的订单，尝试客户的其它信用卡。" id="EditProductStore_autoOrderCcTryOtherCards_title">自动订单抄送尝试其它卡</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoOrderCcTryOtherCards" id="EditProductStore_autoOrderCcTryOtherCards" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="对于自动生成的订单，如果信用卡发生余额不足的错误，稍后再试。" id="EditProductStore_autoOrderCcTryLaterNsf_title">自动订单抄送尝试资金不足</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoOrderCcTryLaterNsf" id="EditProductStore_autoOrderCcTryLaterNsf" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="对于自动生成的订单，如果信用卡余额不足，再尝试多少次。" id="EditProductStore_autoOrderCcTryLaterMax_title">自动订单抄送尝试最大次数</span>  </td>
  <td>
<input type="text" name="autoOrderCcTryLaterMax" size="6" id="EditProductStore_autoOrderCcTryLaterMax" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="店铺信用多少天有效。Null（空）意味着永不过期。" id="EditProductStore_storeCreditValidDays_title">店铺信用有效天数</span>  </td>
  <td>
<input type="text" name="storeCreditValidDays" size="6" id="EditProductStore_storeCreditValidDays" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是（Y）或空，一旦生效，立刻设置库存明细拥有者。" id="EditProductStore_setOwnerUponIssuance_title">为交付物设置拥有人</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="setOwnerUponIssuance" id="EditProductStore_setOwnerUponIssuance" size="1">              <option value="">&nbsp;</option>
          <option value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G13_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G13__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单</a>
          </li>
        </ul>
    </div>
    <div id="_G13__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="所有订单都会使用这个前缀。比如，如果你希望能够快速区分不同店铺中的订单。" id="EditProductStore_orderNumberPrefix_title">订单编号前缀</span>  </td>
  <td>
<input type="text" name="orderNumberPrefix" size="40" maxlength="60" id="EditProductStore_orderNumberPrefix" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="除非指定了交易中的销售渠道，否则会假设销售来自所选的渠道。" id="EditProductStore_defaultSalesChannelEnumId_title">缺省销售渠道枚举标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="defaultSalesChannelEnumId" id="EditProductStore_defaultSalesChannelEnumId" size="1">              <option value="">&nbsp;</option>
          <option value="AFFIL_SALES_CHANNEL">从属渠道</option>          <option value="EMAIL_SALES_CHANNEL">电子邮件渠道</option>          <option value="EBAY_SALES_CHANNEL">EBay渠道</option>          <option value="FAX_SALES_CHANNEL">传真渠道</option>          <option value="PHONE_SALES_CHANNEL">电话渠道</option>          <option value="POS_SALES_CHANNEL">POS渠道</option>          <option value="SNAIL_SALES_CHANNEL">邮寄渠道</option>          <option value="UNKNWN_SALES_CHANNEL">未知渠道</option>          <option value="WEB_SALES_CHANNEL">网站渠道</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为是（Y），那么购物车里任何数量大于1的明细都会被拆分为每个数量是1的单独的订单明细。" id="EditProductStore_explodeOrderItems_title">展开订单明细</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="explodeOrderItems" id="EditProductStore_explodeOrderItems" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="检查总账账户余额" id="EditProductStore_checkGcBalance_title">检查总账账户余额</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="checkGcBalance" id="EditProductStore_checkGcBalance" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果是（Y），下单时会立刻为数字产品明细生成发票。" id="EditProductStore_autoInvoiceDigitalItems_title">给数字明细自动开发票</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoInvoiceDigitalItems" id="EditProductStore_autoInvoiceDigitalItems" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果事（Y）或空，从订单新建销售发票会标记为就绪。" id="EditProductStore_autoApproveInvoice_title">自动批准发票</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoApproveInvoice" id="EditProductStore_autoApproveInvoice" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果否（N），当授权支付时，会自动批准订单。" id="EditProductStore_autoApproveOrder_title">自动批准订单</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoApproveOrder" id="EditProductStore_autoApproveOrder" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为是（Y），当处于已接受（Accepted）状态时，不等待实际收到退货，退货就会自动变为已接收（Received）状态。" id="EditProductStore_reqReturnInventoryReceive_title">请求退货库房接收</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="reqReturnInventoryReceive" id="EditProductStore_reqReturnInventoryReceive" size="1">              <option value="">&nbsp;</option>
          <option value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G15_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G15__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本地化</a>
          </li>
        </ul>
    </div>
    <div id="_G15__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="缺省语言，用于文字、数字和币种格式。" id="EditProductStore_defaultLocaleString_title">缺省本地语言字符串</span>  </td>
  <td>
<input type="text" name="defaultLocaleString" size="6" maxlength="10" id="EditProductStore_defaultLocaleString" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果没有指定，使用哪个国家的币种。使用Web工具查找非美国的地区代码。" id="EditProductStore_defaultCurrencyUomId_title">缺省货币币种标识</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="defaultCurrencyUomId" id="EditProductStore_defaultCurrencyUomId" size="1">      
        <option selected="selected" value="CNY">中国 - CNY</option>        <option value="CNY">---</option>          <option value="AFA">阿富汗尼 - AFA</option>          <option value="ALL">阿尔巴尼亚列克 - ALL</option>          <option value="DZD">阿尔及利亚第纳尔 - DZD</option>          <option value="ADP">安道尔比塞塔 - ADP</option>          <option value="AOK">安哥拉宽扎 - AOK</option>          <option value="ARS">阿根廷比索 - ARS</option>          <option value="ARA">阿根廷奥斯特罗尔 - ARA</option>          <option value="AMD">亚美尼亚打兰 - AMD</option>          <option value="AWG">阿鲁巴盾 - AWG</option>          <option value="AUD">澳大利亚元 - AUD</option>          <option value="AZM">阿塞拜疆曼纳特 - AZM</option>          <option value="BSD">巴哈马镑 - BSD</option>          <option value="BHD">巴林第纳尔 - BHD</option>          <option value="BDT">孟加拉塔卡 - BDT</option>          <option value="BBD">巴巴多斯元 - BBD</option>          <option value="BZD">洪都拉斯元 - BZD</option>          <option value="BYR">白俄罗斯卢布 - BYR</option>          <option value="XOF">贝宁法郎 - XOF</option>          <option value="BMD">百慕大元 - BMD</option>          <option value="BOB">玻利维亚玻利维亚诺 - BOB</option>          <option value="BAD">波斯尼亚和黑塞哥维那第纳尔 - BAD</option>          <option value="BWP">博茨瓦纳普拉 - BWP</option>          <option value="BRR">巴西 - BRR</option>          <option value="BRL">巴西里尔 - BRL</option>          <option value="GBP">英镑 - GBP</option>          <option value="BND">文莱元 - BND</option>          <option value="BGN">保加利亚列弗 - BGN</option>          <option value="BIF">布隆迪法郎 - BIF</option>          <option value="KHR">柬埔寨里尔 - KHR</option>          <option value="CAD">加拿大元 - CAD</option>          <option value="CVE">佛得角埃斯库多 - CVE</option>          <option value="KYD">开曼元 - KYD</option>          <option value="CLP">智利比索 - CLP</option>          <option value="CNY">中国 - CNY</option>          <option value="COP">哥伦比亚比索 - COP</option>          <option value="KMF">科摩罗法郎 - KMF</option>          <option value="CRC">哥斯达黎加 - CRC</option>          <option value="HRK">Croatian Kuna - HRK</option>          <option value="CUP">古巴比索 - CUP</option>          <option value="CYP">塞普路斯镑 - CYP</option>          <option value="CZK">捷克克郎 - CZK</option>          <option value="DKK">丹麦克郎 - DKK</option>          <option value="DJF">吉布提法郎 - DJF</option>          <option value="DOP">多米加比索 - DOP</option>          <option value="DRP">多米尼加共和国比索 - DRP</option>          <option value="XCD">东加勒比元 - XCD</option>          <option value="ECS">厄瓜多尔苏克雷 - ECS</option>          <option value="EGP">埃及镑 - EGP</option>          <option value="SVC">萨尔瓦多科朗 - SVC</option>          <option value="EEK">爱沙尼亚克郎 - EEK</option>          <option value="ETB">埃塞俄比亚比尔 - ETB</option>          <option value="EUR">欧元 - EUR</option>          <option value="FKP">马尔维纳斯镑 - FKP</option>          <option value="FJD">斐济元 - FJD</option>          <option value="XAF">加蓬法郎 - XAF</option>          <option value="GMD">冈比亚法拉西 - GMD</option>          <option value="GEK">乔治亚库庞 - GEK</option>          <option value="GHC">加纳塞第 - GHC</option>          <option value="GIP">直布罗陀镑 - GIP</option>          <option value="GTQ">危地马拉格查尔 - GTQ</option>          <option value="GNF">几内亚法郎 - GNF</option>          <option value="GWP">几内亚比索 - GWP</option>          <option value="GYD">圭亚那元 - GYD</option>          <option value="HTG">海地古德 - HTG</option>          <option value="HNL">洪都拉斯伦皮拉 - HNL</option>          <option value="HKD">港元 - HKD</option>          <option value="HUF">匈牙利福林 - HUF</option>          <option value="ISK">冰岛克郎 - ISK</option>          <option value="IDR">印尼盾 - IDR</option>          <option value="INR">印度卢比 - INR</option>          <option value="IRR">伊朗里亚尔 - IRR</option>          <option value="IQD">伊拉克第纳尔 - IQD</option>          <option value="JMD">牙买加元 - JMD</option>          <option value="JPY">日元 - JPY</option>          <option value="JOD">约旦第纳尔 - JOD</option>          <option value="KZT">哈萨克斯坦坚戈 - KZT</option>          <option value="KES">肯尼亚先令 - KES</option>          <option value="KIS">吉尔吉斯斯坦索姆 - KIS</option>          <option value="KWD">科威特第纳尔 - KWD</option>          <option value="LAK">老挝基普 - LAK</option>          <option value="LVL">拉脫维亚拉特 - LVL</option>          <option value="LBP">黎巴嫩镑 - LBP</option>          <option value="SLL">塞拉里昂 - SLL</option>          <option value="LSL">莱索托洛蒂 - LSL</option>          <option value="LRD">利比里亚元 - LRD</option>          <option value="LYD">利比亚第纳尔 - LYD</option>          <option value="LTL">立陶宛利塔 - LTL</option>          <option value="MOP">澳门元 - MOP</option>          <option value="MGF">马达加斯加法郎 - MGF</option>          <option value="MWK">马拉维克瓦查 - MWK</option>          <option value="MYR">马来西亚林吉特 - MYR</option>          <option value="MVR">马尔代夫卢非亚 - MVR</option>          <option value="MTL">马耳他里拉 - MTL</option>          <option value="MRO">毛里塔尼亚乌吉亚 - MRO</option>          <option value="MUR">毛里求斯卢比 - MUR</option>          <option value="MXN">墨西哥比索(新) - MXN</option>          <option value="MXP">墨西哥比索(旧) - MXP</option>          <option value="MDL">摩尔多瓦列伊 - MDL</option>          <option value="MNT">蒙古图格里克 - MNT</option>          <option value="MAD">摩洛哥迪拉姆 - MAD</option>          <option value="MZM">莫桑比克美提卡 - MZM</option>          <option value="NPR">尼泊尔卢比 - NPR</option>          <option value="NIS">新以色列谢克尔 - NIS</option>          <option value="TWD">新台币 - TWD</option>          <option value="NZD">新西兰元 - NZD</option>          <option value="NIC">尼加拉瓜 - NIC</option>          <option value="NIO">尼加拉瓜科多巴 - NIO</option>          <option value="NGN">尼日利亚奈拉 - NGN</option>          <option value="KPW">朝鲜元 - KPW</option>          <option value="NOK">挪威克郎 - NOK</option>          <option value="OMR">阿曼里亚尔 - OMR</option>          <option value="PKR">巴基斯坦卢比 - PKR</option>          <option value="PAB">巴拿马巴波亚 - PAB</option>          <option value="PGK">巴布亚新几内亚基那 - PGK</option>          <option value="PYG">巴拉圭瓜拉尼 - PYG</option>          <option value="SOL">秘鲁 - SOL</option>          <option value="PEI">秘鲁因蒂 - PEI</option>          <option value="PES">秘鲁索尔 - PES</option>          <option value="PEN">秘鲁新索尔 - PEN</option>          <option value="PHP">菲律宾比索 - PHP</option>          <option value="PLZ">波兰 - PLZ</option>          <option value="PLN">波兰兹罗提 - PLN</option>          <option value="QAR">卡塔尔里亚尔 - QAR</option>          <option value="ROL">罗马尼亚列伊 - ROL</option>          <option value="RUR">俄罗斯卢布 - RUR</option>          <option value="SUR">俄罗斯卢布(旧) - SUR</option>          <option value="RWF">卢旺达法郎 - RWF</option>          <option value="WST">萨摩亚塔拉 - WST</option>          <option value="CDP">桑托多明哥 - CDP</option>          <option value="STD">圣多美和普林西比多布拉 - STD</option>          <option value="SAR">沙特里亚尔 - SAR</option>          <option value="SCR">塞舌尔卢比 - SCR</option>          <option value="SGD">新加坡元 - SGD</option>          <option value="SBD">所罗门群岛元 - SBD</option>          <option value="SOS">索马里先令 - SOS</option>          <option value="ZAR">南非兰特 - ZAR</option>          <option value="KRW">韩国元 - KRW</option>          <option value="LKR">斯里兰卡卢比 - LKR</option>          <option value="SHP">圣赫勒拿群岛镑 - SHP</option>          <option value="SDP">苏丹镑 - SDP</option>          <option value="SRG">苏里南盾 - SRG</option>          <option value="SZL">斯威士兰埃马兰吉尼 - SZL</option>          <option value="SEK">瑞典克郎 - SEK</option>          <option value="CHF">瑞士法郎 - CHF</option>          <option value="SYP">叙利亚镑 - SYP</option>          <option value="TJR">塔吉克斯坦卢布 - TJR</option>          <option value="TZS">坦桑尼亚先令 - TZS</option>          <option value="THB">泰铢 - THB</option>          <option value="TPE">帝汶埃斯库多 - TPE</option>          <option value="TOP">汤加 - TOP</option>          <option value="TTD">特立尼达和多巴哥元 - TTD</option>          <option value="TND">突尼斯第尔 - TND</option>          <option value="TRY">土耳其里拉 - TRY</option>          <option value="TMM">土库曼斯坦马纳特 - TMM</option>          <option value="UGS">乌干达先令 - UGS</option>          <option value="UAH">乌克兰格里夫那 - UAH</option>          <option value="AED">阿联酋迪拉姆 - AED</option>          <option value="USD">美元 - USD</option>          <option value="UYU">乌拉圭 - UYU</option>          <option value="UYP">乌拉圭新比索 - UYP</option>          <option value="VUV">瓦努阿图瓦图 - VUV</option>          <option value="VEB">委内瑞拉博利瓦 - VEB</option>          <option value="VND">越南盾 - VND</option>          <option value="ANG">安第列斯群岛盾 - ANG</option>          <option value="YER">也门里亚尔 - YER</option>          <option value="ZRZ">扎伊尔 - ZRZ</option>          <option value="ZMK">赞比亚克瓦查 - ZMK</option>          <option value="ZWD">津巴布韦元 - ZWD</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G17_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G17__body', '展开', '合拢');">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单状态</a>
          </li>
        </ul>
    </div>
    <div id="_G17__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="当客户的订单得到批准时，这是你想要他们看到的信息。" id="EditProductStore_headerApprovedStatus_title">头已批准状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="headerApprovedStatus" id="EditProductStore_headerApprovedStatus" size="1">                
	    <option value="ORDER_CREATED">待付款 [CREATED]</option>          
	    <option value="ORDER_SENT">已发货 [SENT]</option>          
	    <option value="ORDER_PROCESSING">处理中 [PROCESSING]</option>          
	    <option selected="selected" value="ORDER_APPROVED">待发货 [APPROVED]</option>          
	    <option value="ORDER_HOLD">已保留 [HELD]</option>          
	    <option value="ORDER_COMPLETED">已完成 [COMPLETED]</option>          
	    <option value="ORDER_REJECTED">已退款 [REJECTED]</option>          
	    <option value="ORDER_CANCELLED">已取消 [CANCELLED]</option>    
    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当订单被批准、被拒绝或被取消时，把订单明细设置成什么状态。基于OFBiz中定义的标准状态代码。" id="EditProductStore_itemApprovedStatus_title">明细已批准状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="itemApprovedStatus" id="EditProductStore_itemApprovedStatus" size="1">                <option value="ITEM_CREATED">已创建 [CREATED]</option>          <option selected="selected" value="ITEM_APPROVED">已批准 [APPROVED]</option>          <option value="ITEM_COMPLETED">已完成 [COMPLETED]</option>          <option value="ITEM_REJECTED">已拒绝 [REJECTED]</option>          <option value="ITEM_CANCELLED">已取消 [CANCELLED]</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当数字产品明细订单被批准、被拒绝或被取消时，把订单明细设置成什么状态。基于OFBiz中定义的标准状态代码。" id="EditProductStore_digitalItemApprovedStatus_title">数字明细已批准状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="digitalItemApprovedStatus" id="EditProductStore_digitalItemApprovedStatus" size="1">                <option value="ITEM_CREATED">已创建 [CREATED]</option>          <option selected="selected" value="ITEM_APPROVED">已批准 [APPROVED]</option>          <option value="ITEM_COMPLETED">已完成 [COMPLETED]</option>          <option value="ITEM_REJECTED">已拒绝 [REJECTED]</option>          <option value="ITEM_CANCELLED">已取消 [CANCELLED]</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当客户的订单被拒绝时，这是你想要他们看到的信息。基于OFBiz中定义的标准状态代码。" id="EditProductStore_headerDeclinedStatus_title">头已否决状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="headerDeclinedStatus" id="EditProductStore_headerDeclinedStatus" size="1">                
	    <option value="ORDER_CREATED">待付款 [CREATED]</option>          
	    <option value="ORDER_SENT">已发货 [SENT]</option>          
	    <option value="ORDER_PROCESSING">处理中 [PROCESSING]</option>          
	    <option value="ORDER_APPROVED">待发货 [APPROVED]</option>          
	    <option value="ORDER_HOLD">已保留 [HELD]</option>          
	    <option value="ORDER_COMPLETED">已完成 [COMPLETED]</option>          
	    <option selected="selected" value="ORDER_REJECTED">已退款 [REJECTED]</option>          
	    <option value="ORDER_CANCELLED">已取消 [CANCELLED]</option>    
    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当客户的明细中的一个因某种原因被拒绝时，这是你想要他看到的信息。" id="EditProductStore_itemDeclinedStatus_title">明细已否决状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="itemDeclinedStatus" id="EditProductStore_itemDeclinedStatus" size="1">                <option value="ITEM_CREATED">已创建 [CREATED]</option>          <option value="ITEM_APPROVED">已批准 [APPROVED]</option>          <option value="ITEM_COMPLETED">已完成 [COMPLETED]</option>          <option selected="selected" value="ITEM_REJECTED">已拒绝 [REJECTED]</option>          <option value="ITEM_CANCELLED">已取消 [CANCELLED]</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当客户的订单被取消时，这是你想要他看到的信息。" id="EditProductStore_headerCancelStatus_title">头取消状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="headerCancelStatus" id="EditProductStore_headerCancelStatus" size="1">                
    	<option value="ORDER_CREATED">待付款 [CREATED]</option>          
    	<option value="ORDER_SENT">已发货 [SENT]</option>          
    	<option value="ORDER_PROCESSING">处理中 [PROCESSING]</option>          
    	<option value="ORDER_APPROVED">待发货 [APPROVED]</option>          
    	<option value="ORDER_HOLD">已保留 [HELD]</option>          
    	<option value="ORDER_COMPLETED">已完成 [COMPLETED]</option>          
    	<option value="ORDER_REJECTED">已退款 [REJECTED]</option>          
    	<option selected="selected" value="ORDER_CANCELLED">已取消 [CANCELLED]</option>    
    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当订单中的一个明细被取消时，显示的信息。" id="EditProductStore_itemCancelStatus_title">明细取消状态</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="itemCancelStatus" id="EditProductStore_itemCancelStatus" size="1">                <option value="ITEM_CREATED">已创建 [CREATED]</option>          <option value="ITEM_APPROVED">已批准 [APPROVED]</option>          <option value="ITEM_COMPLETED">已完成 [COMPLETED]</option>          <option value="ITEM_REJECTED">已拒绝 [REJECTED]</option>          <option selected="selected" value="ITEM_CANCELLED">已取消 [CANCELLED]</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G19_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G19__body', '展开', '合拢');">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;消息</a>
          </li>
        </ul>
    </div>
    <div id="_G19__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="当支付授权被拒绝时，显示的信息。" id="EditProductStore_authDeclinedMessage_title">授权拒绝信息</span>  </td>
  <td>
<input type="text" name="authDeclinedMessage" size="60" maxlength="250" id="EditProductStore_authDeclinedMessage" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当怀疑是欺诈时，发送的信息。" id="EditProductStore_authFraudMessage_title">授权欺骗信息</span>  </td>
  <td>
<input type="text" name="authFraudMessage" size="60" maxlength="250" id="EditProductStore_authFraudMessage" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当遇到一个处理错误时，发送的信息。" id="EditProductStore_authErrorMessage_title">授权错误信息</span>  </td>
  <td>
<input type="text" name="authErrorMessage" size="60" maxlength="250" id="EditProductStore_authErrorMessage" autocomplete="off">  
  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G21_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G21__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;税</a>
          </li>
        </ul>
    </div>
    <div id="_G21__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="税收比例" id="EditProductStore_prorateTaxes_title">税收比例</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="prorateTaxes" id="EditProductStore_prorateTaxes" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="价格中含（Y）还是不含（N）增值税金额？" id="EditProductStore_showPricesWithVatTax_title">显示含增值税价格</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="showPricesWithVatTax" id="EditProductStore_showPricesWithVatTax" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="当一个明细是免税的，需要指出来吗？" id="EditProductStore_showTaxIsExempt_title">显示免除的税</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="showTaxIsExempt" id="EditProductStore_showTaxIsExempt" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="增值税征税机构的地理标识是什么？" id="EditProductStore_vatTaxAuthGeoId_title">增值税税务机关地区标识</span>  </td>
  <td>
  <!-- @renderLookupField -->
    <script type="text/javascript">
      jQuery(document).ready(function(){
        if (!jQuery('form[name="EditProductStore"]').length) {
          alert("Developer: for lookups to work you must provide a form name!")
        }
      });
    </script>
  <span class="field-lookup">
      <div id="4_lookupId_EditProductStore_vatTaxAuthGeoId_auto"></div><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span><input type="text" name="vatTaxAuthGeoId" size="25" id="4_lookupId_EditProductStore_vatTaxAuthGeoId" class="ui-autocomplete-input" autocomplete="off">
      <script type="text/javascript">
        jQuery(document).ready(function(){
          var options = {
            requestUrl : "LookupGeo",
            inputFieldId : "EditProductStore_vatTaxAuthGeoId",
            dialogTarget : document.EditProductStore.vatTaxAuthGeoId,
            dialogOptionalTarget : null,
            formName : "EditProductStore",
            width : "",
            height : "",
            position : "topleft",
            modal : "true",
            ajaxUrl : "EditProductStore_vatTaxAuthGeoId,/catalog/control/LookupGeo,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStore&amp;searchValueFieldName=vatTaxAuthGeoId",
            showDescription : "true",
            presentation : "layer",
            defaultMinLength : "2",
            defaultDelay : "300",
            args :
[]
          };
          new Lookup(options).init();
        });
      </script>
  <a href="javascript:void(0);" id="4_lookupId_button"></a></span>
  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="增值税征税机构的会员标识是什么？" id="EditProductStore_vatTaxAuthPartyId_title">增值税税务机关会员标识</span>  </td>
  <td>
  <!-- @renderLookupField -->
    <script type="text/javascript">
      jQuery(document).ready(function(){
        if (!jQuery('form[name="EditProductStore"]').length) {
          alert("Developer: for lookups to work you must provide a form name!")
        }
      });
    </script>
  <span class="field-lookup">
      <div id="5_lookupId_EditProductStore_vatTaxAuthPartyId_auto"></div><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span><input type="text" name="vatTaxAuthPartyId" size="25" id="5_lookupId_EditProductStore_vatTaxAuthPartyId" class="ui-autocomplete-input" autocomplete="off">
      <script type="text/javascript">
        jQuery(document).ready(function(){
          var options = {
            requestUrl : "LookupPartyName",
            inputFieldId : "EditProductStore_vatTaxAuthPartyId",
            dialogTarget : document.EditProductStore.vatTaxAuthPartyId,
            dialogOptionalTarget : null,
            formName : "EditProductStore",
            width : "",
            height : "",
            position : "topleft",
            modal : "true",
            ajaxUrl : "EditProductStore_vatTaxAuthPartyId,/catalog/control/LookupPartyName,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStore&amp;searchValueFieldName=vatTaxAuthPartyId",
            showDescription : "true",
            presentation : "layer",
            defaultMinLength : "2",
            defaultDelay : "300",
            args :
[]
          };
          new Lookup(options).init();
        });
      </script>
  <a href="javascript:void(0);" id="5_lookupId_button"></a></span>
  
  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G23_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G23__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;访问者</a>
          </li>
        </ul>
    </div>
    <div id="_G23__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="如果网站允许用户输入产品评论，那么这会控制是否评论必须被审批，或者评论可以自动显示在网站上。" id="EditProductStore_autoApproveReviews_title">自动批准评价</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="autoApproveReviews" id="EditProductStore_autoApproveReviews" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果否，当客户新建账户时，不会问他密码，他必须等待他的账户被启用、并给他发送密码。" id="EditProductStore_allowPassword_title">允许密码</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="allowPassword" id="EditProductStore_allowPassword" size="1">                <option selected="selected" value="Y">是</option>          <option value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果你允许其他人通过密码访问，任何人都可以用的缺省密码是什么？" id="EditProductStore_defaultPassword_title">缺省密码</span>  </td>
  <td>
<input type="text" name="defaultPassword" size="60" maxlength="250" id="EditProductStore_defaultPassword" autocomplete="off">  
  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为是（Y），那么在创建用户的表单中将没有用户名 —— 会使用首选电子邮件地址作为用户名。" id="EditProductStore_usePrimaryEmailUsername_title">使用主要电子邮件用户名</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="usePrimaryEmailUsername" id="EditProductStore_usePrimaryEmailUsername" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="如果设为是（Y），那么客户必须在订单的客户角色中与店铺关联，才能登录（如B2B）" id="EditProductStore_requireCustomerRole_title">需要客户角色</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="requireCustomerRole" id="EditProductStore_requireCustomerRole" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="自动建议列表是一个特殊的购物列表（ShoppingList），添加建议到购物列表（addSuggestionsToShoppingList）服务会维护订单明细的交叉销售。" id="EditProductStore_enableAutoSuggestionList_title">启用自动推荐列表</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="enableAutoSuggestionList" id="EditProductStore_enableAutoSuggestionList" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  </tbody></table>
</div></div>  <div class="fieldgroup" id="_G25_" style="display: none;">
    <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed">
                      <a onclick="javascript:toggleCollapsiblePanel(this, '_G25__body', '展开', '合拢');" title="展开">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传</a>
          </li>
        </ul>
    </div>
    <div id="_G25__body" class="fieldgroup-body" style="display: none;">
  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
<span title="除非设置为是，否则不允许你的店铺销售数字商品。" id="EditProductStore_enableDigProdUpload_title">允许数字产品上传</span>  </td>
  <td>
  <span class="ui-widget">
    <select name="enableDigProdUpload" id="EditProductStore_enableDigProdUpload" size="1">                <option value="Y">是</option>          <option selected="selected" value="N">N</option>    </select>
  </span>

  
  </td>
  </tr>
  <tr>
  <td class="label">
<span title="要上传哪个数字产品分类？" id="EditProductStore_digProdUploadCategoryId_title">数字产品上传分类标识</span>  </td>
  <td>
  <!-- @renderLookupField -->
    <script type="text/javascript">
      jQuery(document).ready(function(){
        if (!jQuery('form[name="EditProductStore"]').length) {
          alert("Developer: for lookups to work you must provide a form name!")
        }
      });
    </script>
  <span class="field-lookup">
      <div id="6_lookupId_EditProductStore_digProdUploadCategoryId_auto"></div><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span><input type="text" name="digProdUploadCategoryId" size="25" id="6_lookupId_EditProductStore_digProdUploadCategoryId" class="ui-autocomplete-input" autocomplete="off">
      <script type="text/javascript">
        jQuery(document).ready(function(){
          var options = {
            requestUrl : "LookupProductCategory",
            inputFieldId : "EditProductStore_digProdUploadCategoryId",
            dialogTarget : document.EditProductStore.digProdUploadCategoryId,
            dialogOptionalTarget : null,
            formName : "EditProductStore",
            width : "",
            height : "",
            position : "topleft",
            modal : "true",
            ajaxUrl : "EditProductStore_digProdUploadCategoryId,/catalog/control/LookupProductCategory,ajaxLookup=Y&amp;_LAST_VIEW_NAME_=EditProductStore&amp;searchValueFieldName=digProdUploadCategoryId",
            showDescription : "true",
            presentation : "layer",
            defaultMinLength : "2",
            defaultDelay : "300",
            args :
[]
          };
          new Lookup(options).init();
        });
      </script>
  <a href="javascript:void(0);" id="6_lookupId_button"></a></span>
  
  
  </td>
  </tr>
  </tbody></table>
</div></div>  <table cellspacing="0" class="basic-table">
  <tbody><tr>
  <td class="label">
&nbsp;  </td>
  <td colspan="4">
    <input type="submit" name="submitButton" value="更新">
  
  </td>
  </tr>
  </tbody></table>
</form>
