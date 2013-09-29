require 'test_helper'

describe Todo::ActiveTasksController do
 	describe "POST mass_destroy" do
  		it "responds with 200 status" do
  			post :mass_destroy, params: {id:["1", "2"]}
			p response.status
		end
	end
end