require 'spec_helper'

describe Movie  do
	describe 'searching movies by director' do
		it 'should return expected results for test fixture' do
			m1 = FactoryGirl.create(:movie, :director => "d1", :title => "m1")
			m2 = FactoryGirl.create(:movie, :director => "d1", :title => "m2")
			m3 = FactoryGirl.create(:movie, :director => "d2", :title => "m3")
			m4 = FactoryGirl.create(:movie, :director => "d3", :title => "m4")
			results = Movie.search_movies_with_given_director("d1")
			results.should include m1
			results.should include m2
			results.should_not include m3
			results.should_not include m4
		end
	end	
end