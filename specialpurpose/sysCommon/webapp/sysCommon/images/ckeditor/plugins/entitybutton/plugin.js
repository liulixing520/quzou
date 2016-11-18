CKEDITOR.plugins.add('entitybutton', {
	init: function(a){
		var b = a.addCommand('entitybutton', {
	        exec:function(editor){
	        	openEntity("editor1");
	        }
		});
		a.ui.addButton('entitybutton', {
		label: '弹出页面',
		command: 'entitybutton',
		icon: this.path + 'logo_ckeditor.png'
		});
	}
});

function openEntity(id) {
	var dlgid = "dialog";
    var options = {};
    options.title = "页面展现";
    options.width =  '780',
    options.height = '390';
    var url="EntityDesignForm?id="+id;
    $.Dialog.open(url, dlgid, options)
}
