# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
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
#         <input type="text" value="" size="30" rows="4" placeholder="見出し" name="article[paragraphs_attributes][2][subtitle]" id="article_paragraphs_attributes_2_subtitle" class="span6">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraphs_attributes_2_sentence" class="control-label">
#         文章1
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章" name="article[paragraphs_attributes][2][sentence]" id="article_paragraphs_attributes_2_sentence" cols="40" class="span6"></textarea>  
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
#         <input type="text" value="" size="30" rows="4" placeholder="見出し' + paragraphIndex +  '" name="article[paragraph][subtitle]" id="article_paragraph_subtitle" class="span6">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraph_sentence" class="control-label">
#         文章' + paragraphIndex +  '
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraph][sentence]" id="article_paragraph_sentence" cols="40" class="span6"></textarea>  
#       </div>
#     </div></div>'

#     paragraphHTML = '<div class="paragraph"><div class="control-group">
#       <label for="article_paragraphs_attributes__subtitle" class="control-label">
#         <input type="button" class="remove-paragraph" value="-"/>見出し' + paragraphIndex +  '
# </label>      <div class="controls">
#         <input type="text" value="" size="30" rows="4" placeholder="見出し' + paragraphIndex +  '" name="article[paragraphs_attributes]['+ attributesIndex + '][subtitle]" id="article_paragraphs_attributes__subtitle" class="span6">  
#       </div>
#     </div>
#     <div class="control-group">
#       <label for="article_paragraphs_attributes__sentence" class="control-label">
#         文章' + paragraphIndex +  '
# </label>      <div class="controls">
#         <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraphs_attributes]['+attributesIndex+'][sentence]" id="article_paragraphs_attributes__sentence" cols="40" class="span6"></textarea>  
#       </div>
#     </div></div>'

    paragraphHTML = '<div class="paragraph"><div class="control-group">
      <label for="article_paragraphs__subtitle" class="control-label">
        <input type="button" class="remove-paragraph" value="-"/>見出し' + paragraphIndex +  '
</label>      <div class="controls">
        <input type="text" value="" size="30" rows="4" placeholder="見出し' + paragraphIndex +  '" name="article[paragraphs]['+ attributesIndex + '][subtitle]" id="article_paragraphs__subtitle" class="span6">  
      </div>
    </div>
    <div class="control-group">
      <label for="article_paragraphs__sentence" class="control-label">
        文章' + paragraphIndex +  '
</label>      <div class="controls">
        <textarea rows="10" placeholder="文章' + paragraphIndex +  '" name="article[paragraphs]['+attributesIndex+'][sentence]" id="article_paragraphs__sentence" cols="40" class="span6"></textarea>  
      </div>
    </div></div>'

    addFuncRemoveParagraph($("#paragraphs-block").append(paragraphHTML).find("input.remove-paragraph"))

  addFuncRemoveParagraph($("input.remove-paragraph"))
