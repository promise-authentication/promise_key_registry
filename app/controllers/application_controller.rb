class ApplicationController < ActionController::API
  def index
    key = RbNaCl::PrivateKey.generate
    render json: {hello: Base64.strict_encode64(key.public_key)}
  end
end
