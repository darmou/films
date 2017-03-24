class Film < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :url_slug, presence: true
  validate :related_film_ids_must_exist
  validate :year_must_be_four_digit_number_or_nil

  def related_film_ids_must_exist
    if(related_film_ids.size > 0)
      related_film_ids.each { | film_id|
        if(!Film.exists?(film_id))
          errors.add(:related_film_ids, "Film with id #{film_id} does not exist in the database.")
        end
      }

    end
  end

  def year_must_be_four_digit_number_or_nil
    if(year)
      unless year.to_i.is_a?(Integer) && year.to_s.length == 4
        errors.add(:year, "Year must be unspecified or a 4 digit number.")
      end
    end
  end
end
