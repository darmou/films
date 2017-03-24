class Api::V1::FilmResource < JSONAPI::Resource
  attributes :title, :description, :url_slug, :year, :average_rating, :related_film_ids

  filters :title, :url_slug, :year

end
