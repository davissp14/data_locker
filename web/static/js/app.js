// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"


  //you can now use $ as your jQuery object.


  $('#some-button').on('click', function(){
    $('#overlay, #overlay-back').fadeIn(500);
  });

  $('#exit-button').on('click', function(){
    $('#overlay, #overlay-back').fadeOut(500);
  })

  $('#item_url').on('paste', function () {
    var element = this;
    setTimeout(function () {
      var text = $(element).val();
      evaluateLink(text);
    }, 100);
  });


function evaluateLink(url) {
  $.ajax({
     type: "POST",
     url: "/evaluate_link",
     data: {
       _csrf_token: $('input[name="_csrf_token"]').val(),
       url: url
     },
     success: result => {
       toggleClass("#item_url", "success");
       show_generated_content(result);
     },
     error: e => {
       toggleClass("#item_url", "failure");
       hide_generated_content();
       console.log("ERROR")
       console.log(e)
     }
  })
}

function hide_generated_content() {
  $('div.generated_content').css('display', 'none');
}

function show_generated_content(result) {
  console.log(result);
  $('div.generated_content').css('display', 'block');
  $('#item_title').val(result['title']);
  $('#item_favicon').val(result['favicon']);
  $('#item_type').val(result['type']);

  if (result['type'] == 'image') {
    $('#item_title').css('background-image', 'url(/images/image-favicon.png)');
    console.log("Image");
  } else if (result['type'] == 'document') {
    $('#item_title').css('background-image', 'url(/images/document-favicon.png)');
    console.log("Document");
  } else {
    $('#item_title').css('background-image', 'url('+ result['favicon'] + ')');
    console.log("HTML");

  }

}

function toggleClass(elem, klass) {
  $(elem).addClass(klass);
  setTimeout(function () {
    $(elem).removeClass(klass);
  }, 5000);
}
