
jQuery -> 
	@trigger_on_edit = trigger_on_edit=(task_id, dropdown)->
		$('div#description' + task_id).attr('contenteditable','true')
		
		$('div#priority' + task_id).replaceWith('<div><select><option>' + 
			'high</option><option>medium</option>' + 
			'<option>low</option></select></div>')
		$('div#status' + task_id).replaceWith('<select><option>open</option><option>in progress</option></select>')
		
		$('.okay' + task_id).show()
		$('#' + dropdown).show()

jQuery ->	
	@trigger_on_ok = trigger_on_ok = (obj, task_id, dropdown)->
		$('div#description' + task_id).attr('contenteditable','false')
		
		selected_1 = $('select :selected').slice(1,2).text()
		selected_2 = $('select :selected').slice(2,3).text() 
		
		$('select').slice(1,2).replaceWith('<div>' + selected_1 + '</div>') 
		$('select').slice(1,2).replaceWith('<div>' + selected_2 + '</div>')
		
		$(obj).hide()
		$('#'+ dropdown).hide()

jQuery ->		
	@trigger_on_cancel = trigger_on_cancel = (obj, task_id)->
		injection = $(obj).attr('id') + '_span'
		
		description_id = 'description' + injection
		priority_id = 'priority'+ injection
		status_id = 'status' + injection

		desc_text = document.getElementById(description_id).textContent
		drop_text_1 = document.getElementById(priority_id).textContent
		drop_text_2 = document.getElementById(status_id).textContent

		$('div#description' + task_id).attr('contenteditable','false')
		
		$('div#description' + task_id).replaceWith('<div>'+desc_text+'</div>')
		$('select').slice(1,2).replaceWith('<div>'+drop_text_1+'</div>')
		$('select').slice(1,2).replaceWith('<div>'+drop_text_2+'</div>')
		
		$(obj).hide()
		$('.okay' + task_id).hide()

jQuery ->
	@show_actions = show_actions = (task_id)->
		$('.' + task_id + '_action').show()

jQuery ->		
	@hide_actions = hide_actions = (task_id)->
		$('.' + task_id + '_action').hide()


