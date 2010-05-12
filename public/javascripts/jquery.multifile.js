$(document).ready(function() {
    $('#add-attach').click(function() {
      rand_id = Math.random().toString().split('.')[1];
      $('#add-attach').before('<input id="attachment_toadd_' + rand_id + '" name="content[attachments_toadd[file]]" type="file" />');
    });
});
