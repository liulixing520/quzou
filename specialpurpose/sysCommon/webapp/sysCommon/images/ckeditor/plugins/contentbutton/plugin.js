CKEDITOR.plugins.add('contentbutton', {
	init: function(a){
		var b = a.addCommand('contentbutton', {
	        exec:function(editor){
	        	openEntity();
	        }
		});
		a.ui.addButton('contentbutton', {
		label: '插入内容',
		command: 'contentbutton',
		icon: this.path + 'logo_ckeditor.png'
		});
	}
});

function openEntity() {
	var dlgid = "dialog";
    var options = {};
    options.title = "内容页面";
    options.width =  '780',
    options.height = '390';
    var url="SearchContentTemplate";
    $.Dialog.open(url, dlgid, options)
}
