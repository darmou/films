class StaticController < ApplicationController



  def show
    valid = %w(swagger)

    if valid.include?(params[:page])
      render "public/#{params[:page]}.json"
    else
      render :file   => File.join(Rails.root, 'public', '404.html'),
             :status => 404
    end
  end
end