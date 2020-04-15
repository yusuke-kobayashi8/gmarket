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

  function buildGrandChildren(insertHTML){
    let html = 
              `<select name="product[category]" id="grandchild_category">
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
        $('#grandchild_category').remove()
        let insertHTML = '';
        children.forEach(function(grandchild){
          insertHTML += appendOption(grandchild)
        })
        buildChildren(insertHTML)
      })
      .fail(function(){
        alert('カテゴリを取得できませんでした');
      })
    } else {
      $('#child_category').remove()
      $('#grandchild_category').remove()
    }
  });

  $('#category_form').on('change', '#child_category', function(){
    let childId = $(this).val()
    if (childId != ""){
      $.ajax({
        url: 'category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchild_category').remove()
        let insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild)
        })
        buildGrandChildren(insertHTML)
      })
      .fail(function(){
        alert('カテゴリを取得できませんでした');
      })
    } else {
      $('#grandchild_category').remove()
    }
  })
});