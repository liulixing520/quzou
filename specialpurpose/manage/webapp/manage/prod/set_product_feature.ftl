<style>
.size li { float:left; padding:3px; text-align:center;}
.size li div { border:1px solid #000; padding:0px 4px; text-align:center;}
</style>

<form name=specForm>
<div class="pageContent"  id="tabBody">
	<div class="tabs" currentIndex="0">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<#list productFeatureCategoryApplList as featureCategory>
						<#assign featureCategoryGeneriv = featureCategory.getRelatedOne("ProductFeatureCategory")?if_exists>
						<input type=hidden name="specId" value="${featureCategoryGeneriv.productFeatureCategoryId?if_exists}"/>
						<input type=hidden name="n[${featureCategoryGeneriv.productFeatureCategoryId?if_exists}]" value="${featureCategoryGeneriv.description?if_exists}"/>
						<input type=hidden name="t[${featureCategoryGeneriv.productFeatureCategoryId?if_exists}]" value="0"/>
						<li><a href="javascript:;"><span>${featureCategoryGeneriv.description?if_exists}</span></a></li>
					</#list>
				</ul>
			</div>
		</div>
		<div class="tabsContent" style="height:300px; overflow: scroll;">
			<#list productFeatureCategoryApplList as featureCategory>
				<div>
					<#assign featureCategoryGeneriv = featureCategory.getRelatedOne("ProductFeatureCategory")?if_exists>
					<#--a href="#" onclick="add_all(${featureCategory_index})">添加全部${featureCategoryGeneriv.description}</a-->
					<#assign productFeatures = featureCategoryGeneriv.getRelated("ProductFeature", Static["org.ofbiz.base.util.UtilMisc"].toList("defaultSequenceNum"))>
					<#list productFeatures as feature>
					<ul class="size">
	  					<li onclick="add('${featureCategory.productFeatureCategoryId}','${feature.productFeatureId}','0','${feature.description}','','${feature.description}')" title="点击添加${feature.description}"><div>${feature.description}</div><a href="#">添加</a></li>
	  				</ul>
					</#list>
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTable no-footer">
		        		
			       	  <tbody id="specBody${featureCategory.productFeatureCategoryId}"></tbody>
    				</table>
				</div>
			</#list>
		</div>
		<div class="col-md-offset-3 col-md-9">
                    <input type="button" class="btn btn-info" id="btn_save" value="保存" />   
            </div>   
	</div>	
</div>	
</form>



<script language="javascript"> 

		var f=document.specForm,ret=[],ret1=[],getFormValue=function(isA,k,i,n){//获取表单值
	 		var elms=f[n?(k+'['+i+']['+n+']'):k];
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
 		};
 		<#---->	
 		var typeId = $('#productTypeId').val();
		if('-1'!=typeId){
		//获取已经开启的规格
		var a=getSaveFormValue(1,'specId'),img=[];
		$(a).each(function(){
			var t=this,valIds=getSaveFormValue(1,'valId['+t+']'),values=[];
			if(valIds){
				$(valIds).each(function(){
					var v=this,commSize=$('#specsBody input[name$="valId'+t+'\]"][value="'+v+'"]').length;//规格对应商品个数
					values.push({valId:v, value:getEditValue('sv',v,'val'), image:getEditValue('sv',v,'img'), relaImg:getSaveFormValue(1,'sv['+v+'][relaImg]'), orderNum:(getEditValue('sv',v,'ord')||0), commSize:commSize, sysVal:getEditValue('sv',v,'sysVal')})
				 });
			    }
			    
			if(values.length){
				if(values.length>1)values.sort(function(a,b){
					return a.orderNum<b.orderNum?-1:(a.orderNum>b.orderNum?1:0) 	    				
				    });
				ret1.push({specId:t, values:values});
			   }
		});
		}	
 			//显示已经选择规格的数据
			var data=$("#ret").data("ret");
			if(data ==null)data = ret1;
			if(data){
				$(data).each(function(){
					var t=this,values=t.values, type=$('#tabBody input[name="t['+t.specId+']"]').val();
					$(values).each(function(){
						add(t.specId, this.valId, type, this.value, this.sysVal);
					})
				});
			}
		//保存规格
		$('#btn_save').bind('click',function(){
			var specIds=getFormValue(1,'specId'),b;
			//把表单数据封闭成规格值
			$(specIds).each(function(){
				var sId=this,obj={specId:sId, name:decodeURIComponent(getFormValue(0,"n["+sId+"]")), 'type':getFormValue(0,"t["+sId+"]"), values:[]},valIds=getFormValue(1,'v['+sId+']');
				if(valIds){
					$(valIds).each(function(){
						var vId=this,v=getFormValue(0, 'd', vId, 'v');
						if(v){
							//获取tr的索引，用来做规格排序用
							var elmId='val'+vId,tr=$('#'+elmId).parents('tr:first')[0];//orderNum:getFormValue(0, 'd', vId, 'n')
							specValue={valId:vId, value:v, orderNum:tr.rowIndex, type:obj.type, specId:sId, sysVal:getFormValue(0, 'd', vId, 'sysVal')};
							obj.values.push(specValue);
						}
					});		
					ret.push(obj);
				}
				else{
					b=1;
					alert('请添加至少一个“'+obj.name+'”规格值!');
					return 0
				}
			});
			if(!b){
				
				//回调函数
				funBack(ret);
				$("#ret").data("ret",ret);
				$('#featureDialog').dialog("close");
			}
		});
		//增加规格值
		function add(id, vid, type, value, image, pdtImgs,sysVal){
			var s='' , elmId='val'+vid;
			if($('#'+elmId).length==0){//如果规格不存在才添加
				var h='<input type=hidden id='+elmId+' name=v['+id+'] value="'+vid+'"/>';
				if(type=='1'){//图片规格
					s+='<tr>';
		            s+='<td class="border06">'+h+'<img src="'+(sysVal||image)+'" width="20" height="20" alt="'+value+'"/><input type=hidden name=d['+vid+'][sysVal] value="'+(sysVal||image)+'"/></td>';
		            s+='<td class="border07"><input name=d['+vid+'][v] type="text" value="'+value+'" class="input40" /></td>';
		            s+='<td class="border07"><img id="img['+vid+']" src="'+image+'" width="20" height="20" align="absmiddle" /> <span>'+getFlash(vid)+'</span></td>';
		            s+='<td class="border07"><span id=span'+vid+'>'+getRelaImg(vid, pdtImgs)+'</span><input type="button" class="input02" value="选择" onclick="select_image('+vid+')"/></td>';
		            s+='<td class="border07"><img src="/portal/seller/images/up.png" alt="向上" onclick="up(this)"/><img src="/portal/seller/images/down.png" alt="向下" onclick="down(this)"/><img src="/portal/seller/images/delete.gif" alt="删除该规格" onclick="del(this,'+vid+')"/></td>';
		           	s+='</tr>'
				}else{
					s+='<tr><td class="border06">'+h+'<input name="d['+vid+'][sysVal]" type="text" value="'+(sysVal||value)+'" class="input40" readonly=readonly /></td>';
		            s+='<td class="border07" style="display:none;"><input name=d['+vid+'][v] type="hidden" value="'+value+'" class="input40" /></td>';
		            s+='<td class="border07"><img src="/portal/seller/images/up.png" alt="向上" onclick="up(this)"/><img src="/portal/seller/images/down.png" alt="向下" onclick="down(this)"/><img src="/portal/seller/images/delete.gif" alt="删除该规格" onclick="del(this,'+vid+')"/></td>';
		            s+='</tr>'
				}
				$('#specBody'+id).append(s);
			}
		};
		//删除规格值
		window.del=function(elm,vid){
			var b;
			$(ret1).each(function(){
				$(this.values).each(function(){
					if(vid==this.valId && this.commSize>0)b=1
				})
			});		
			if(b){
				alert('此规格已有相关货品使用，请先删除相关货品!');
			}else{
				$(elm).parents('tr').remove()
			}
		};
		//获取父节点
		var getParent=function(e,l){
			for(var i=0; i<l;i++){
				e=e.parentElement?e.parentElement:e.parentNode;
			}
			return e
		};
		//上移
		window.up=function(elm){
			var tr=$(elm).parents('tr:first')[0],i=tr.rowIndex,t=getParent(tr,2);
			if(tr && i!=1){
				var obj=t.rows[i-1];
				getParent(tr,1).insertBefore(tr, obj);				
			}
		};
		//下移
		window.down=function(elm){
			var tr=$(elm).parents('tr:first')[0],i=tr.rowIndex,t=getParent(tr,2);
			if(tr&&i<t.rows.length-1){
				var obj = t.rows[i+1];
				getParent(tr,1).insertBefore(tr, obj.nextSibling);
			}			
		};
	specToRow=function specToRow(r, p, a, i, l){
	
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
 	
</script>