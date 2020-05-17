class KeyPairsController < ApplicationController
  before_action :authenticate

  def create
    key_pair = KeyPair.generate!

    render json: key_pair
  end

  def show
    sleep(5)
    key_pair = KeyPair.find_by_public_key(params[:id].gsub(/\.json$/, ''))

    render json: key_pair
  end

  private

  def authenticate
    head :forbidden unless params[:api_id] == ENV['API_SECRET']
  end
end
