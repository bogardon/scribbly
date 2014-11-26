# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("a[data-content-index]").click (e) ->
    selectedIndex = $(this).data("content-index")
    $(".post-content").each (i, e) ->
      ele = $(e)
      if ele.data('content-index') == selectedIndex
        ele.removeClass("hide")
      else
        ele.addClass("hide")
        
    return false
