
/*
 * 子tab展示和隐藏
*/
Std.main(function(){
	Std.dom.united("[action='salaryTypeSelect'] .salaryTypeSelect span").on("click",function(){
		var index  				 = this.parent().index();
		var salarySetupInfor	 = this.parent(".salarySetupInfor");
		var salaryCashInfor      = Std.dom.united(".salaryTypeAssessment .salaryCashInfor",salarySetupInfor);
		var salaryTypeSelectSpan = Std.dom.united(".salaryTypeSelect span",salarySetupInfor);

		salaryCashInfor.hide()[index].show();
		salaryTypeSelectSpan.css("color", "#69533c")[index].css("color", "#f83976");
	});
});

/*
 * 1 - 5 档,tab之间互相切换
*/
Std.main(function(){
	var tabButtonGroup		   = Std.dom("#salarySetupClass_tabButtons");
	var currentSelectedButton  = Std.dom("li.salaryclassCurrent",tabButtonGroup);
	var tabContents			   = Std.dom("#salarySetupClass_contents");
	var currentSelectedContent = Std.dom(".salarySetupInfor.selected",tabContents);

	tabButtonGroup.on("click","li.salaryclassli",function(){
		var currentIndex   = this.index();
		var currentButton  = this;
		var currentContent = tabContents.children(".salarySetupInfor")[currentIndex];

		currentSelectedButton.removeClass("salaryclassCurrent");
		currentSelectedButton = currentButton.addClass("salaryclassCurrent");

		currentSelectedContent.removeClass("selected");
		currentSelectedContent = currentContent.addClass("selected");

		return false;
	});
});

/*
 * 左侧数据修改同步右侧
*/
Std.main(function(){
	var init = [
		/*
		 * 现金
		*/
		function(left,rightTitle,rightContent){
		
			//-------左侧所有文本 input
			var textInputs = Std.dom.united("input[type=text]",left);

			//-------
			var updateData = Std.queue([
				function(){
					//----清除右侧所有
					rightContent.clear();
					rightContent.append(newDiv().html("考核内容： ").css("float","left"))

					//----遍历input,并且重置所有右侧标签值
					Std.dom.united("input[type=checkbox]",left).each(function(){
						var checkbox = this;
						var text 	 = checkbox.parent().lastChild().text().trim();

						if(checkbox.is(":checked")){
							rightContent.append(newDiv("salaryTypeSelect").text(text));
						}
					});
					this.next();
				
				},
				function(){
					Std.dom("span[first]",rightTitle).text("￥" +textInputs[0].dom.value);
					this.next()
				},
				function(){
					Std.dom("span[last]",rightTitle).text("￥" + textInputs[1].dom.value);
					this.next()
				},
				function(){
					Std.dom("div.fr span",rightTitle).text(textInputs[2].dom.value + "%");
					this.next()
				}
			]);


			//-------左侧checkbox点击
			left.on("click","input[type=checkbox]",updateData[0]);
			
			//-------第一个input修改
			textInputs[0].on("keyup",updateData[1]);
			
			//-------第二个input修改
			textInputs[1].on("keyup",updateData[2]);
			
			//-------第三个input修改
			textInputs[2].on("keyup",updateData[3]);

			updateData.go();
		},
		/*
		 * 实操
		*/
		function(left,rightTitle,rightContent){
			//-------左侧所有文本 input
			var textInputs = Std.dom.united("input[type=text]",left);

			var updateData = Std.queue([
				function(){
					Std.dom("span[first]",rightTitle).text("￥" +textInputs[0].dom.value);
					this.next()
				},
				function(){
					Std.dom("span[last]",rightTitle).text("￥" +textInputs[1].dom.value);
					this.next()
				},
				function(){
					Std.dom("div.fl > span",rightContent).text(textInputs[2].dom.value+"%")
					this.next()
				},
				function(){
					Std.dom("div.fr > span",rightContent).text(textInputs[3].dom.value+"%")
					this.next()
				}
			]);

			//-------第一个input修改
			textInputs[0].on("keyup",updateData[0]);
			
			//-------第二个input修改
			textInputs[1].on("keyup",updateData[1]);

			//-------第三个input修改
			textInputs[2].on("keyup",updateData[2]);

			//-------第四个input修改
			textInputs[3].on("keyup",updateData[3]);

			updateData.go();
		},
		/*
		 * 赠送实操
		*/
		function(left,rightTitle,rightContent){
			//--------所有checkbox
			var checkboxList_left  = Std.dom.united("input[type=checkbox]",left);

			//--------输入框
			var inputs_line1 = Std.dom.united("[view-type=line1] input",left);
			var inputs_line2 = Std.dom.united("[view-type=line2] input",left);

			var updateData = function(){
				rightContent.clear();
				rightContent.append(newDiv().append([
					newDom("span","salary-marginL").text(
						"面部赠送实操提成： 面部赠送实操金额 x " + inputs_line1[0].value() + "%" +" x " + inputs_line1[1].value() + "%"
					)
				]));
				if(checkboxList_left[0].is(":checked")){
					rightContent.append(newDiv().append([
						newDom("span","salary-marginL").text(
							"面部赠送实操加入实操考核： 面部赠送实操金额 x " + inputs_line1[0].value()+ "%"
						)
					]));
				}
				rightContent.append(newDiv().append([
 					newDom("span","salary-marginL").text(
 						"身体赠送实操提成： 面部赠送实操金额 x " + inputs_line2[0].value() + "%" +  " x " + inputs_line2[1].value() + "%"
 					)
 				]));
				if(checkboxList_left[1].is(":checked")){
					rightContent.append([
						newDiv().append([
							newDom("span","salary-marginL").text(
								"身体实操加入实操考核: 身体赠送实操金额 x " + inputs_line2[0].value() + "%"
							)
						])
					]);
				}
			};

			//--------左侧checkbox点击
			checkboxList_left.on("click",function(){
				updateData();
			});

			//--------输入框修改
			left.on("keyup","input",function(){
				updateData();
			});

			updateData();
		},
		/*
		 * 购买商品
		*/
		function(left,rightTitle,rightContent){
			//-------左侧所有文本 input
			var textInputs = Std.dom.united("input[type=text]",left);
			
			//--------所有右侧 span
			var contentDataSpan	   = Std.dom.united("span",rightContent);


			var updateData = Std.queue([
				function(){
					var other = Std.dom("[view-type=other]",rightContent);
					//----清除右侧所有
					other.clear();

					other.html(newDom("span").html("提成项： "));

					//----遍历input,并且重置所有右侧标签值
					Std.dom.united("input[type=checkbox]",left).each(function(){
						var checkbox = this;
						var text 	 = checkbox.parent().lastChild().text().trim();

						if(checkbox.is(":checked")){
							other.append(newDom("span").html(text).css("margin-right","20px"));
						}
					});
					this.next()
				},
				function(){
					contentDataSpan[1].text(textInputs[0].dom.value+"%");
					this.next()
				},
				function(){
					contentDataSpan[2].text(textInputs[1].dom.value+"%");
					this.next()
				},
				function(){
					contentDataSpan[3].text(textInputs[2].dom.value+"%");
					this.next()
				}
			]);

			//-------左侧checkbox点击
			left.on("click","input[type=checkbox]",updateData[0]);
			
			//--------第一个input修改
			textInputs[0].on("keyup",updateData[1]);

			//--------第二个input修改
			textInputs[1].on("keyup",updateData[2]);

			//--------第三个input修改
			textInputs[2].on("keyup",updateData[3]);

			updateData.go();
		},
		/*
		 * 客流
		*/
		function(left,rightTitle,rightContent){
			//--------所有text input
			var textInputList	   = Std.dom.united("input[type=text]",left);

			//--------所有右侧 span
			var contentDataSpan	   = Std.dom.united("span",rightContent);

			var updateData = Std.queue([
				function(){
					contentDataSpan[0].text(textInputList[0].dom.value);
					this.next()
				},
				function(){
					contentDataSpan[1].text(textInputList[1].dom.value);
					this.next()
				}
			]);


			//--------第一个input修改
			textInputList[0].on("keyup",updateData[0]);
			
			//--------第二个input修改
			textInputList[1].on("keyup",updateData[1]);

			updateData.go();
		},
		/*
		 * 新客
		*/
		function(left,rightTitle,rightContent){
			//--------所有checkbox
			var checkboxList_left  = Std.dom.united("input[type=checkbox]",left);

			//--------所有text input
			var textInputList	   = Std.dom.united("input[type=text]",left);


			//--------更新右侧
			var updateData	   = function(){
				var data = {
					hide1:"none",
					hide2:"none",
					a:textInputList[0].dom.value,
					b:textInputList[1].dom.value,
					c:textInputList[2].dom.value,
					d:textInputList[3].dom.value,
					e:textInputList[4].dom.value
				};
				
				if(checkboxList_left[0].is(":checked")){
					data.hide1 = "block";
				}
				if(checkboxList_left[1].is(":checked")){
					data.hide2 = "block";
				}
			
				rightContent.html(Std.template("newGuestTemplate").render(data))
			};


			checkboxList_left.on("click",function(){
				updateData();
			});
			textInputList.on("keyup",function(){
				updateData();
			});
			updateData();
		}
	];


	//----------遍历所有 .salarySetupInfor
	Std.dom.united(".salarySetupInfor").each(function(){
		var salaryCashInfor_list = Std.dom.united(".salaryTypeAssessment > .salaryCashInfor",this);

		this.find("[view-type=main]").each(function(i,main){
			/*
			console.log(Std.dom("[view-type=title]",this));
			console.log(Std.dom("[view-type=content]",this));
			console.log("..........");
			*/
			init[i](
				salaryCashInfor_list[i],
				Std.dom("[view-type=title]",main),
				Std.dom("[view-type=content]",main)
			);
		});
	});
});