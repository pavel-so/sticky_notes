$(document).ready(
  function(){
    $.getScript('notes');
});

var deleteNote=function(id){
  $.post('/notes/'+id, { _method: 'delete' }, null, "script");
  return false;
}

var editNote=function(id){
  $.get('notes/'+id+'/edit', function(data) {
    showMask();
		var winH = $(window).height();
		var winW = $(window).width();
    $('#container').append(data);
    var id='.edit_note'
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	  $('.cancel').click(function (e) {
		  e.preventDefault();
  		$('#mask').hide();
      $(id).remove();
	  });
	  		$('#mask').click(function () {
		  $(this).hide();
		  $(id).remove();
	  });
  });
  return false;
}
var addNote=function(){
  $.get('notes/new', function(data) {
    showMask();
		var winH = $(window).height();
		var winW = $(window).width();
    $('#container').append(data);
    var id='#new_note'
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	  $('.cancel').click(function (e) {
		  e.preventDefault();
  		$('#mask').hide();
      $(id).remove();
	  });
	  		$('#mask').click(function () {
		  $(this).hide();
		  $(id).remove();
	  });
  });
  return false;
}
var showMask=function(){
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		$('#mask').fadeIn(1000);
		$('#mask').fadeTo("slow",0.8);
}

