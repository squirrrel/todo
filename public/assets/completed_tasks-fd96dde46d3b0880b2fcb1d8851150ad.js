(function(){var t,e,i;(i=function(){return $(document).ready(function(){return $("option[text='last 7 days']").attr("selected","selected")})})(),this.apply_time_filter=e=function(t){return $.ajax({type:"GET",url:"http://localhost:3000/todo/completed_tasks/",data:{filter:t}})},this.apply_priority_filter=t=function(t){var e;return e=$("#elapsed_time").find("option:selected").text(),$.ajax({type:"GET",url:"http://localhost:3000/todo/completed_tasks/filter_by_priority",data:{priority:t,time:e}})}}).call(this);