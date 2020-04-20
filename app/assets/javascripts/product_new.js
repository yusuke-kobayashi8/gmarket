// $(function(){

//   var dataBox = new DataTransfer();
//   var file_field = document.querySelector('input[type=file]')

//   $('#img-file').change(function(){

//     var files = $('input[type="file"]').prop('files')[0];
//     $.each(this.files, function(i, file){

//       var fileReader = new FileReader();
//       dataBox.items.add(file)
//       file_field.files = dataBox.files
//       var num = $('.item-image').length + 1 + i
//       fileReader.readAsDataURL(file);
//       if (num == 10){
//         $('#seller__main__content__box__image').css('display', 'none')   
//       }

//       fileReader.onloadend = function() {
//         var src = fileReader.result
//         var html= `<div class='item-image' data-image="${file.name}">
//                     <div class=' item-image__content'>
//                       <div class='item-image__content--icon'>
//                         <img src=${src} width="114" height="80" >
//                       </div>
//                     </div>
//                     <div class='item-image__operetion'>
//                       <div class='item-image__operetion__edit'>編集</div>
//                       <div class='item-image__operetion__delete'>削除</div>
//                     </div>
//                   </div>`

//         $('#seller__main__content__box__image').before(html);
//       };

//       $('#seller__main__content__box__image').attr('class', `item-num-${num}`)
//     });
//   });

//   $(document).on("click", '.item-image__operetion__delete', function(){

//     var target_image = $(this).parent().parent()
//     var target_name = $(target_image).data('image')

//     if(file_field.files.length==1){
//       $('input[type=file]').val(null)
//       dataBox.clearData();
//       console.log(dataBox)
//     }else{
//       $.each(file_field.files, function(i,input){
//         if(input.name==target_name){
//           dataBox.items.remove(i) 
//         }
//       })
//       file_field.files = dataBox.files
//     }
//     target_image.remove()
//     var num = $('.item-image').length
//     $('#seller__main__content__box__image').show()
//     $('#seller__main__content__box__image').attr('class', `item-num-${num}`)
//   });

//   $(document).on("click", '.item-image__operetion__edit', function(){
//     // var target_image = $(this).parent().parent()
//     // var target_name = $(target_image).data('image')
//     var id = $('.item-image').data('image_id');
//     console.log(id)
    
//     $('src').val("");
//     console.log()
//     $('#img-file').trigger("click");

//   })
// });
// $(document).on('turbolinks:load', function(){
  $(function(){

    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="update-box">
                        <label class="edit_btn">編集</label>
                      </div>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // 投稿編集時
    //items/:i/editページへリンクした際のアクション=======================================
    if (window.location.href.match(/\/products\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })
      var count = $('.preview-box').length;
      //プレビューが5あるときは、投稿ボックスを消しておく
      if (count == 5) {
        $('.label-content').hide();
      }
    }
    //=============================================================================

    // ラベルのwidth操作
    function setLabel() {
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content').hide();
        }

        //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
        if ($(`#product_images_attributes_${id}__destroy`)){
          $(`#product_images_attributes_${id}__destroy`).prop('checked',false);
        } 
        //=============================================================================

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          $('.label-box').attr({id: `label-box--${count}`,for: `product_images_attributes_${count}_image`});
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      $(`#preview-box__${id}`).remove();

      //新規登録時と編集時の場合分け==========================================================

      //新規投稿時
      //削除用チェックボックスの有無で判定
      if ($(`#product_images_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除 
        $(`#product_images_attributes_${id}_image`).val("");
        var count = $('.preview-box').length;
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content').show();
        }
        setLabel(count);
        if(id < 5){
          $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});

        }
      } else {

        //投稿編集時
        $(`#product_images_attributes_${id}__destroy`).prop('checked',true);
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content').show();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        //削除したプレビューのidによって、ラベルのidを変更する
        if(id < 5){
          $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
        }
      }
      //=============================================================================
      $(`#product_images_attributes_${id}_image`).val("");

      var count = $(`.preview-box`).lnegth;
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 5) {
        $('.label-box').attr({id: `label-box--${id}`, for: `product_images_attributes_${id}_image`});
      }
    });
  });
// })
