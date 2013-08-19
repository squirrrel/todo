# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#REFACTOR

jQuery -> 

	  $('.ok_form').submit(-> $.ajax({ type: "POST",url: "/todo/active_tasks/update", dataType: "script" });)
	  $('.delete').click(-> $.ajax({ type: "GET", url: "/todo/active_tasks/delete", dataType: "script" });)
	  $('.complete').click(-> $.ajax({ type: "GET", url: "/todo/active_tasks/complete", dataType: "script" });) 

