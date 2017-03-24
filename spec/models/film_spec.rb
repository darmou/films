require "rails_helper"

RSpec.describe Film, :type => :model do
  it "can only be created with non blank attributes" do
    film = Film.new
    film.title = '' # invalid state
    film.valid? # run validations
    expect(film.errors[:title]).to include("can't be blank") # check for presence of error
    expect(film.errors[:description]).to include("can't be blank")
    expect(film.errors[:url_slug]).to include("can't be blank")
  end

  it "can only be created using related_film_ids if those ids exist in the database" do
    film = Film.new
    film.title = "test"
    film.description = "test desc"
    film.url_slug = "test"
    film.related_film_ids = [10,3]
    film.valid?
    expect(film.errors[:related_film_ids]).to include("Film with id 3 does not exist in the database.")
    expect(film.errors[:related_film_ids]).to include("Film with id 10 does not exist in the database.")
  end

  it "can only be a 4 digit number" do
    film = Film.new
    film.title = "test"
    film.description = "test desc"
    film.url_slug = "test"
    film.year = 21
    film.valid?
    expect(film.errors[:year]).to include("Year must be unspecified or a 4 digit number.")

  end
end