require 'test_helper'

class SignUpAUserTest < ActionDispatch::IntegrationTest
  
  test 'get signup form and create new user' do
    get '/signup'
    assert_response :success

    post '/users',
    params: { user: { username: "johndoe", email: 'jd@example.com', password: 'password' } }
    assert_response :redirect

    follow_redirect!
    assert_response :success
    assert_match 'johndoe', response.body
    assert_match 'Articles listing page', response.body
  end

  test 'get new signup form and reject invalid submition' do
    get '/signup'
    assert_response :success
    post '/users',
    params: { user: { username: "johndoe", email: 'jd@example', password: 'password' } }

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
