$ ->
  # uploader function
  fileUploader = ($selector, endpoint) ->
    param = $('meta[name="csrf-param"]').attr('content')
    token = $('meta[name="csrf-token"]').attr('content')
    # image_id = $('#article_image_id').attr('value')
    obj = {
      # type: "Image::Logo"
    }
    obj[param] = token

    $selector.fineUploader({
      request: {
        params: obj,
        endpoint: endpoint
      },
      multiple: false,
      validation: {
        allowedExtensions: ['jpeg', 'jpg', 'gif', 'png'],
        sizeLimit: 102400000#,
        # itemLimit: 1
      },
      text: {
        uploadButton: 'Click or Drop'
      }
    }).on('complete', (event, id, fileName, responseJSON) ->
      if (responseJSON.success)
        $fileImage = $(this).parent().find("div.image-container");
        $fileImage.removeClass('alert-info').find("input:hidden").attr("value", responseJSON.image.id)
        $fileImage.children("img").attr("src", responseJSON.url).css("display", "")
        $fileImage.children("span.upload-file").css("display", "none")
    )

  $.fn.imageUploader = () ->
    fileUploader($(this), '/imageupload')

  $.fn.photoUploader = () ->
    fileUploader($(this), '/photoupload')

