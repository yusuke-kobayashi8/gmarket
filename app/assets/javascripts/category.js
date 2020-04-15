$(function(){

  function appendOption(category){
    let html = `<option value="${category.id}">${category.name}</option>`
    return html;
  }

  function buildChildren(insertHTML){
    let html = 
              `<select name="product[category]" id="child_category">
                <option value="">選択してください</option>
                ${insertHTML}
              </select>`
    $('.seller__main__content__box3__form1').append(html)
  }

  $('#product_category').change(function(){
    let parentId = $(this).val()
    if (parentId != ""){
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category').remove()
        $().remove()
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child)
        })
        buildChildren(insertHTML)
      })
      .fail(function(){
        alert('error');
      })
    } else{
      $('#child_category').remove()
        $().remove()
    }
  });
});