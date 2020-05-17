require 'test_helper'

class KeyPairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @old = ENV['API_SECRET']
    @secret = 'world'
    ENV['API_SECRET'] = @secret
  end
  teardown do
    ENV['API_SECRET'] = @old
  end

  test 'authentication' do
    post '/api/foo/key_pairs'
    assert_response :forbidden
  end

  test 'full circle' do
    post "/api/#{@secret}/key_pairs"
    assert_response :success

    key_pair = KeyPair.last

    json = JSON.parse(response.body)
    assert_equal key_pair.public_key, json['public_key']
    assert_equal key_pair.private_key, json['private_key']

    ping = Time.now
    get "/api/#{@secret}/key_pairs/#{json['public_key']}.json"
    pong = Time.now

    assert_equal (pong-ping).round, 5
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal key_pair.public_key, json['public_key']
    assert_equal key_pair.private_key, json['private_key']
  end
end
