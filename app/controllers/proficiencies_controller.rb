class ProficienciesController < ApplicationController

  respond_to :json

  before_action :get_parent
  before_action :get_proficiency, only: [ :update, :destroy ]

  def index
    @proficiencies = if params[:id]
      Proficiency.where("id in (?) #{@parent_clause}", params[:id].split(','))
    else
      @parent ? @parent.proficiencies : Proficiency.all
    end

    @users = (@proficiencies.map { |proficiency| proficiency.user }).sort.uniq
    @skills = (@proficiencies.map { |proficiency| proficiency.skill }).sort.uniq
  end

  def create
    proficiency = Proficiency.new proficiency_params

    if proficiency.save
      head :created, location: proficiency_url(proficiency)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @proficiency.update(proficiency_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @proficiency.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def proficiency_params
    params.require(:proficiency).permit()
  end

  def get_parent
    @parent_clause = if params[:user_id]
      head :bad_request unless @parent = User.where('id = ?', params[:user_id]).take
      "and user_id = #{@parent.id}"
    elsif params[:skill_id]
      head :bad_request unless @parent = Skill.where('id = ?', params[:skill_id]).take
      "and skill_id = #{@parent.id}"
    else
      ""
    end
  end

  def get_proficiency
    head :not_found unless @proficiency = Proficiency.where("id = ? #{@parent_clause}", params[:id]).take
  end
end
