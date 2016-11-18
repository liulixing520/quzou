    function RowCopyUtility(opts) {  
      // 表格Id  
      this.tableId = opts.tableId;  
      // 分组内有多少行  
      this.rowGroupNumber = opts.rowGroupNumber;  
      // 一组内Button对应的方法Map(key=Button value, value=对应方法名)  
      // 所有方法都应以 function (idx) 方式调用  
      this.buttonHandlers = opts.buttonHandlers;  
        
      this._countForRowsGroup = -1;  
      this._keyForRow = -1;  
      
      this.getTargetRowGroup = function(groupIdx) {  
      
        var rows = [];  
        if (groupIdx > 0) {  
          for(var i=1; i<this.rowGroupNumber+1; i++) {  
            rows[i-1] = $("#row" + i + "_" + groupIdx);  
          }  
        } else {  
          for(var i=0; i<this.rowGroupNumber; i++) {  
            rows[i] = $("#" + this.tableId + " tr[id]").eq(i);  
          }  
        }  
        return rows;  
      };  
      
      this.addRow = function (groupIdx, needCopyValue) {  
      
        if (this._countForRowsGroup == -1) {  
          this._countForRowsGroup = ($("#" + this.tableId + " tr[id]").length - 1)/this.rowGroupNumber;  
          this._keyForRow =  parseInt($("#" + this.tableId + " tr[id]:not(#row_add):last").attr("id").split("_")[1]) + 1;  
        }  
      
        if (groupIdx == 0) {  
          var firstRow = $("#" + this.tableId + " tr[id]:first");  
          var currentIdx = firstRow.attr("id").split("_")[1];  
          groupIdx = currentIdx;  
        }  
      
        var regForId = new RegExp("^(\\w+_)" + groupIdx + "$");  
        var regForName = new RegExp("^(\\w+_)" + groupIdx + "$");  
        var regForRadioId = new RegExp("^(\\w+_)" + groupIdx + "(.*)$");  
      
        var targetRows = this.getTargetRowGroup(groupIdx);  
      
        // 重要：注意闭包参数的作用域  
        var idx = this._keyForRow;  
      
        for(var i=0; i<targetRows.length; i++) {  
          // clone target rows  
          var cloneRow = targetRows[i].clone(false);  
          var newRowId = cloneRow.attr("id").split("_")[0] + "_" + idx;  
          cloneRow.attr("id", newRowId);  
      
          var radios = [];  
          cloneRow.find("[id]").each(function() {
              var id = $(this).attr("id");  
              var oldId = id;  
              var name = $(this).attr("name");  
               
              id = id.replace(regForId, "$1" + idx);  
              $(this).attr("id", id);  
               
              var newname = name.replace(regForName, "$1" + idx);  
              $(this).attr("name", newname);  
                
              if ($(this).hasClass("hasDatepicker")) {  
                  $(this).removeClass("hasDatepicker");  
              }  
              if(name=="deteDepartmentId"||name=="deteCertificateType"){
            	  if (needCopyValue) {  
                      $(this).val(document.getElementById(oldId).value);  
                  } 
              }
              if ($(this).attr("type") == "checkbox") {  
                  if($(this).next().attr("for") != "") {  
                      $(this).next().attr("for", id);  
                  }  
                  if (!needCopyValue) {  
                      $(this).attr("checked", "");  
                  }  
              }  
              else if ($(this).attr("type") == "radio") {             
                  id = id.replace(regForRadioId, "$1" + idx);  
                  $(this).attr("id", id);  
               
                  var radio = new Object();  
                  radio.id = id;  
                  radio.oldId = oldId;  
                  radio.name = name;  
                  radio.newname = newname;  
                  // IE7's Bug  
                  radio.checked = document.getElementById(oldId).checked;  
                  radios[radios.length] = radio;  
               
                  if($(this).next().attr("for") != "") {  
                      $(this).next().attr("for", id);  
                  }  
                  
                  if (!needCopyValue) {  
                      $(this).attr("checked", "");  
                  }  
              }  
              else if ($(this).attr("tagName") == "SELECT") {  
                  if (needCopyValue) {  
                      $(this).val(document.getElementById(oldId).value);  
                  }  
              }  
              else if ($(this).attr("tagName") == "TEXTAREA" ||   
                       $(this).attr("type") == "text" ||   
                       $(this).attr("type") == "hidden") {  
                  if (!needCopyValue) {  
                      $(this).val("");  
                  }  
              }  
          });  
     
          // insert into document  
          cloneRow.insertAfter("#" + this.tableId + " tr:last");  
      	  //cloneRow.insertAfter("#row1_" +groupIdx);  
          // replace name for radio  
          for(var n=0; n<radios.length; n++) {  
             document.getElementById(radios[n].id).outerHTML =  
               document.getElementById(radios[n].id).outerHTML.replace(radios[n].name, radios[n].newname);  
             // IE7's Bug  
             document.getElementById(radios[n].oldId).checked = radios[n].checked;  
          }  
      
          // Event Handler  
          var maps = this.buttonHandlers;  
          cloneRow.find("input:button").each(function() {  
             var value = $(this).attr("value");  
              
             var funcName = maps[value];  
             if (funcName != undefined) {           
                 var func = null;  
                 func = function() { eval(funcName + "(" + idx + ")"); };  
                      
                 if (func != null) {  
                   $(this).attr("onclick", "");  
                   $(this).unbind("click");  
                   $(this).attr("onclick", "").click(func);  
                 }  
             }  
          });  
        }  
      
        this._countForRowsGroup++;  
        this._keyForRow++;  
         
      };  
      
      
      this.copyRow = function(groupIdx) {  
        this.addRow(groupIdx, true);  
      };  
      
      this.deleteRow = function(groupIdx) {  
      
        if (this._countForRowsGroup == -1) {  
          this._countForRowsGroup = ($("#" + this.tableId + " tr[id]").length - 1)/this.rowGroupNumber;  
          this._keyForRow =  parseInt($("#" + this.tableId + " tr[id]:not(#row_add):last").attr("id").split("_")[1]) + 1;  
        }  
      
        var allRows = $("#" + this.tableId + " tr[id]");  
        var miniRowsCount = this.rowGroupNumber + 1;  
        var tbl = $("#" + this.tableId);  
      
        /*
        if (allRows.length == miniRowsCount) {  
          tbl.find("input:text").each(function() { $(this).val(""); });  
          tbl.find("textarea").each(function() { $(this).val(""); });  
          tbl.find("input:hidden").each(function() { $(this).val(""); });  
          tbl.find("input:radio").each(function() { $(this).attr("checked", ""); });  
          tbl.find("input:checkbox").each(function() { $(this).attr("checked", ""); });  
          tbl.find("select").each(function() { document.getElementById($(this).attr("id")).selectedIndex = 0; });  
          tbl.find(".fg-common-field-errored").each(function() {  
            $(this).removeClass("fg-common-field-errored");  
          });  
          return;  
        }  
      	*/
        for(var i=1; i<this.rowGroupNumber+1; i++) {  
          tbl.find("#row" + i + "_" + groupIdx).remove();  
        }  
      
        this._countForRowsGroup--;  
      };  
      
    }  