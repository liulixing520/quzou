<script language="javascript"> 


//换商品大类

$(document).ready(function(){
	getChild('PortalRootCat','oneCategoryId','请选择一级分类');
});

function getChild(productCategoryId,selectId,title){
	 jQuery.ajax({
            url: 'getChild?isCategoryType=false&isCatalog=false&productCategoryId='+productCategoryId,
            type: 'POST',
            error: function(msg) {
            },
            success: function(thisList) {
            	var optStr="";
            	for(var i=0;i<thisList.length;i++){
            		var thisData=thisList[i]; 
            		if(thisData.attr){
            			optStr+="<option value='"+thisData.attr.id+"'>"+thisData.title+"</option>";
            		}
            	}
                jQuery('#'+selectId).html(optStr);
            }
        });
}
$('#oneCategoryId').bind('change',function(){
	getChild(this.value,'twoCategoryId','请选择二级分类');
});	
$('#twoCategoryId').bind('change',function(){
	getChild(this.value,'productTypeId','请选择三级分类');
});	
function ckme(jo){
	if (jo.attr("id") == "sigleGood"){
		if(confirm('切换将会有可能无法保存当前输入的属性和规格内容，确定要切换吗？')){
			$("#specGood").hide();
			$("#specGoodDiv").hide();
			$("#sigleGood").show();
			<#--删除子商品，如果有订单不能改变-->
		}else{
			$("#r2").attr("checked","checked");
		}
	} else {
		$("#specGood").show();
		$("#specGoodDiv").show();
		$("#sigleGood").hide();
	}
}
var last_add=0;
var fn=function(i,n){//生成变量名
		return 'v['+i+']['+n+']';
	}
	

	
//换商品类型
var elm_lastIndex = 0; //$("#productTypeId").options.selectedIndex;
$('#productTypeId').bind('change',function(){
	//设置		
	//var lastIndex=$(this).attr('lastIndex');
	var typeId = this.value;
	//alert("132:"+elm_lastIndex);
	if(confirm('切换类型将会有可能无法保存当前输入的属性内容，确定要切换吗？')){
		//显示品牌和自定义属性
		showBrandsAndAttrib(typeId);
		//显示规格
		//document.getElementById('btn_add_spec').href='setFeatureCategoryByCategory?<#if productId?has_content>&productId=${productId?if_exists}&</#if>productCategoryId='+this.options[this.options.selectedIndex].value;
		$("#btn_add_spec").attr("onclick", "operFeatureDialog('setFeatureCategoryByCategory?<#if productId?has_content>&productId=${productId?if_exists}&</#if>productCategoryId="+this.options[this.options.selectedIndex].value+"')");
		//changeFeature(typeId);
		//fn_last(this,this.options.selectedIndex);
		elm_lastIndex = this.options.selectedIndex;
	}else{
		//恢复原来的商品类型
		this.options.selectedIndex=elm_lastIndex; //lastIndex;
	}
});
fn_last=function(elm,i){
	$(elm).attr('lastIndex',i)
};
var showBrandsAndAttrib=function(typeId){
	$.getJSON('<@ofbizUrl>/getProductBrandsAndAttr</@ofbizUrl>',{productCategoryId:typeId},function(r){
		if(r){
			//显示品牌数据
			var elm=$('#brandName');
			elm.html("<option value='-1'>请选择品牌</option>");
			$(r.brands).each(function(){
				elm.append("<option value='"+this.id+"'>"+unescape(this.brandName)+"</option>");
			});	
			//显示自定义属性
			var f={},str='';
			if(r.attribs)$(r.attribs).each(function(i){
				var g=this.attributeGroupId,val;
				//if(g && !f[g]){
					//f[g]=1;
					//str+='<tr class="title02a"><td colspan="2" align="left">&nbsp;'+(r.groups[g]||'')+'</td></tr>';
				//}
				str+='<tr id="background_tr"><td class="border03 width15">'+this.attributeName+'：</td><td class="border02 width85">';
				switch(this.entryWay){
					case 'TEXT':
						str+='<input type="text" name="attr_'+this.attributeId+'" id="'+this.attributeId+'" class="input200" maxlength="30"/>';break;
					case 'TEXTAREA':
						str+='<textarea name="attr_'+this.attributeId+'" cols="45" rows="5" class="textarea01" maxlength="120" id="'+this.attributeId+'"></textarea>';break;
					case 'SELECT':
						str+='<select name="attr_'+this.attributeId+'" id="'+this.attributeId+'"><option value="">请选择</option>';
						val=this.inputValue;
						if(val){
							$(val).each(function(){
								str+='<option value="'+escape(this.optionalId)+'">'+this.optionalName+'</option>';
							});
						}
						str+='</select>';
				}
				str+='<span id="msg_'+this.attributeId+'" style="display:none" class="err"></span>';
				str+='</td></tr>';
			});	
			$('#attribBody').html(str);		
		}
	})
},fn_last=function(elm,i){
	$(elm).attr('lastIndex',i)
};	
<#if entity?has_content>
	<#if entity.isVirtual=="Y">
		$("#specGood").show();
		$("#specGoodDiv").show();
		$("#sigleGood").hide();
		$("#r2").attr("checked","checked");
	<#else>
		$("#specGood").hide();
		$("#specGoodDiv").hide();
		$("#sigleGood").show();
	</#if>
<#else>
	$("#specGood").hide();
	$("#specGoodDiv").hide();
	$("#sigleGood").show();
</#if>
$(document).ready(function(){
fn_last($("#productTypeId"),$("#productTypeId").get(0).selectedIndex);	
<#if entity?has_content &&entity.primaryProductCategoryId?has_content>
	jQuery.ajax({
        url: "getFeatureCategoryByCategoryId",
        type: 'POST',
        data: {productCategoryId : '${entity.primaryProductCategoryId?if_exists}',productId : '${entity.productId?if_exists}'},
        error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
			jQuery('#productFeatures').html(msg);
        }
    });
</#if>
	$("#EditProduct").validate({
	  	rules: {
		    description: {
		      required: false,
		      rangelength: [0, 120]
		    }
	  	},
	  	submitHandler: function(form) {
            form.submit();
        }
	});
});
function operFeatureDialog(initUrl, backJs, width, height) {
	 $('#featureDialog').dialog({
        bgiframe: true,
        autoOpen: false,
        height:  400,
        width: 620,
        open: function(event,ui) {
            jQuery.ajax({
                type: "post",
                url: initUrl,
                cache: false,
                success: function(data) {
                	$('#featureDialog').html(data);
                },
                error: function(xhr, reason, exception) {}
            });
        },
        close: function() {$('#featureDialog').dialog( 'destory' ) ; }
    });
    $('#featureDialog').dialog("open"); 
}
function iframeCallbackOnsubmit(obj, navTabAjaxDone){
	var primaryProductCategoryId = $("#primaryProductCategoryId").val();
	if(primaryProductCategoryId==''){
		alert("请选择商品分类！");
		return false;
	}else{
		//jQuery("#productCategoryIdError").html("");
	}
	var form =document.getElementById(obj);
	if(validateForm(form)==undefined){
		iframeCallback(form, navTabAjaxDone);
		form.submit();
		<#--formAction = document.EditProduct.action;
		if(formAction.indexOf('updateProduct')>0){
			iframeCallback(form, navTabAjaxDone);
			form.submit();
		}
		else{
			jQuery.ajax({
		        url: document.EditProduct.action,
		        type: 'POST',
		        data: jQuery("#EditProduct").serialize(),
		        error: function(msg) {
		            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		        },
		        success: function(msg) {
		        	alert("创建成功！");
					jQuery('#EditProductDiv').html(msg);
					$('#EditProductDiv').initUI();
		        }
		    });
	    }-->
	}else{
		return false;
	}
}
function changeFeature(productCategoryId){
   jQuery.ajax({
        url: "getFeatureCategoryByCategoryId",
        type: 'POST',
        data: {productCategoryId : productCategoryId<#if productId?has_content>,productId : '${productId?if_exists}'</#if>},
        error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
			jQuery('#productFeatures').html(msg);
        }
    });
}
delete_rate=function(p, m){
		if(!m || confirm('确认要删除该关联商品吗？')){
			$('#body_assoc input[name="product_assocs"][value="'+p+'"]').parents('tr:first').remove();
		}
	}
delete_configs=function(p, m){
	if(!m || confirm('确认要删除该配件商品吗？')){
		$('#body_config input[name="product_configs"][value="'+p+'"]').parents('tr:first').remove();
	}
}
delete_categorys=function(p, m){
	if(!m || confirm('确认要删除该扩展分类吗？')){
		$('#body_category input[name="product_categorys"][value="'+p+'"]').parents('tr:first').remove();
	}
}
function delOrAddFeature(productId,productFeatureId){
	jQuery.ajax({
        url: "delOrAddFeature",
        type: 'POST',
        data: {productId : productId,productFeatureId : productFeatureId},
        error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
        }
    });
}
function funBack(a){
	  //获取规格值
	  var specArr=a,trData=[];
	  var html='',vhtml='';
	  //增加表头
	  html+='<tr class="title02">';
	  html+='<td class="border07 width15">货号</td>';
	  $(specArr).each(function(){
	      var specId=this.specId,type=this.type;
 		  //表头列
	      html+='<td class="border07">'+this.name+'</td>';	      
  	      //规格值隐藏变量      
	  		html+='<input type=hidden name=specId value='+specId+' />';
	      	html+='<input type=hidden name=st['+specId+'] id=st['+specId+'] value='+type+' />';
	      	var c = 0;
	     	 $(this.values).each(function(n){
		         var valId=this.valId,elm;
		         html+='<input type=hidden name="valId_'+specId+'_'+ c +'" value='+valId+' />';
		         html+='<input type=hidden name="valId['+specId+']" id="valId['+specId+']" value='+valId+' />';
		         html+='<input type=hidden name="sv['+valId+'][val]" id="sv['+valId+'][val]" value='+this.value+' />';
		         html+='<input type=hidden name="sv['+valId+'][sysVal]" value="'+this.sysVal+'"/>';//系统规格值(用来显示)
		         if(this.orderNum)html+='<input type=hidden name="sv['+valId+'][ord]" value="'+this.orderNum+'"/>';
		         c++;
             });
     });
     updateSpecColumns(specArr);
     html+='<td class="border07 width20">零售价</td>';
     html+='<td class="border07 width10">市场价</td>';
     html+='<td class="border07 width10">成本价</td>';
     html+='<td class="border07 width5">排序</td>';
     html+='<td class="border06 width5">操作</td>';
     html+='</tr>';
     $('#specsHead').html(html);
     //如果是第一次开启规格才生成货品
     var rid=$('#specsBody tr:last input[name="rid"]').val()||0;
     if(rid==0){			
		//把数据转为行数据
		specToRow(trData, [], specArr,0,specArr.length);
		//增加数据
        $(trData).each(function(){
	      	vhtml += addRow(0, ++last_add, this)
       	});
        $('#specsBody').html(vhtml);
        $('#specsDiv').show();
        $('#specGoodDiv').show();
     }else{//2010.6.22商品初次保存没有开启规格
		if($('#specsDiv').css('display')=='none'){
			$('#specsDiv').show();
        }
	 }
     vhtml=null;       	       			
     html=null;
}
	
updateSpecColumns=function(newSpecs){	
	//更新规格对应的td
	var specIds=getSaveFormValue(1,'specId'),state={};//原规格Id
	$(specIds).each(function(){//获取原来的规格
		var specId=this;
		state[specId]=0;
	});
	//生成cell
	$('#specsBody tr').each(function(i){ 
		var h='',tr=this,td=$(tr).children('td:eq(1)'),rid=$(tr).find("input[name='rid']").val();
		$(newSpecs).each(function(){
			  var specId=this.specId,cell=$(tr).children('td[specId='+specId+']');
			  if(!cell.length)
				    h+='<td class="border07" specId="'+specId+'">'+addCell(1, rid, specId)+'</td>';
			  else
					  td=cell;
			  state[specId]=1;
		})
		if(h&&td)td.after(h);
	});		
	//移除已经被删除的规格
	$('#specsBody tr td[specId]').each(function(){
		var specId=$(this).attr('specId');
		if(!state[specId])$(this).remove();
	});
	return state
}	
var fn_n=function(preStr,i){//生成变量名
		return preStr+i;
	}
addRow=function(ept, i, colsData){
	//增加子商品行
	var h='<tr>';
	//商品序号
	h+='<input type="hidden" name="rid" id="rid" value="'+i+'"/>';	
	h+='	<td class="border07"><input type="text" name="'+fn_n('sp_goodsNo_',i)+'" class="input100 textInput" value="" maxlength="30" size="10"/></td>';
	//显示规格值
	$(colsData).each(function(){
		h+='<td class="border07" specId="'+this.specId+'">'+addCell(ept, i, this)+'</td>';
	});
    h+=' 	<td class="border07"><input type="text" name="'+fn_n('sp_price_',i)+'" class="specTxt textInput digits" maxlength="10" size="10"/>';
    h+=' 	<td class="border07"><input type="text" name="'+fn_n('sp_marketPrice_',i)+'" class="specTxt textInput digits" maxlength="10" size="10"/></td>';
    h+=' 	<td class="border07"><input type="text" name="'+fn_n('sp_averageCostPrice_',i)+'" class="specTxt textInput digits" maxlength="10" size="10"/></td>';
    h+='     <td class="border07"><input type="text" name="'+fn_n('orderNum_',i)+'" class="specTxt textInput digits" maxlength="8" size="5"/></td>';
    h+='	<td class="border06"><input name="input3" type="button" class="input02" value="删除" onclick="delComm(this,'+i+')"/></td>';
    h+=' </tr>';		
	return h
}
specToRow=function specToRow(r, p, a, i, l){
	/*
	返回规格每个tr的数据数组
	r:返回数值
	p:当前路径数组
	a:源数据数组
	i:当前处理索引
	l:源数据数组长度
	*/
	if(i<l){
		var values=a[i].values;
		if(i+1==l){
			$(values).each(function(){
				r.push(p.concat(this));
			});
		}else{
			$(values).each(function(){
				p.push(this);
				specToRow(r, p, a, i+1, l);
				p.pop();
			});			
		}
	}
}
addCell=function(ept, i, cellData){
//增加列
	var h='';
	if(ept){
		var onclick='showSpecValuesLay(this,'+i+',\'a\','+cellData+',-1)';
		h+='<span class="specMenu" onclick="'+onclick+'">请选择</span><input type=hidden name="'+fn(i,'spec'+cellData)+'"/>';
}else{
	var onclick='showSpecValuesLay(this,'+i+',\'u\','+cellData.specId+','+cellData.valId+')';
	if(cellData.type=='1'){
    	h+='	<input type=hidden name="'+fn(i,'spec'+cellData.specId)+'" value="'+cellData.value+'"/><img class="specImage" onclick="'+onclick+'" src="'+cellData.image+'" alt="'+cellData.value+'" name="" width="26" height="26" align="absmiddle" style="background-color: #006699" />';
}else{
	h+='	<input onclick="'+onclick+'" type="text" name="'+fn(i,'spec'+cellData.specId)+'" class="specTxt" value="'+cellData.value+'" readonly=readonly/>';
}
h+='<input type="hidden" name="'+fn(i,'valId'+cellData.specId)+'" id="'+fn(i,'valId'+cellData.specId)+'" value="'+cellData.valId+'"/>' 
		}		
		return h		
 	}
 	//添加一个货品
 	$('#btnAddGood').click(function(){
 		//如果已经打开规格
		var a=getSaveFormValue(1,'specId');
 		if(a&&a.length){
 			var html,rid=$('#specsBody tr:last input[name="rid"]').val()||0,i;
 			if(rid||rid==0){
 				var specIds=getSaveFormValue(1,'specId'),rid=parseInt(rid)+1;
				//新增商品序号
				html = addRow(1, rid, specIds)
 				$('#specsBody').append(html);
 			}
 		}
 	});
 	//关闭规格
 	$('#btnCloseSpec').click(function(){
 		var productId=$('#productId').val(),fn=function(){
 			$('#specsDiv').hide();
 			$('#specsBody').empty();
			//显示全局
			$('#globalInfo').show(); 
			
 		};
		if(confirm('关闭规格后现有已添加商品的数据将全部丢失,确认要关闭规格吗?')){
			if(productId){
				$.getJSON('<@ofbizUrl>/findProductOrderAssoc</@ofbizUrl>',{productId:productId},function(r){
					if(r&&r.status=='ok'){ 	
						fn()
					}else{
						alert('由于该商品有订单存在,暂不能关闭规格!')
					}
				});				
			}else{
				fn()
			}
		}
 	});
 	//获取表单值getEditValue('sv',vId,'val')
 	var getEditValue=function(pre, id, name){
 		var k = pre+'['+id+']'+(name?'['+name+']':''),v=getSaveFormValue(0,k);
 		return v
 	};
 	//删除子商品
 	window.delComm=function(elm, rid){
 		var productIdTo=getEditValue('v',rid,'cid');
	 	if(confirm('商品删除后将不能恢复，确认要删除?')){	
			if(productIdTo){
				$.getJSON('<@ofbizUrl>/findProductOrderAssoc</@ofbizUrl>',{<#if productId?has_content>productId:${productId?if_exists},</#if>productIdTo:productIdTo},function(r){
					if(r){
						if(r.status=='ok')
							$(elm).parents('tr').remove()
						else if(r&&r.num)
							alert('由于商品存在订单删除失败!');
					}
				}); 		
	 		}
			else{
 				$(elm).parents('tr').remove()
 			}	 		
 		}
 	}
 	var fEd=document.EditProduct;
   function getSaveFormValue(isA,k){
   		//获取表单值
 		var elms=fEd[k];
 		if(elms){
 			if(isA){
 				var vs=[];
 				$(elms).each(function(){
 					vs.push(this.value)
 				});
 				return vs 
 			}
 			return elms.value
 		}
 	}
//更新规格值
window.uptSpecValue=function(elm, i, specId, specValueId, value, image){
	var h=addCell(0, i, {specId:specId, valId:specValueId, type:getEditValue('st',specId), value:value, image:image});
	$('#specLay').hide();
	$('#specsBody input[name="'+fn(i,'spec'+specId)+'"]').parents('td:first').html(h);
}
 	//选择规格值浮层
 	window.showSpecValuesLay=function(elm, idx, opera, specId, specValueId){
 		var id='specLay',values=[];
 		//获取规格编号到specIds
 		var specIds=getSaveFormValue(1,'specId'),rowVals={};
 		if(specIds){
 			//获取所有商品规格值到rowVals
 			//arr=getSaveFormValue(1,'rid');
 			arr=document.getElementsByName('rid');
 			arr.length&&$(arr).each(function(i, o){
				var s='',c,id=o;
 				//去掉当前行
 				
 				if(parseInt(idx)!=parseInt(id.value)){	
	 				$(specIds).each(function(j, sid){
	 					//var v=getEditValue('v',id,'valId'+sid);
	 					var v=document.getElementById('v['+id.value+'][valId'+sid+']').value;
	 					s+=(v||'')+',';
						
	 				})
	 				rowVals[s]=1
 				}
 			}); 
 			//获取当前规格值(当前值用#,替换)
 			var s='',h='',type=$('st['+specId+']').val();
 			$(specIds).each(function(j, sid){
 				var v=getEditValue('v',idx,'valId'+sid);
 				//alert(" specId="+specId+ "循环前面的行===" + sid);
 				//alert(v);
 				//var v=document.getElementById('v['+idx+'][valId'+sid+']').value;
 				s+=(specId!=sid?v:'#')+','
 			});	
			
	 		//获取规格值
	 		arr=document.getElementsByName('valId['+specId+']');
	 		//arr=f['valId['+specId+']'];
	 		arr.length&&$.each(arr,function(j, vId){
	 			//var val=getEditValue('sv',vId,'val'); //取每个规格对应的规格值
	 			var val=document.getElementById('sv['+vId.value+'][val]').value;
	 			//alert(val);
	 			var img=getEditValue('sv',vId.value,'img'), obj={valId:vId.value, value:val, image:img, 'type':type};
	 			values.push(obj)
	 		});
	 		//生成浮层HTML
	 		h='<ul>';
	 		if(values.length){
		 		$.each(values,function(j, o){
		 			var dis=rowVals[s.replace('#,',o.valId+',')],onclick=dis?'':' onclick="uptSpecValue(this, '+idx+', '+specId+', '+o.valId+', \''+o.value+'\','+(o.image?'\''+o.image+'\'':null)+')"';
		 			//alert(s);
		 			if(o.type!='1'){
		 				h+='<li><span class="'+(dis?'invSpecTxt':'specSelTxt')+'"'+onclick+'>'+o.value+'</span></li>'
		 			}else{
		 				h+='<li><img class="'+(dis?'invSpecImage':'specSelImage')+'" src="'+o.image+'" width="20" height="20" alt="'+o.value+'"'+onclick+'/></li>'
		 			}
		 		});
		 		h+='</ul>';
		 		//画浮层
		 		if(!$('#'+id).length){//第一次
		 			$(document.body).append('<div id='+id+' class="lay_27" style=position:absolute;display:none; ></div>');
		 			//滚动消失
		 			$('#list').bind('scroll',function(){
						$('#'+id).hide()
					});
		 			//点击空白隐藏
		 			$(document).click(function(e){
		 				var t = e.target,o = $('#'+id);
		 				if(e.target!=elm&&!(o[0].contains&&o[0].contains(t))
						&&!(o[0].compareDocumentPosition&&o[0].compareDocumentPosition(t)==20))
							o.hide();
		 			})
		 		}
		 		var src=$(elm),off=src.offset();
				//显示浮层
				$('#'+id).css({top:off.top+src.height()+5,left:off.left+src.width()+5}).html(h).show();	 		
			}
	 		arr=null;
	 		rowVals=null;
	 		values=null;
	 		var e = getEvent();
	 		e.stopPropagation&&e.stopPropagation();
	 		e.cancelBubble = true;
	 	
 		}
 	}
//获取事件对像
function getEvent(){
	var e=window.event,a=getEvent.caller;
	if(!e){
		while(a){
			if(a.arguments){
				e=a.arguments[0];				
				if(e && typeof e=='object' && e.type && e.keyCode) break;				
			}				
			a=a.caller				
		}
	}	 
	return e
}
function categoryBringBack(productCategoryId,productCategoryName){
	jQuery('#primaryProductCategoryId').val(productCategoryId);
	jQuery('#productCategoryName').html(productCategoryName);
	$.pdialog.closeCurrent();
}
</script>