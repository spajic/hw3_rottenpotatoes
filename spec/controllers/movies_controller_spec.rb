require 'spec_helper'

describe MoviesController  do
	describe 'searching movies with same director' do
		it 'should call the Movie method for search of similar movies' do
			# Setting up expectation - Controller should try to call
			# appropriate method. So we stub this method to isolate.
			Movie.should_receive(:search_movies_with_given_director).with('mihal')
			post :search_movies_with_given_director, {:director => 'mihal'}
		end

		it 'should select the Similar Movies template for rendering' do
			Movie.stub(:search_movies_with_given_director)
			post :search_movies_with_given_director
			response.should render_template('search_movies_with_given_director')
		end

		it 'should make search results available to that template' do
			Movie.stub(:search_movies_with_given_director).and_return('fake')
			post :search_movies_with_given_director
			# Check if controller assigns to @movies_with_given_director
			assigns(:movies_with_given_director).should == 'fake'
		end

		it 'should redirect to HP and warn if movie has no director info' do
			post :search_movies_with_given_director, { 
				:director => '', :movie => 'Alien'}
			response.should redirect_to(movies_path)
			flash[:warning].should == "'Alien' has no director info."
		end
	end
end