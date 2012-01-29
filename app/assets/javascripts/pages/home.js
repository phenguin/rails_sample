$(function () {

  var update_count = function () {
    var chars_left = 140 - $('#micropost_content').val().length;
    var msg = ""
    if (chars_left > 0)  {
      msg = chars_left + " characters remaining in your message!"
    } else  {
      msg = "Your message is too long!"
    }
  
    $('#chars_remaining').text(msg);
  };

$('#micropost_content').bind("keypress", update_count);

});
