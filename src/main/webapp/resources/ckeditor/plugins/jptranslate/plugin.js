CKEDITOR.plugins.add( 'jptranslate', {
    icons: 'jptranslate',
    init: function( editor ) {
    	editor.addCommand('cmd-insertgist1', new CKEDITOR.dialogCommand('jptranslateDig'));
        editor.ui.addButton( 'jptranslate', {
            label: '校正支援',
            command: 'cmd-insertgist1',
            toolbar: 'insert'
        });
        CKEDITOR.dialog.add('jptranslateDig',this.path+'dialogs/jptranslateDig.js');
    }
});