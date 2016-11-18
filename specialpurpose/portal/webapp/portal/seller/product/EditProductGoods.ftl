<#assign actionUrlStr="createProduct">
<#if product?has_content>
	<#assign actionUrlStr="updateProduct">
</#if>
<div class="content">
  <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" id="EditProduct" class="basic-form" onSubmit="javascript:submitFormDisableSubmits(this)" name="EditProduct" novalidate="novalidate">
    <input type="hidden" name="productId" value="${(product.productId)!}" id="EditProduct_productId">
    <input type="hidden" name="primaryProductStoreId" id="primaryProductStoreId"  value="${(product.primaryProductStoreId)!productStoreId!}">
    <div class="fieldgroup" id="_G16_">
      <div class="fieldgroup-title-bar"> </div>
      <div id="_G16__body" class="fieldgroup-body">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_productId_title">产品标识&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> </td>
              <td> ${(product.productId)!} <span class="tooltip">无法修改，除非重新创建产品</span> </td>
              
            </tr>
            <tr>
            <td ><span id="EditProduct_productTypeId_title">产品类型&nbsp;</span> </td>
              <td colspan="7"><span class="ui-widget">
                <select name="productTypeId" id="EditProduct_productTypeId" size="1" class="valid">
                  <option selected="selected" value="FINISHED_GOOD">成品</option>
                  <option value="DIGITAL_GOOD">数字商品</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G18_">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="expanded"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G18__body', '展开', '合拢');" title="合拢"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;说明和评论</a> </li>
        </ul>
      </div>
      <div id="_G18__body" class="fieldgroup-body" style="display: block;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_internalName_title">内部名称</span> </td>
              <td><input type="text" name="internalName" class="" value="${(product.internalName)!(requestParameters.internalName)!}" size="30" maxlength="255" id="EditProduct_internalName">
                * </td>
             
            </tr>
            <tr>
             <td ><span id="EditProduct_brandName_title">品牌名称</span> </td>
              <td colspan="7"><input type="text" name="brandName" size="30" maxlength="60" id="EditProduct_brandName" value="${(product.brandName)!(requestParameters.brandName)!}">
              </td>
            </tr>
            <tr style="display:none;">
              <td ><span id="EditProduct_manufacturerPartyId_title">OEM会员标识 </span> </td>
              <td colspan="10"><input type="text" name="manufacturerPartyId" size="30" maxlength="20" id="EditProduct_manufacturerPartyId" value="${(product.manufacturerPartyId)!(requestParameters.manufacturerPartyId)!}">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_comments_title">评论</span> </td>
              <td colspan="10"><input type="text" name="comments" size="60" maxlength="250" id="EditProduct_comments" value="${(product.comments)!(requestParameters.comments)!}">
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G20_" style="display: none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G20__body', '展开', '合拢');" title="展开"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;虚拟产品</a> </li>
        </ul>
      </div>
      <div id="_G20__body" class="fieldgroup-body" style="display: none;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_isVirtual_title">是虚拟产品吗?</span> </td>
              <td><span class="ui-widget">
                <select name="isVirtual" id="EditProduct_isVirtual" size="1">
                  <option selected="selected" value="N">否</option>
                  <option value="N">---</option>
                  <option value="N">否</option>
                  <option value="Y">是</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_isVariant_title">是变型产品?</span> </td>
              <td><span class="ui-widget">
                <select name="isVariant" id="EditProduct_isVariant" size="1">
                  <option selected="selected" value="N">否</option>
                  <option value="N">---</option>
                  <option value="N">否</option>
                  <option value="Y">是</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_virtualVariantMethodEnum_title">虚拟的多样化方法</span> </td>
              <td colspan="4"><span class="ui-widget">
                <select name="virtualVariantMethodEnum" id="EditProduct_virtualVariantMethodEnum" size="1">
                  <option value="">&nbsp;</option>
                  <option value="VV_FEATURETREE">Feature tree Generation</option>
                  <option value="VV_VARIANTTREE">Variant Tree generation</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G22_">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="expanded"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G22__body', '展开', '合拢');" title="合拢"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主要分类&nbsp;</a> </li>
        </ul>
      </div>
      <div id="_G22__body" class="fieldgroup-body" style="display: block;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_primaryProductCategoryId_title">主要分类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> </td>
              <td colspan="10"><span class="ui-widget">
                <select name="primaryProductCategoryId" id="EditProduct_primaryProductCategoryId" size="1">
                  <#list categoryList as category> 
                  <option <#if  product.productCategoryId==category.productCategoryId>selecked</#if> value="${category.productCategoryId}">${category.categoryName}
                  </option>
                  </#list>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G24_">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="expanded"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G24__body', '展开', '合拢');" title="合拢"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期</a> </li>
        </ul>
      </div>
      <div id="_G24__body" class="fieldgroup-body" style="display: block;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td width="120"><span id="EditProduct_introductionDate_title">推介日期</span> </td>
              <td width="250"><span class="view-calendar">
                <input id="EditProduct_introductionDate_i18n" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="introductionDate" maxLength="30" size="25" type="text" value="${(product.introductionDate)!}">
                <script type="text/javascript">
                        jQuery(function () {
            // 时间设置
            jQuery('#EditProduct_introductionDate_i18n').datetimepicker({
                 showSecond: true,
          timeFormat: 'HH:mm:ss',
          stepHour: 1,
          stepMinute: 1,
          stepSecond: 1,
          showOn: 'button',
          buttonImage: '',
          buttonText: '',
          buttonImageOnly: false,
          dateFormat: 'yy-mm-dd'
 
            });

        });
                
      </script>
                <input value="Timestamp" type="hidden">
                </span> </td>
              <td ><span id="EditProduct_releaseDate_title">发布日期</span> </td>
              <td><span class="view-calendar">
                <input id="EditProduct_releaseDate_i18n" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="releaseDate" maxLength="30" size="25" type="text" value="${(product.releaseDate)!}">
                <script type="text/javascript">
                                 jQuery(function () {
            // 时间设置
            jQuery('#EditProduct_releaseDate_i18n').datetimepicker({
                     showSecond: true,
			          timeFormat: 'HH:mm:ss',
			          stepHour: 1,
			          stepMinute: 1,
			          stepSecond: 1,
			          showOn: 'button',
			          buttonImage: '',
			          buttonText: '',
			          buttonImageOnly: false,
			          dateFormat: 'yy-mm-dd'
            });

        });
      </script>
                <input value="Timestamp" type="hidden">
                </span> </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_salesDiscontinuationDate_title">销售中止结束日期</span> </td>
              <td><span class="view-calendar">
                <input id="EditProduct_salesDiscontinuationDate_i18n" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="salesDiscontinuationDate" maxLength="30" size="25" type="text" value="${(product.salesDiscontinuationDate)!}">
                <script type="text/javascript">
                         jQuery(function () {
		            // 时间设置
		            jQuery('#EditProduct_salesDiscontinuationDate_i18n').datetimepicker({
                        showSecond: true,
			          timeFormat: 'HH:mm:ss',
			          stepHour: 1,
			          stepMinute: 1,
			          stepSecond: 1,
			          showOn: 'button',
			          buttonImage: '',
			          buttonText: '',
			          buttonImageOnly: false,
			          dateFormat: 'yy-mm-dd'
		            });

        		});
      </script>
                <input value="Timestamp" type="hidden">
                </span> </td>
              <td ><span id="EditProduct_supportDiscontinuationDate_title">支持结束日期</span> </td>
              <td><span class="view-calendar">
                <input id="EditProduct_supportDiscontinuationDate_i18n" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="supportDiscontinuationDate" maxLength="30" size="25" type="text" value="${(product.supportDiscontinuationDate)!}">
                <script type="text/javascript">
               jQuery(function () {
		            // 时间设置
		            jQuery('#EditProduct_supportDiscontinuationDate_i18n').datetimepicker({
                    showSecond: true,
			          timeFormat: 'HH:mm:ss',
			          stepHour: 1,
			          stepMinute: 1,
			          stepSecond: 1,
			          showOn: 'button',
			          buttonImage: '',
			          buttonText: '',
			          buttonImageOnly: false,
			          dateFormat: 'yy-mm-dd'
		            });
        		});
      </script>
                <input value="Timestamp" type="hidden">
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G26_" style="display: none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G26__body', '展开', '合拢');" title="展开"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库存</a> </li>
        </ul>
      </div>
      <div id="_G26__body" class="fieldgroup-body" style="display: none;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_salesDiscWhenNotAvail_title">缺货时有折扣吗?</span> </td>
              <td colspan="10"><span class="ui-widget">
                <select name="salesDiscWhenNotAvail" id="EditProduct_salesDiscWhenNotAvail" size="1">
                  <option value="">&nbsp;</option>
                  <option value="Y">是</option>
                  <option value="N">否</option>
                </select>
                </span> </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_requirementMethodEnumId_title">需求方式枚举标识</span> </td>
              <td colspan="10"><span class="ui-widget">
                <select name="requirementMethodEnumId" id="EditProduct_requirementMethodEnumId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="PRODRQM_NONE">没有已创建的请求</option>
                  <option value="PRODRQM_AUTO">对每个销售定单自动</option>
                  <option value="PRODRQM_STOCK">当现货数量达到最小库存时</option>
                  <option value="PRODRQM_STOCK_ATP">当承诺数量达到最小库存时</option>
                  <option value="PRODRQM_ATP">当承诺提供数量达到产品-场所的最小存货时的需求订单</option>
                  <option value="PRODRQM_DS">仅直接送货</option>
                  <option value="PRODRQM_DSATP">在低数量时自动直接送货</option>
                </select>
                </span> </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_requireInventory_title">需要库存</span> </td>
              <td colspan="10"><span class="ui-widget">
                <select name="requireInventory" id="EditProduct_requireInventory" size="1">
                  <option value="">&nbsp;</option>
                  <option value="Y">是</option>
                  <option value="N">否</option>
                </select>
                </span> <span class="tooltip">购买这个产品必须有货吗? 如果没有指定，商店设置会使用缺省值</span> </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_inventoryMessage_title">库存信息</span> </td>
              <td colspan="10"><input type="text" name="inventoryMessage" size="20" maxlength="255" id="EditProduct_inventoryMessage">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_lotIdFilledIn_title">彩票标识</span> </td>
              <td colspan="10"><span class="ui-widget">
                <select name="lotIdFilledIn" id="EditProduct_lotIdFilledIn" size="1">
                  <option value="Allowed">允许</option>
                  <option value="Mandatory">必须</option>
                  <option value="Forbidden">禁用</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G28_" style="display: none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G28__body', '展开', '合拢');" title="展开"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;评价</a> </li>
        </ul>
      </div>
      <div id="_G28__body" class="fieldgroup-body" style="display: none;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_ratingTypeEnum_title">评级类型枚举</span> </td>
              <td><span class="ui-widget">
                <select name="ratingTypeEnum" id="EditProduct_ratingTypeEnum" size="1">
                  <option value="">&nbsp;</option>
                  <option value="PRDR_MIN">最低评级</option>
                  <option value="PRDR_MAX">最高评级</option>
                  <option value="PRDR_FLAT">覆盖评级</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_productRating_title">评级</span> </td>
              <td colspan="7"><input type="text" name="productRating" size="10" maxlength="20" id="EditProduct_productRating">
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G30_" style="display: none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="collapsed"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G30__body', '展开', '合拢');" title="展开"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额</a> </li>
        </ul>
      </div>
      <div id="_G30__body" class="fieldgroup-body" style="display: none;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_requireAmount_title">需要金额</span> </td>
              <td><span class="ui-widget">
                <select name="requireAmount" id="EditProduct_requireAmount" size="1">
                  <option value="">&nbsp;</option>
                  <option value="Y">是</option>
                  <option value="N">否</option>
                </select>
                </span> <span class="tooltip">需要客户输入一个金额。</span> </td>
              <td ><span id="EditProduct_amountUomTypeId_title">金额币种类型标识</span> </td>
              <td colspan="7"><span class="ui-widget">
                <select name="amountUomTypeId" id="EditProduct_amountUomTypeId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="AREA_MEASURE">地区</option>
                  <option value="CURRENCY_MEASURE">币种</option>
                  <option value="DATA_MEASURE">数据大小</option>
                  <option value="DATASPD_MEASURE">数据速度</option>
                  <option value="VOLUME_DRY_MEASURE">固体体积</option>
                  <option value="ENERGY_MEASURE">能量</option>
                  <option value="LENGTH_MEASURE">长度</option>
                  <option value="VOLUME_LIQ_MEASURE">液体体积</option>
                  <option value="OTHER_MEASURE">其它</option>
                  <option value="TEMP_MEASURE">温度</option>
                  <option value="TIME_FREQ_MEASURE">时间/频率</option>
                  <option value="WEIGHT_MEASURE">重量</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G32_" style="display:none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="expanded"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G32__body', '展开', '合拢');" title="合拢"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度量</a> </li>
        </ul>
      </div>
      <div id="_G32__body" class="fieldgroup-body" style="display: block;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td width="100"><span id="EditProduct_productHeight_title">产品高度</span> </td>
              <td width="110"><input type="text" name="productHeight" size="10" maxlength="20" id="EditProduct_productHeight">
              </td>
              <td width="115"><span id="EditProduct_heightUomId_title">高度度量单位标识</span> </td>
              <td width="210"><span class="ui-widget">
                <select name="heightUomId" id="EditProduct_heightUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="LEN_A">埃 [A]</option>
                  <option value="LEN_cb">链 [cb]</option>
                  <option value="LEN_cm">厘米 [cm]</option>
                  <option value="LEN_chG">链 (甘特/勘测) [chG]</option>
                  <option value="LEN_chR">链 (拉姆丹/工程) [chR]</option>
                  <option value="LEN_dm">分米 [dm]</option>
                  <option value="LEN_dam">十米 [dam]</option>
                  <option value="LEN_fm">英寻 [fm]</option>
                  <option value="LEN_ft">英尺 [ft]</option>
                  <option value="LEN_fur">浪 [fur]</option>
                  <option value="LEN_hand">手 (马的高度) [hand]</option>
                  <option value="LEN_in">英寸 [in]</option>
                  <option value="LEN_km">千米 [km]</option>
                  <option value="LEN_league">里格 [league]</option>
                  <option value="LEN_lnG">令 (甘特) [lnG]</option>
                  <option value="LEN_lnR">令 (拉姆丹) [lnR]</option>
                  <option value="LEN_m">米 [m]</option>
                  <option value="LEN_u">微米 [u]</option>
                  <option value="LEN_mil">密耳 (千分之一英寸) [mil]</option>
                  <option value="LEN_nmi">英里 (航海/海洋) [nmi]</option>
                  <option value="LEN_mi">英里 (法定/陆地) [mi]</option>
                  <option value="LEN_mm">毫米 [mm]</option>
                  <option value="LEN_pica">12点活字 (铅字大小) [pica]</option>
                  <option value="LEN_point">点 (铅字大小) [point]</option>
                  <option value="LEN_rd">杆 [rd]</option>
                  <option value="LEN_yd">码 [yd]</option>
                </select>
                </span> </td>
              <td width="60"><span id="EditProduct_shippingHeight_title">货运高度</span> </td>
              <td colspan="4" width="100"><input type="text" name="shippingHeight" size="10" maxlength="20" id="EditProduct_shippingHeight">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_productWidth_title">产品宽度</span> </td>
              <td><input type="text" name="productWidth" size="10" maxlength="20" id="EditProduct_productWidth">
              </td>
              <td ><span id="EditProduct_widthUomId_title">宽度度量单位标识</span> </td>
              <td><span class="ui-widget">
                <select name="widthUomId" id="EditProduct_widthUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="LEN_A">埃 [A]</option>
                  <option value="LEN_cb">链 [cb]</option>
                  <option value="LEN_cm">厘米 [cm]</option>
                  <option value="LEN_chG">链 (甘特/勘测) [chG]</option>
                  <option value="LEN_chR">链 (拉姆丹/工程) [chR]</option>
                  <option value="LEN_dm">分米 [dm]</option>
                  <option value="LEN_dam">十米 [dam]</option>
                  <option value="LEN_fm">英寻 [fm]</option>
                  <option value="LEN_ft">英尺 [ft]</option>
                  <option value="LEN_fur">浪 [fur]</option>
                  <option value="LEN_hand">手 (马的高度) [hand]</option>
                  <option value="LEN_in">英寸 [in]</option>
                  <option value="LEN_km">千米 [km]</option>
                  <option value="LEN_league">里格 [league]</option>
                  <option value="LEN_lnG">令 (甘特) [lnG]</option>
                  <option value="LEN_lnR">令 (拉姆丹) [lnR]</option>
                  <option value="LEN_m">米 [m]</option>
                  <option value="LEN_u">微米 [u]</option>
                  <option value="LEN_mil">密耳 (千分之一英寸) [mil]</option>
                  <option value="LEN_nmi">英里 (航海/海洋) [nmi]</option>
                  <option value="LEN_mi">英里 (法定/陆地) [mi]</option>
                  <option value="LEN_mm">毫米 [mm]</option>
                  <option value="LEN_pica">12点活字 (铅字大小) [pica]</option>
                  <option value="LEN_point">点 (铅字大小) [point]</option>
                  <option value="LEN_rd">杆 [rd]</option>
                  <option value="LEN_yd">码 [yd]</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_shippingWidth_title">货运宽度</span> </td>
              <td colspan="4"><input type="text" name="shippingWidth" size="10" maxlength="20" id="EditProduct_shippingWidth">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_productDepth_title">产品长度</span> </td>
              <td><input type="text" name="productDepth" size="10" maxlength="20" id="EditProduct_productDepth">
              </td>
              <td ><span id="EditProduct_depthUomId_title">长度度量单位标识</span> </td>
              <td><span class="ui-widget">
                <select name="depthUomId" id="EditProduct_depthUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="LEN_A">埃 [A]</option>
                  <option value="LEN_cb">链 [cb]</option>
                  <option value="LEN_cm">厘米 [cm]</option>
                  <option value="LEN_chG">链 (甘特/勘测) [chG]</option>
                  <option value="LEN_chR">链 (拉姆丹/工程) [chR]</option>
                  <option value="LEN_dm">分米 [dm]</option>
                  <option value="LEN_dam">十米 [dam]</option>
                  <option value="LEN_fm">英寻 [fm]</option>
                  <option value="LEN_ft">英尺 [ft]</option>
                  <option value="LEN_fur">浪 [fur]</option>
                  <option value="LEN_hand">手 (马的高度) [hand]</option>
                  <option value="LEN_in">英寸 [in]</option>
                  <option value="LEN_km">千米 [km]</option>
                  <option value="LEN_league">里格 [league]</option>
                  <option value="LEN_lnG">令 (甘特) [lnG]</option>
                  <option value="LEN_lnR">令 (拉姆丹) [lnR]</option>
                  <option value="LEN_m">米 [m]</option>
                  <option value="LEN_u">微米 [u]</option>
                  <option value="LEN_mil">密耳 (千分之一英寸) [mil]</option>
                  <option value="LEN_nmi">英里 (航海/海洋) [nmi]</option>
                  <option value="LEN_mi">英里 (法定/陆地) [mi]</option>
                  <option value="LEN_mm">毫米 [mm]</option>
                  <option value="LEN_pica">12点活字 (铅字大小) [pica]</option>
                  <option value="LEN_point">点 (铅字大小) [point]</option>
                  <option value="LEN_rd">杆 [rd]</option>
                  <option value="LEN_yd">码 [yd]</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_shippingDepth_title">货运长度</span> </td>
              <td colspan="4"><input type="text" name="shippingDepth" size="10" maxlength="20" id="EditProduct_shippingDepth">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_productDiameter_title">产品直径</span> </td>
              <td><input type="text" name="productDiameter" size="10" maxlength="20" id="EditProduct_productDiameter">
              </td>
              <td ><span id="EditProduct_diameterUomId_title">直径度量单位标识</span> </td>
              <td colspan="7"><span class="ui-widget">
                <select name="diameterUomId" id="EditProduct_diameterUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="LEN_A">埃 [A]</option>
                  <option value="LEN_cb">链 [cb]</option>
                  <option value="LEN_cm">厘米 [cm]</option>
                  <option value="LEN_chG">链 (甘特/勘测) [chG]</option>
                  <option value="LEN_chR">链 (拉姆丹/工程) [chR]</option>
                  <option value="LEN_dm">分米 [dm]</option>
                  <option value="LEN_dam">十米 [dam]</option>
                  <option value="LEN_fm">英寻 [fm]</option>
                  <option value="LEN_ft">英尺 [ft]</option>
                  <option value="LEN_fur">浪 [fur]</option>
                  <option value="LEN_hand">手 (马的高度) [hand]</option>
                  <option value="LEN_in">英寸 [in]</option>
                  <option value="LEN_km">千米 [km]</option>
                  <option value="LEN_league">里格 [league]</option>
                  <option value="LEN_lnG">令 (甘特) [lnG]</option>
                  <option value="LEN_lnR">令 (拉姆丹) [lnR]</option>
                  <option value="LEN_m">米 [m]</option>
                  <option value="LEN_u">微米 [u]</option>
                  <option value="LEN_mil">密耳 (千分之一英寸) [mil]</option>
                  <option value="LEN_nmi">英里 (航海/海洋) [nmi]</option>
                  <option value="LEN_mi">英里 (法定/陆地) [mi]</option>
                  <option value="LEN_mm">毫米 [mm]</option>
                  <option value="LEN_pica">12点活字 (铅字大小) [pica]</option>
                  <option value="LEN_point">点 (铅字大小) [point]</option>
                  <option value="LEN_rd">杆 [rd]</option>
                  <option value="LEN_yd">码 [yd]</option>
                </select>
                </span> </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_productWeight_title">产品重量</span> </td>
              <td><input type="text" name="productWeight" size="10" maxlength="20" id="EditProduct_productWeight">
              </td>
              <td ><span id="EditProduct_weightUomId_title">重量度量单位标识</span> </td>
              <td><span class="ui-widget">
                <select name="weightUomId" id="EditProduct_weightUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="WT_dr_avdp">打兰 [dr avdp]</option>
                  <option value="WT_gr">格林 [gr]</option>
                  <option value="WT_g">克 [g]</option>
                  <option value="WT_kg">千克 [kg]</option>
                  <option value="WT_mg">毫克 [mg]</option>
                  <option value="WT_oz">盎司 (英国常衡制) [oz]</option>
                  <option value="WT_oz_tr">盎司 (金衡制) [oz tr]</option>
                  <option value="WT_dwt">本尼威特 [dwt]</option>
                  <option value="WT_lb">磅 (英国常衡制) [lb]</option>
                  <option value="WT_st">英石 [st]</option>
                  <option value="WT_lt">吨 (英制) [lt]</option>
                  <option value="WT_mt">吨 (公制) [mt]</option>
                  <option value="WT_sh_t">吨 (短吨) [sh t]</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_weight_title">重量</span> </td>
              <td colspan="4"><input type="text" name="weight" size="10" maxlength="20" id="EditProduct_weight">
              </td>
            </tr>
            <tr>
              <td ><span id="EditProduct_quantityIncluded_title">已包含的数量</span> </td>
              <td><input type="text" name="quantityIncluded" size="10" maxlength="20" id="EditProduct_quantityIncluded">
              </td>
              <td ><span id="EditProduct_quantityUomId_title">数量度量单位标识</span> </td>
              <td colspan="7"><span class="ui-widget">
                <select name="quantityUomId" id="EditProduct_quantityUomId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="OTH_A">安培 -电流 - A</option>
                  <option value="LEN_A">埃 - A</option>
                  <option value="AREA_A">英亩 - a</option>
                  <option value="VLIQ_bbl">桶 (美) - bbl</option>
                  <option value="DATASPD_bps">b/s - bps</option>
                  <option value="OTH_box">Box - bx</option>
                  <option value="EN_Btu">英国热量单位 - Btu</option>
                  <option value="DATA_b">比特 - B</option>
                  <option value="LEN_cb">链 - cb</option>
                  <option value="EN_cal15">卡 (@15.5c) - cal15</option>
                  <option value="OTH_cd">烛光 -发光度 (发光强度) - cd</option>
                  <option value="LEN_cm">厘米 - cm</option>
                  <option value="LEN_chG">链 (甘特/勘测) - chG</option>
                  <option value="LEN_chR">链 (拉姆丹/工程) - chR</option>
                  <option value="VDRY_cm3">立方分米 - cm3</option>
                  <option value="VDRY_ft3">立方英尺 - ft3</option>
                  <option value="VDRY_in3">立方英寸 - in3</option>
                  <option value="VDRY_m3">立方米 - m3</option>
                  <option value="VDRY_mm3">立方毫米 - mm3</option>
                  <option value="VDRY_yd3">立方码 - yd3</option>
                  <option value="VLIQ_cup">杯 - cup</option>
                  <option value="LEN_dm">分米 - dm</option>
                  <option value="TEMP_C">摄氏度 - C</option>
                  <option value="TEMP_F">华氏度 - F</option>
                  <option value="LEN_dam">十米 - dam</option>
                  <option value="WT_dr_avdp">打兰 - dr avdp</option>
                  <option value="VLIQ_dr">打兰 (美) - dr</option>
                  <option value="OTH_ea">每个 - ea</option>
                  <option value="LEN_fm">英寻 - fm</option>
                  <option value="LEN_ft">英尺 - ft</option>
                  <option value="LEN_fur">浪 - fur</option>
                  <option value="VLIQ_galUK">加仑 (英) - gal</option>
                  <option value="VLIQ_galUS">加仑 (美) - gal</option>
                  <option value="DATASPD_Gbps">Gb/s - Gbps</option>
                  <option value="DATA_Gb">Gb - GB</option>
                  <option value="VLIQ_gi">及耳 (1/4 英制品脱) - gi</option>
                  <option value="WT_gr">格林 - gr</option>
                  <option value="WT_g">克 - g</option>
                  <option value="LEN_hand">手 (马的高度) - hand</option>
                  <option value="AREA_ha">公顷 - ha</option>
                  <option value="EN_HP">马力 - HP</option>
                  <option value="LEN_in">英寸 - in</option>
                  <option value="EN_J">焦耳 - J</option>
                  <option value="TEMP_K">绝对温度 - K</option>
                  <option value="DATASPD_Kbps">Kb/s - Kbps</option>
                  <option value="DATA_Kb">Kb - KB</option>
                  <option value="WT_kg">千克 - kg</option>
                  <option value="LEN_km">千米 - km</option>
                  <option value="EN_Kw">千瓦 - Kw</option>
                  <option value="LEN_league">里格 - league</option>
                  <option value="LEN_lnG">令 (甘特) - lnG</option>
                  <option value="LEN_lnR">令 (拉姆丹) - lnR</option>
                  <option value="VLIQ_L">升 - L</option>
                  <option value="DATASPD_Mbps">Mb/s - Mbps</option>
                  <option value="DATA_Mb">Mb - MB</option>
                  <option value="LEN_m">米 - m</option>
                  <option value="LEN_u">微米 - u</option>
                  <option value="LEN_mil">密耳 (千分之一英寸) - mil</option>
                  <option value="LEN_nmi">英里 (航海/海洋) - nmi</option>
                  <option value="LEN_mi">英里 (法定/陆地) - mi</option>
                  <option value="WT_mg">毫克 - mg</option>
                  <option value="VLIQ_ml">毫升 - ml</option>
                  <option value="LEN_mm">毫米 - mm</option>
                  <option value="OTH_mol">摩尔 -物质  (分子) - mol</option>
                  <option value="WT_oz">盎司 (英国常衡制) - oz</option>
                  <option value="WT_oz_tr">盎司 (金衡制) - oz tr</option>
                  <option value="VLIQ_ozUK">盎司，液体 (英) - fl. oz (UK)</option>
                  <option value="VLIQ_ozUS">盎司，液体 (美) - fl. oz (US)</option>
                  <option value="OTH_pk">Package - pk</option>
                  <option value="WT_dwt">本尼威特 - dwt</option>
                  <option value="OTH_pp">每人 - pp</option>
                  <option value="DATA_PB">PB - PB</option>
                  <option value="LEN_pica">12点活字 (铅字大小) - pica</option>
                  <option value="VLIQ_ptUK">品脱 (英) - pt (UK)</option>
                  <option value="VLIQ_ptUS">品脱 (美) - pt (US)</option>
                  <option value="LEN_point">点 (铅字大小) - point</option>
                  <option value="WT_lb">磅 (英国常衡制) - lb</option>
                  <option value="VLIQ_qt">夸脱 - qt</option>
                  <option value="LEN_rd">杆 - rd</option>
                  <option value="AREA_cm2">平方厘米 - cm2</option>
                  <option value="AREA_ft2">平方英尺 - ft2</option>
                  <option value="AREA_in2">平方英寸 - in2</option>
                  <option value="AREA_km2">平方公里 - km2</option>
                  <option value="AREA_m2">平方米 - m2</option>
                  <option value="AREA_mi2">平方英里 - mi2</option>
                  <option value="AREA_mm2">平方毫米 - mm2</option>
                  <option value="AREA_rd2">平方杆 - rd2</option>
                  <option value="AREA_yd2">平方码 - yd2</option>
                  <option value="VDRY_ST">立方米 - ST</option>
                  <option value="WT_st">英石 - st</option>
                  <option value="VLIQ_Tbs">大汤匙 - Tbs</option>
                  <option value="VLIQ_tsp">茶匙 - tsp</option>
                  <option value="DATASPD_Tbps">Tb/s - Tbps</option>
                  <option value="DATA_Tb">Tb - TB</option>
                  <option value="TF_century">百年 - century</option>
                  <option value="TF_day">日 - day</option>
                  <option value="TF_decade">十年 - decade</option>
                  <option value="TF_hr">小时 - hr</option>
                  <option value="TF_millenium">千年 - millenium</option>
                  <option value="TF_ms">毫秒 - ms</option>
                  <option value="TF_min">分钟 - min</option>
                  <option value="TF_mon">月 - mon</option>
                  <option value="TF_score">二十年 - score</option>
                  <option value="TF_s">秒 - s</option>
                  <option value="TF_wk">周 - wk</option>
                  <option value="TF_yr">年 - yr</option>
                  <option value="WT_lt">吨 (英制) - lt</option>
                  <option value="WT_mt">吨 (公制) - mt</option>
                  <option value="WT_sh_t">吨 (短吨) - sh t</option>
                  <option value="EN_w">瓦 - w</option>
                  <option value="LEN_yd">码 - yd</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="fieldgroup" id="_G34_" style="display:none;">
      <div class="fieldgroup-title-bar">
        <ul>
          <li class="expanded"> <a onClick="javascript:toggleCollapsiblePanel(this, '_G34__body', '展开', '合拢');" title="合拢"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运输</a> </li>
        </ul>
      </div>
      <div id="_G34__body" class="fieldgroup-body" style="display: block;">
        <table cellspacing="0" class="basic-table">
          <tbody>
            <tr>
              <td ><span id="EditProduct_piecesIncluded_title">包含的件数</span> </td>
              <td><input type="text" name="piecesIncluded" size="10" maxlength="20" id="EditProduct_piecesIncluded">
              </td>
              <td ><span id="EditProduct_inShippingBox_title">用货箱吗？</span> </td>
              <td><span class="ui-widget">
                <select name="inShippingBox" id="EditProduct_inShippingBox" size="1">
                  <option value="N">否</option>
                  <option value="Y">是</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_defaultShipmentBoxTypeId_title">缺省运输箱类型标识</span> </td>
              <td><span class="ui-widget">
                <select name="defaultShipmentBoxTypeId" id="EditProduct_defaultShipmentBoxTypeId" size="1">
                  <option value="">&nbsp;</option>
                  <option value="FX10KGBOX">FedEx 10KG Box</option>
                  <option value="FX25KGBOX">FedEx 25KG Box</option>
                  <option value="FXBOX_LRG">FedEx Box (Large)</option>
                  <option value="FXBOX_MED">FedEx Box (Medium)</option>
                  <option value="FXBOX_SM">FedEx Box (Small)</option>
                  <option value="FXENV">FedEx Envelope</option>
                  <option value="FXENV_LGL">FedEx Envelope (Legal)</option>
                  <option value="FXPAK_LRG">FedEx Pak (Large)</option>
                  <option value="FXPAK_SM">FedEx Pak (Small)</option>
                  <option value="FXTUBE">FedEx Tube</option>
                  <option value="YOURPACKNG">Your Packaging</option>
                </select>
                </span> </td>
              <td ><span id="EditProduct_chargeShipping_title">运费</span> </td>
              <td><span class="ui-widget">
                <select name="chargeShipping" id="EditProduct_chargeShipping" size="1">
                  <option value="">&nbsp;</option>
                  <option value="Y">是</option>
                  <option value="N">否</option>
                </select>
                </span> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <table cellspacing="0" class="basic-table">
    </table>
    <table cellspacing="0" class="basic-table">
    </table>
    <table cellspacing="0" class="basic-table">
      <tbody>
        <tr>
          <td ><span id="EditProduct_contentInfoText_title">内容信息文本</span> </td>
          <td colspan="10"><span id="cc_EditProduct_contentInfoText" class="tooltip"> 注意：对于内容选项，请使用内容标签。</span> </td>
        </tr>
        <tr>
          <td >&nbsp;</td>
          <td colspan="10"><input type="submit" class="smallSubmit" name="submitButton" value="更新产品">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>