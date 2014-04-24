class ApprenticeshipsController < ApplicationController

  respond_to :json

  before_action :get_apprenticeship, only: [ :update, :destroy ]

  def index
    @apprenticeships = if params[:id]
      Apprenticeship.where('id in (?)', params[:id].split(','))
    else
      Apprenticeship.all
    end

    @users = (@apprenticeships.map { |apprenticeship| [apprenticeship.master, apprenticeship.apprentice] }).flatten.sort.uniq
    @ratings = (@apprenticeships.map { |apprenticeship| apprenticeship.ratings }).flatten.sort.uniq
  end

  def create
    apprenticeship = Apprenticeship.new apprenticeship_params

    if apprenticeship.save
      head :created, location: apprenticeship_url(apprenticeship)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @apprenticeship.update(apprenticeship_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @apprenticeship.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def apprenticeship_params
    params.require(:apprenticeship).permit()
  end

  def get_apprenticeship
    head :not_found unless @apprenticeship = Apprenticeship.where('id = ?', params[:id]).take
  end
end