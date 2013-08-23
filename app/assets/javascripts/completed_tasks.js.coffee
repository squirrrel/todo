jQuery -> 
	@apply_time_filter = apply_time_filter=(selected)->
		$.ajax({
  		type: "GET",
  		url: "http://localhost:3000/todo/completed_tasks/filter_by_time",
  		data: { filter: selected }})

