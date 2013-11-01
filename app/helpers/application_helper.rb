#encoding: UTF-8
module ApplicationHelper
	def get_translated attribute, value
	  	@res = case attribute 
			when 'status' then
				value == 'open' ? t(:views)[:status][:open] : t(:views)[:status][:in_progress] 
 			when 'priority' then
				val = case value
					when 'high', 'високий' then 'high'
					when 'medium', 'середній' then 'medium'
					when 'low', 'низький'  then 'low'
				end	
				t(:priorities)[:"#{val}"]
	 		when 'created_at','completed_at' then
	 			res = value.strftime("%a, %b %e, %l:%M %p")
 				day = /\w+/.match(res)[0] 
				copy = res.dup.gsub!(/#{day}/, '')
				month = /\w+/.match(copy)[0]
				{:week => day, :months => month}.each do |k,v| 
				 	raw = t(:views)[:time][:"#{k}"]
					parsed = eval(raw)
					res.gsub!(/#{v}/,parsed[:"#{v}"])
				end
				I18n.locale == :ua ? (res.gsub!(/AM|PM/, '')) : res
			else
				value
			end
	end	
end
