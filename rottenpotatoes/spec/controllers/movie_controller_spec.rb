require 'spec_helper'
require 'rails_helper'

describe MoviesController , :type => :controller do
    describe "POST 'similar_movies'" do
        before(:each) do
            @fake_results = [double('movie1'), double('movie2')]
            @movie = Movie.create!(:title => "Title", :rating => "Rating", :director => "Director", :release_date => Time.now)
        end

        it "should call the model method that finds similar movies" do
            expect(Movie).to receive(:find_all_by_director).with(@movie.director)
            post :show_director , :id => @movie.id
        end

        describe "with a valid director" do
            before(:each) do
                expect(Movie).to receive(:find_all_by_director).and_return(@fake_results)
                post :show_director, :id => @movie.id
            end

            it "should render the correct template" do
                expect(response).to render_template('show_director')
            end

            it "should make results available to the template" do
                expect(assigns(:movies_list)).to eq(@fake_results)
            end
        end
    end
    
    describe "Controller Test" do
        before :each do
            @movie_new = FactoryGirl.build(:movie) #keeps movie_new only in memory
            @movie = FactoryGirl.create(:movie)  #creates the instance and keeps it in DB
            @movie_params = FactoryGirl.attributes_for(:movie) #params for movie passed from the view to controller
        end
        it "index" do
            get :index
            expect(assigns(:movies).count).to eq(1)
        end
        it "do not have title" do
            @movie_without_director = FactoryGirl.create(:movie,:title => 'Movie without director',:director => '')
            post :show_director,:id => @movie_without_director.id
            expect(assigns(:movies_list)).to eq(nil)
            expect(flash[:notice]).to be_present
            expect(response).to redirect_to(movies_path)
        end

        it "create" do
            expect { post :create, :movie => @movie_params }.to change(Movie, :count).by(1)
        end

        it "show" do
            get :show,:id => @movie.id
            expect(assigns(:movie)).to eq(@movie)
        end

        it "edit" do
            get :edit, {:id => @movie.to_param}
            expect(assigns(:movie)).to eq(@movie)
        end

        it "update" do
            put :update, {:id => @movie.to_param , :movie => @movie_params}
            expect(response).to redirect_to(movie_path(@movie))
        end

        it "delete" do
            movie = FactoryGirl.create(:movie)
            expect {
                delete :destroy, {:id => movie.to_param}
            }.to change(Movie, :count).by(-1)
        end
    end
end