(function($){

  $(function(){
    var email_share_form = $("#email_share_form");
    var toggle_email_share_form = function(){
      email_share_form.toggle("fast");
    };
    $("#email_share").on("click", toggle_email_share_form);
  });

})(jQuery);
