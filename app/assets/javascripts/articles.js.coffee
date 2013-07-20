//= require common

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("div.fine-uploader.imageuploader").imageUploader()

  addFuncRemoveParagraph = ($selector) ->
    $selector.tooltip({title: "小見出し削除"}).click ->
      # $(this).parents("div.paragraph").disable()
      $paragraph = $(this).parents("div.paragraph").disable()
      $hiddenDeletedAt = $paragraph.find(":hidden[id*=deleted_at]")
      if $hiddenDeletedAt.length
        $hiddenDeletedAt.val("true")
      else
        $paragraph.remove()

  $("#add-paragraph").tooltip({title: "小見出し追加"}).click ->
    paragraphIndex = $("#paragraphs-block").children().length + 1

    attributesIndex = ""
    textarea_id = $("#paragraphs-block").children().last().find("textarea").attr("id")
    if textarea_id
      # matches = textarea_id.match(/attributes_(.*)_sentence/i)
      matches = textarea_id.match(/paragraphs_(.*)_sentence/i)
      if matches and matches.length == 2 and !isNaN(parseInt(matches[1]))
        attributesIndex = (parseInt(matches[1]) + 1)
    paragraphHTML = '<div class="paragraph">
    <div class="control-group">
      <label for="article_paragraphs__subtitle" class="control-label">
        <input type="button" class="remove-paragraph" value="-"/>小見出し' + paragraphIndex +  '
</label>
      <div class="controls">
        <input type="text" value="" size="30" placeholder="小見出し' + paragraphIndex +  '" name="article[paragraphs]['+ attributesIndex + '][subtitle]" id="article_paragraphs__subtitle" class="span7">  
      </div>
    </div>
    <div class="control-group">
      <label for="article_paragraphs__image" class="control-label">
        投稿写真' + paragraphIndex + '</label>
      <div class="controls">
        <div>
          <div class="fine-uploader imageuploader"><div class="qq-uploader"><div class="qq-upload-drop-area" style="display: none;"><span>Drop files here to upload</span></div><div class="qq-upload-button" style="position: relative; overflow: hidden; direction: ltr;"><div>Click or Drop</div><input type="file" name="file" style="position: absolute; right: 0px; top: 0px; font-family: Arial; font-size: 118px; margin: 0px; padding: 0px; cursor: pointer; opacity: 0;"></div><span class="qq-drop-processing"><span>Processing dropped files...</span><span class="qq-drop-processing-spinner"></span></span><ul class="qq-upload-list"></ul></div></div>
          <div class="file-image image-container photo">
              <span class="upload-file">NO IMAGE</span>
              <img style="display: none;" alt="NO IMAGE" src="" class="upload-file">
            <input id="article_paragraphs__image_id" type="hidden" name="article[paragraphs]['+attributesIndex+'][image_id]">          </div>
        </div>
      </div>
    </div>    
    <div class="control-group">
      <label for="article_paragraphs__sentence" class="control-label">
        文章' + paragraphIndex +  '
</label>      <div class="controls">
        <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraphs]['+attributesIndex+'][sentence]" id="article_paragraphs__sentence" cols="40" class="span7"></textarea>  
      </div>
    </div></div>'

    $paragraph = $("#paragraphs-block").append(paragraphHTML)
    addFuncRemoveParagraph($paragraph.find("input.remove-paragraph"))
    $paragraph.find("div.fine-uploader.imageuploader").imageUploader()

  addFuncRemoveParagraph($("input.remove-paragraph"))

  # page top
  topBtn = $('#page-top')
  topBtn.hide()
  $(window).scroll ->
    if ($(this).scrollTop() > 100)
      topBtn.fadeIn()
    else
      topBtn.fadeOut()
  topBtn.click ->
    $('body,html').animate({scrollTop: 0}, 500)
    return false
