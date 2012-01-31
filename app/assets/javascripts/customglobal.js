




/* this if for our nav bar */

$(document).ready(function(){
        $('li.headlink').hover(
            function() { $('ul',this).slideDown(300); },
            function() { $('ul', this).slideUp(30); });
        });

//$(document).ready(function(){
        //$('li.headlink').hover(
            //function() { $('ul',this).css('display', 'block'); },
            //function() { $('ul', this).css('display', 'none'); });
        //});

/*
 *http://tutorialzine.com/2009/09/simple-ajax-website-jquery/
 * this will be for the little week transfer section */
/*
$(document).ready(function(){
        checkURL();
        $('ul li a').click(function (e){
            checkURL(this.hash);
      });

var lasturl="";

function checkURL(hash)
{
    if(!hash) hash=window.location.hash
    if(hash != lasturl)
    {
        lasturl=hash;
        loadPage(hash);
    }
}

function loadPage(url)
{
    url=url.replace('#page','');

    $('#loading').css('visibility', 'visible');

    $.ajax({
        type: "POST"
        url: "load_page.php",
        data: 'page='+url,
        dataType: "html",   //expect html to be returned
        success: function(msg){

            if(parseInt(msg)!=0)    //if no errors
        {
        $('#pageContent').html(msg);    //load the returned html into pageContet
        $('#loading').css('visibility','hidden');   //and hide the rotating gif
        }
        }

    });

}
*/
