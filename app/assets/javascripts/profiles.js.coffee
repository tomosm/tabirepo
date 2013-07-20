//= require common

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#profile-table tr").each ->
    $(this).css("cursor", "pointer").mouseup ->
      location.href = ("/profiles/" + $(this).find("[name=profile_id]").val())

  $("div.fine-uploader.photouploader").photoUploader()
