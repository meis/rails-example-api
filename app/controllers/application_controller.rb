class ApplicationController < ActionController::API
  def index
    render :json => { health: true }
  end
end
