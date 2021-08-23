/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
        // Define changes to default configuration here. For example:
        config.language = 'pt-br';
        config.extraPlugins = 'notification';
        config.extraPlugins = 'codesnippet';
        config.extraPlugins = 'widget';
        config.extraPlugins = 'lineutils';
        config.extraPlugins = 'clipboard';
        config.extraPlugins = 'dialog';
        config.extraPlugins = 'dialogui';
        config.extraPlugins = 'toolbar';
        config.extraPlugins = 'button';
        config.extraPlugins = 'widgetselection';
        config.extraPlugins = 'tableresize';
        config.extraPlugins = 'tabletools';
        config.extraPlugins = 'table';
        config.extraPlugins = 'contextmenu';
        config.extraPlugins = 'menu';
        config.extraPlugins = 'autosave';
        config.extraPlugins = 'floatpanel';
        config.extraPlugins = 'panel';
        config.extraPlugins = 'pastefromexcel';
        config.extraPlugins = 'image2';
        config.extraPlugins = 'imagepaste';
        config.extraPlugins = 'autolink';
        config.extraPlugins = 'imagerotate';
        config.extraPlugins = 'find';
        config.extraPlugins = 'chart';
        config.extraPlugins = 'mediaembed';
        config.extraPlugins = 'colordialog';
        config.extraPlugins = 'menubutton';
		config.extraPlugins = 'pastebase64';
        config.extraPlugins = 'base64image';
        
        //plugin auto-save
        config.autosave_SaveKey = 'autosaveKey';
        config.autosave = {
                // Auto save Key - The Default autosavekey can be overridden from the config ...
                //Savekey : 'autosave_' + window.location + "_" + $('#' + editor.name).attr('name'),

                // Ignore Content older then X
                //The Default Minutes (Default is 1440 which is one day) after the auto saved content is ignored can be overidden from the config ...
                NotOlderThen : 1440,

                // Save Content on Destroy - Setting to Save content on editor destroy (Default is false) ...
                saveOnDestroy : false,

                // Setting to set the Save button to inform the plugin when the content is saved by the user and doesn't need to be stored temporary ...
                saveDetectionSelectors : "a[href^='javascript:__doPostBack'][id*='Save'],a[id*='Cancel']",

                // Notification Type - Setting to set the if you want to show the "Auto Saved" message, and if yes you can show as Notification or as Message in the Status bar (Default is 
                // "notification")
                //messageType : "notification",

                // Show in the Status Bar
                //messageType : "statusbar",

                // Show no Message
                messageType : "no",

                // Delay
                delay : 30,

                // The Default Diff Type for the Compare Dialog, you can choose between "sideBySide" or "inline". Default is "sideBySide"
                diffType : "sideBySide",

                // autoLoad when enabled it directly loads the saved content
                autoLoad: false
        };
        // config.uiColor = '#AADC6E';
        //plugin codesnipet
        config.codeSnippet_theme = 'arta';
};
