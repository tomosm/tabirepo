# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("img.turningpoint").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=1"
  $("img.heartful").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=2"
  $("img.firsttime").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=3"
  $("img.dangerous").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=4"
  $("img.funny").css("cursor", "pointer").click ->
    location.href = "articles/search?theme_id=5"
  # $("#top_carousel").carousel('cycle').carousel({interval: 2000})
  # $("#top_carousel").carousel('cycle').carousel({interval: 5000, pause: false})
