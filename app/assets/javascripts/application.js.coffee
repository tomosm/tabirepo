# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# // or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // the compiled file.
# //
# // WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# // GO AFTER THE REQUIRES BELOW.
# //
//= require jquery
//= require twitter/bootstrap
//= require fuelux
//= require fuelux/checkbox
//= require jquery.fineuploader-3.4.1.min

$ ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  # $('#datepicker').datepicker()
  $(':checkbox').checkbox()
  $('select').select()
  $.fn.disable = ->
    $this = $(this)
    $this.css("display", "none")
    return $this

  $("#top_carousel").carousel('cycle').carousel({interval: 5000, pause: false})
