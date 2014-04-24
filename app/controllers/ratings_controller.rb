class RatingsController < ApplicationController
  respond_to :json

  before_action :get_rating, only: [ :update, :destroy ]

  def index
    @ratings = if params[:id]
      Rating.where('id in (?)', params[:id].split(','))
    else
      Rating.all
    end

    @users = (@ratings.map { |rating| [rating.rater, rating.ratee] }).flatten.sort.uniq
    @apprenticeships = (@ratings.map { |rating| rating.apprenticeship }).sort.uniq
  end

  def create
    rating = Rating.new rating_params

    if rating.save
      head :created, location: rating_url(rating)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @rating.update(rating_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @rating.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def rating_params
    params.require(:rating).permit()
  end
  def get_rating
    head :not_found unless @rating = Rating.where('id = ?', params[:id]).take
  end
end