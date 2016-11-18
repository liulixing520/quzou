CKEDITOR.plugins.add('linkbutton', {
	init: function(a){
		var b = a.addCommand('linkbutton', {
	        exec:function(editor){
	        	open("editor1");
	        }
		});
		a.ui.addButton('linkbutton', {
		label: '弹出页面',
		command: 'linkbutton',
		icon: this.path + 'logo_ckeditor.png'
		});
	}
});

function open(id) {
	var dlgid = "dialog";
    var options = {};
    options.title = "页面展现";
    options.width =  '780',
    options.height = '390';
    var url="SearchData?id="+id;
    $.Dialog.open(url, dlgid, options)
}
