module Api::V1
  class FilmsController < JSONAPI::ResourceController
    private
    def calculate_average_rating film
       total =  film.ratings.values.reduce { |total, number |
         total.to_f + number.to_f
       }
       return (total.to_f / film.ratings.size.to_f)
    end

    def valid_float? num
      Float(num) rescue false
    end

    public

    def submit_rating
      film = (Film.exists?(params[:film_id])) ? Film.find(params[:film_id]) : nil
      # && here insures that all expressions will be evaluated
      if(film && !params[:rating].blank? \
          && valid_float?(params[:rating]) \
          && !params[:user_id].blank?)
        film.ratings[params[:user_id]] = params[:rating]
        film.average_rating = calculate_average_rating(film)
        render body: nil, :status => :ok
      else
        if(!film)
          render body: nil, :status => :not_found
        else
          render body: nil, :status => :bad_request
        end
      end
    end
  end
end
