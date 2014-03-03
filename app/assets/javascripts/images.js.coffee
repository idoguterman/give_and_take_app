# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ready = ->
 jQuery ->
    new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 500, 500]
      onSelect: @update
      onChange: @update
  
  update: (coords) =>
    $('#crop_x').val((coords.x))
    $('#crop_y').val((coords.y))
    $('#crop_w').val((coords.w))
    $('#crop_h').val((coords.h))
    @updatePreview(coords)
     
  updatePreview: (coords) =>
  	$('#preview').css
  		width: Math.round((100.0/coords.w) * $('#cropbox').width()) + 'px'
  		height: Math.round((100.0/coords.h) * $('#cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round((100.0/coords.w) * coords.x) + 'px'
  		marginTop: '-' + Math.round((100.0/coords.h) * coords.y) + 'px'



$(document).ready(ready)
$(document).on('page:load', ready)
