require 'rails_helper'

describe Movie , :type => :model do
  describe "with a director" do
    before(:each) do
      @movie1 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie2 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie3 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie4 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Brenda")
    end

    it "should contain all movies" do
      expect(Movie.all).to include @movie1
      expect(Movie.all).to include @movie2
      expect(Movie.all).to include @movie3
      expect(Movie.all).to include @movie4
    end

    describe "if similar movies exist" do
        it "should find all similar movies and return 3 of them" do
            expect(Movie).to receive(:find_all_by_director).with(@movie3.director).and_return([@movie1 , @movie2 , @movie3])
            expect(Movie.find_all_by_director(@movie3.director).count).to eq(3)
        end
    end

    describe "if no similar movies exist" do
        it "should not find any similar movies except the same one" do
            expect(Movie).to receive(:find_all_by_director).with(@movie4.director).and_return([@movie4])
            expect(Movie.find_all_by_director(@movie4.director).count).to eq(1)
        end
        it "should not find any similar movies and return an empty list" do
            expect(Movie).to receive(:find_all_by_director).with("Non existing director").and_return([])
            expect(Movie.find_all_by_director("Non existing director").count).to eq(0)
        end
    end
  end
end