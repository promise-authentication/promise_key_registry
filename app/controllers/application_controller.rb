class ApplicationController < ActionController::API
  def index
    render json: {hello: 'World'}
  end
end
