/*******************************************************************************
 * KindEditor - WYSIWYG HTML Editor for Internet
 * Copyright (C) 2006-2011 kindsoft.net
 *
 * @author javy <javyquan@gmail.com>
 * @site http://www.kindsoft.net/
 * @licence http://www.kindsoft.net/license.php
 *******************************************************************************/

KindEditor.plugin('modal', function(K) {
  var self = this, name = 'modal',
  lang = self.lang(name + '.');

  self.plugin.modalDialog = function(options) {
    var clickFn = options.clickFn;
    var html = '<div style="padding:10px 20px;" id="modal_content"></div>'
    var dialogWidth = options.width || 400,
    dialogHeight = options.height || 250,
    title = options.title || "modal";
    var dialog = self.createDialog({
      name : name,
      width : dialogWidth,
      height : dialogHeight,
      title : title,
      body : html,
      yesBtn : {
        name : self.lang('yes'),
        click : function(e) {
          if (dialog.isLoading) {
            return;
          }
          clickFn.call(self, remote_content);
        }
      }
    }),

    div = dialog.div;

    var remote_content = K('#modal_content', div);

    return dialog;
  };
});
