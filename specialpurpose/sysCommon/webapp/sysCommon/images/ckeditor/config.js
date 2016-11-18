/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.language = 'zh-cn';
	config.uiColor = '#14B8C4';
	config.fullPage= true;
	config.allowedContent= true;
	
};
CKEDITOR.editorConfig = function( config )
{		
		//添加自定义组件
		config.extraPlugins="linkbutton,entitybutton,contentbutton";
        //config.toolbar = 'MyToolbar';
		config.uiColor = '#14B8C4';
		config.toolbar_MyToolbar =
        [
                { name: 'document', items : [ 'Source','NewPage','Preview' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
            { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                '/',
                { name: 'styles', items : [ 'Styles','Format' ] },
                { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
            { name: 'insert', items :[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                 ,'Iframe' ] },
                { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
                { name: 'tools', items : [ 'Maximize','-','About','linkbutton' ,'entitybutton','contentbutton'] }
        ];
        config.toolbar_MyToolbar1 =
        [
                { name: 'document', items : [ 'Source','NewPage','Preview' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
            { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                '/',
                { name: 'styles', items : [ 'Styles','Format' ] },
                { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
            { name: 'insert', items :[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                 ,'Iframe' ] },
                { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
                { name: 'tools', items : [ 'Maximize','-','About','linkbutton'] }
        ];
        config.toolbar_MyToolbar2 =
        [
                { name: 'document', items : [ 'Source','NewPage','Preview' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
            { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                '/',
                { name: 'styles', items : [ 'Styles','Format' ] },
                { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
            { name: 'insert', items :[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                 ,'Iframe' ] },
                { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
                { name: 'tools', items : [ 'Maximize','-','About','entitybutton'] }
        ];
        config.toolbar_MyToolbar3 =
        [
                { name: 'document', items : [ 'Source','NewPage','Preview' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
            { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                '/',
                { name: 'styles', items : [ 'Styles','Format' ] },
                { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
            { name: 'insert', items :[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                 ,'Iframe' ] },
                { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
                { name: 'tools', items : [ 'Maximize','-','About','contentbutton'] }
        ];
};