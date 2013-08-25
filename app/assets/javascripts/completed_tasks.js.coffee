jQuery -> 
	@apply_time_filter = apply_time_filter=(selected)->
		$.ajax({
  		type: "GET",
  		url: "http://localhost:3000/todo/completed_tasks/",
  		data: { filter: selected }})
	@apply_priority_filter = apply_priority_filter=(selected)->
		time = $('#elapsed_time').find('option:selected').text()
		$.ajax({
  		type: "GET",
  		url: "http://localhost:3000/todo/completed_tasks/filter_by_priority",
  		data: { priority: selected , time: time }})  		
  		
