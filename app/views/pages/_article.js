$(function () {

$("tr.feedItem td.mark a").bind("click", function () {

  $(this).parent().parent().hide("slow");

});

});
