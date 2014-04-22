class SiteController < ApplicationController
  before_action :is_authenticated?, except: [:privacy, :terms]

  def index_template
    @user = @current_user #FIXME
  end

  def privacy
  end

  def terms
  end
end