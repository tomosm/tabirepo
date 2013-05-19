# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # createUploader = () ->
  param = $('meta[name="csrf-param"]').attr('content')
  token = $('meta[name="csrf-token"]').attr('content')
  # image_id = $('#article_image_id').attr('value')
  obj = {
    # type: "Image::Logo"
  }
  obj[param] = token

  $("#fine-uploader").fineUploader({
    request: {
      params: obj,
      endpoint: '/fileupload/articles'
    },
    multiple: false,
    validation: {
      allowedExtensions: ['jpeg', 'jpg', 'gif', 'png'],
      sizeLimit: 102400000#,
      # itemLimit: 1
    },
    text: {
      uploadButton: 'Click or Drop'
    }#,
    # showMessage: (message) ->
      # $('#restricted-fine-uploader').append('<div class="alert alert-error">' + message + '</div>')
    # callbacks: {
      # onSubmit: (id, fileName) ->
      #   $messages.append('<div id="file-' + id + '" class="alert" style="margin: 20px 0 0"></div>')
      # onUpload: (id, fileName) ->
      #   $('#file-' + id).addClass('alert-info')
      #                   .html('<img src="client/loading.gif" alt="Initializing. Please hold."> ' +
      #                         'Initializing ' +
      #                         '“' + fileName + '”')
      # onProgress: (id, fileName, loaded, total) ->
      #   if (loaded < total)
      #     progress = Math.round(loaded / total * 100) + '% of ' + Math.round(total / 1024) + ' kB';
      #     $('#file-' + id).removeClass('alert-info')
      #                     .html('<img src="client/loading.gif" alt="In progress. Please hold."> ' +
      #                           'Uploading ' +
      #                           '“' + fileName + '” ' +
      #                           progress)
      #   else
      #     $('#file-' + id).addClass('alert-info')
      #                     .html('<img src="client/loading.gif" alt="Saving. Please hold."> ' +
      #                           'Saving ' +
      #                           '“' + fileName + '”')
      # onComplete: (id, fileName, responseJSON) ->
      #   if (responseJSON.success)
      #     $('#file-' + id).removeClass('alert-info')
      #                     .addClass('alert-success')
      #                     .html('<i class="icon-ok"></i> ' +
      #                           'Successfully saved ' +
      #                           '“' + fileName + '”' +
      #                           # '<br><img src="img/success.jpg" alt="' + fileName + '">')
      #                           '<br><img src="' + responseJSON.url + '" alt="' + fileName + '">')
      #   else
      #     $('#file-' + id).removeClass('alert-info')
      #                     .addClass('alert-error')
      #                     .html('<i class="icon-exclamation-sign"></i> ' +
      #                           'Error with ' +
      #                           '“' + fileName + '”: ' +
      #                           responseJSON.error)
    # },
    # onComplete: (id, fileName, responseJSON) ->
    #   if (responseJSON.success)
    #     $('#thumbnail-spot').html('<img src="'+responseJSON.src+'" alt="' + fileName + '">')
    #     var formfield = $(uploader_el).data("form-parameter")
    #     $('input[name="'+formfield+'"]').attr('value', responseJSON.id)
    #     console.log($('input[name="'+formfield+'"]'))
  }).on('complete', (event, id, fileName, responseJSON) ->
    # obj["image_id"] = null
    if (responseJSON.success)
      # $('#file-' + id).removeClass('alert-info')
      # $('#file-image').removeClass('alert-info')
      #                 .addClass('alert-success')
      #                 .html('<i class="icon-ok"></i> ' +
      #                       'Successfully saved ' +
      #                       '“' + fileName + '”' +
      #                       # '<br><img src="img/success.jpg" alt="' + fileName + '">')
      #                       '<br><img src="' + responseJSON.url + '" alt="' + fileName + '">')
      $('#file-image').removeClass('alert-info')
                      # .addClass('alert-success')
                      # .html('<img src="' + responseJSON.url + '" alt="' + fileName + '">')
      $("#file-image").children("img").attr("src", responseJSON.url)
      $("#file-image").find("#article_image_id").attr("value", responseJSON.image.id)
                      # .append('<input type="hidden" id="'+  +'" value="'+  +'" />')
    # else
    #   $('#file-image').removeClass('alert-info')
    #   # $('#file-' + id).removeClass('alert-info')
    #                   .addClass('alert-error')
    #                   .html('<i class="icon-exclamation-sign"></i> ' +
    #                         'Error with ' +
    #                         '“' + fileName + '”: ' +
    #                         responseJSON.error)
#         if (responseJSON.success)
#           $(this).append('<img src="img/success.jpg" alt="' + fileName + '">')  
  # ).on('mouseup', (id, fileName) ->
  #   # obj = {}
  #   obj["image_id"] = $('#article_image_id').attr('value')
  )
  # createUploader()
  # $(".qq-upload-list").hide()

  addFuncRemoveParagraph = ($selector) ->
    $selector.tooltip({title: "見出し削除"}).click ->
      # $(this).parents("div.paragraph").disable()
      $paragraph = $(this).parents("div.paragraph").disable()
      $hiddenDeletedAt = $paragraph.find(":hidden[id*=deleted_at]")
      if $hiddenDeletedAt.length
        $hiddenDeletedAt.val("true")
      else
        $paragraph.remove()

  $("#add-paragraph").tooltip({title: "見出し追加"}).click ->
#     paragraphHTML = '<div class="control-group">
#       <label for="article_paragraphs_attributes_2_subtitle" class="control-label">
#         見出し1
# </label>      <div class="controls">
#         <input type="text" value="" size="30" rows="4" placeholder="見出し" name="article[paragraphs_attributes][2][subtitle]" id="article_paragraphs_attributes_2_subtitle" class="span7">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraphs_attributes_2_sentence" class="control-label">
#         文章1
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章" name="article[paragraphs_attributes][2][sentence]" id="article_paragraphs_attributes_2_sentence" cols="40" class="span7"></textarea>  
#       </div>
#     </div>'

    paragraphIndex = $("#paragraphs-block").children().length + 1

    attributesIndex = ""
    textarea_id = $("#paragraphs-block").children().last().find("textarea").attr("id")
    if textarea_id
      # matches = textarea_id.match(/attributes_(.*)_sentence/i)
      matches = textarea_id.match(/paragraphs_(.*)_sentence/i)
      if matches and matches.length == 2 and !isNaN(parseInt(matches[1]))
        attributesIndex = (parseInt(matches[1]) + 1)
#     paragraphHTML = '<div class="paragraph"><div class="control-group">
#       <label for="article_paragraph_subtitle" class="control-label">
#         <input type="button" class="remove-paragraph" value="-"/>見出し' + paragraphIndex +  '
# </label>      <div class="controls">
#         <input type="text" value="" size="30" rows="4" placeholder="見出し' + paragraphIndex +  '" name="article[paragraph][subtitle]" id="article_paragraph_subtitle" class="span7">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraph_sentence" class="control-label">
#         文章' + paragraphIndex +  '
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraph][sentence]" id="article_paragraph_sentence" cols="40" class="span7"></textarea>  
#       </div>
#     </div></div>'

#     paragraphHTML = '<div class="paragraph"><div class="control-group">
#       <label for="article_paragraphs_attributes__subtitle" class="control-label">
#         <input type="button" class="remove-paragraph" value="-"/>見出し' + paragraphIndex +  '
# </label>      <div class="controls">
#         <input type="text" value="" size="30" rows="4" placeholder="見出し' + paragraphIndex +  '" name="article[paragraphs_attributes]['+ attributesIndex + '][subtitle]" id="article_paragraphs_attributes__subtitle" class="span7">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraphs_attributes__sentence" class="control-label">
#         文章' + paragraphIndex +  '
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraphs_attributes]['+attributesIndex+'][sentence]" id="article_paragraphs_attributes__sentence" cols="40" class="span7"></textarea>  
#       </div>
#     </div></div>'

    paragraphHTML = '<div class="paragraph"><div class="control-group">
      <label for="article_paragraphs__subtitle" class="control-label">
        <input type="button" class="remove-paragraph" value="-"/>見出し' + paragraphIndex +  '
</label>      <div class="controls">
        <input type="text" value="" size="30" placeholder="見出し' + paragraphIndex +  '" name="article[paragraphs]['+ attributesIndex + '][subtitle]" id="article_paragraphs__subtitle" class="span7">  
      </div>
    </div>
    <div class="control-group">
      <label for="article_paragraphs__sentence" class="control-label">
        文章' + paragraphIndex +  '
</label>      <div class="controls">
        <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraphs]['+attributesIndex+'][sentence]" id="article_paragraphs__sentence" cols="40" class="span7"></textarea>  
      </div>
    </div></div>'

    addFuncRemoveParagraph($("#paragraphs-block").append(paragraphHTML).find("input.remove-paragraph"))

  addFuncRemoveParagraph($("input.remove-paragraph"))
