$(function(){
  
  var file_field = document.querySelector('input[type=file]')
  
  $('#img-file').change(function(){
    
    var file = $('input[type="file"]').prop('files')[0];
    var fileReader = new FileReader();

    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `<img src="${src}" width="114" height="80">`
      $('.seller__main__content__box__image').before(html);
    }
    fileReader.readAsDataURL(file);
  });
});
