# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("img.turningpoint").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=" + $("#theme_turningpoint_id").val()
  $("img.heartful").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=" + $("#theme_heartful_id").val()
  $("img.firsttime").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=" + $("#theme_firsttime_id").val()
  $("img.dangerous").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=" + $("#theme_dangerous_id").val()
  $("img.funny").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=" + $("#theme_funny_id").val()
  # $("#top_carousel").carousel('cycle').carousel({interval: 2000})
  # $("#top_carousel").carousel('cycle').carousel({interval: 5000, pause: false})
