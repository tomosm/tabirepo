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

  # info messages
#   $("div.theme img.info").popover({title:"記事のテーマ別", content: "
# <pre>・人生を変えた話<br/>
#   …旅の中での人との出会いや、事件との遭遇、自然との対峙などにより今後の自分の人生の歩き方に大きく影響を与えた出来事に関する話。その他に、「差別を受けた話」「自分探しの話」「価値観の変化の話」などもここに含まれる。<br/>
# ・心温まる話<br/>
#   …旅の中での現地の人や、偶然居合わせた各国の旅行者、もしくは遠い異国で出会った同じ日本人との出会いなどにより、大きく感情に影響を与えた出来事に関する話。その他に、「うれしかった話」「楽しかった話」「泣ける話」「深イイ話」「感動する話」などもここに含まれる。<br/>
# ・初体験の話<br/>
#   …旅の中で、それまでに経験したことのない出来事、はじめて体験した出来事などによって、思索をめぐらせたことに関する話。その他に、「カルチャーショックだった話」「ビックリした話」「未知との遭遇をした話」「地域のローカルルールの話」などもここに含まれる。<br/>
# ・危ない話<br/>
#   …旅の中で、身の危険や生命の危機に陥った出来事に関する話。その他に「アンダーグラウンドな話」「今だから言えるごめんなさいな話」「ケンカした話」「危険度MAXな話」などもここに含まれる。<br/>
# ・すべらない話<br/>
#   …旅の中で見た、聞いた、感じた、体験したなどの出来事で、帰国後に笑い話となっている出来事に関する話。その他に「旅で出会った変な人の話」「ヘンテコな海外の風習の話」などもここに含まれる。<br/>
# </pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.theme img.info").popover({title:"記事のテーマ別", content: "
<pre>・人生を変えた話<br/>
  …旅の中での人との出会いや、事件との遭遇、自然との対峙などにより今後の自分の人生の歩き方に大きく影響を与えた出来事に関する話。<br/>
・心温まる話<br/>
  …旅の中での現地の人や、偶然居合わせた各国の旅行者、もしくは遠い異国で出会った同じ日本人との出会いなどにより、大きく感情に影響を与えた出来事に関する話。<br/>
・初体験の話<br/>
  …旅の中で、それまでに経験したことのない出来事、はじめて体験した出来事などによって、思索をめぐらせたことに関する話。<br/>
・危ない話<br/>
  …旅の中で、身の危険や生命の危機に陥った出来事に関する話。<br/>
・すべらない話<br/>
  …旅の中で見た、聞いた、感じた、体験したなどの出来事で、帰国後に笑い話となっている出来事に関する話。<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.countries img.info").popover({title: "国名別（どこの国での話か）", content: "<pre>・該当する国名</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.vihicles img.info").popover({title: "移動手段別（どれを利用している時の話か）", content: "
<pre>
・徒歩<br/>
・自転車<br/>
・路線バス<br/>
・乗合バス<br/>
・タクシー<br/>
・レンタカー・レンタルバイク<br/>
・鉄道<br/>
・飛行機<br/>
・ボート<br/>
・船<br/>
・動物（ラクダ、ゾウなど）<br/>
・ご当地乗り物（リキシャ、トゥクトゥクなど）<br/>
・その他<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.members img.info").popover({title: "人数別（何人で旅をした時の話か）", content: "<pre>
・一人旅（男）<br/>
・一人旅（女）<br/>
・二人旅（男×男）<br/>
・二人旅（女×女）<br/>
・二人旅（男×女）（カップル、夫婦以外）<br/>
・カップル、夫婦<br/>
・グループ旅行（数名）<br/>
・団体旅行（数十名）<br/>
・その他<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.purposes img.info").popover({title: "目的別（どんな目的の旅をした時の話か）", content: "<pre>
・観光<br/>
・放浪、世界一周<br/>
・ボランティア<br/>
・ワーキングホリデー<br/>
・留学<br/>
・転勤<br/>
・永住、移住<br/>
・ピースボート<br/>
・その他<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.budgets img.info").popover({title: "予算別（どの程度の予算で旅をした時の話か）", content: "<pre>
・貧乏旅行（バックパッカー、安宿）<br/>
・普通旅行（国内旅行と同じ感覚）<br/>
・豪華旅行（高級ホテル、リゾートなど）<br/>
・その他<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.languages img.info").popover({title: "語学力別（どの程度外国語を話せる状態で旅をした時の話か…「○＝問題なく会話が通じるレベル」「△＝カタコトで意志が伝わるレベル」「×＝全く話せないレベル」）", content: "<pre>
・英語×、現地語×<br/>
・英語×、現地語△<br/>
・英語×、現地語○<br/>
・英語△、現地語×<br/>
・英語△、現地語△<br/>
・英語△、現地語○<br/>
・英語○、現地語×<br/>
・英語○、現地語△<br/>
・英語○、現地語○<br/>
・その他<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
  $("div.ages img.info").popover({title: "年齢別（何歳の時に旅をした時の話か）", content: "<pre>
・～19歳<br/>
・20～24歳<br/>
・25～29歳<br/>
・30～34歳<br/>
・35～39歳<br/>
・40代<br/>
・50代<br/>
・60代以上<br/>
</pre>", trigger: "hover", html: true, placement: "bottom"})
