(function($){
  $(function(){
    var txt = $('#message'),
    hiddenDiv = $(document.createElement('div')),
    content = null;

    txt.addClass('txtstuff');
    hiddenDiv.addClass('hiddendiv common');

    $('body').append(hiddenDiv);

    txt.on('keyup', function () {
      content = $(this).val();

      content = content.replace(/\n/g, '<br>');
      hiddenDiv.html(content + '<br class="lbr">');

      $(this).css('height', hiddenDiv.height());

    });

  });

})(jQuery);
