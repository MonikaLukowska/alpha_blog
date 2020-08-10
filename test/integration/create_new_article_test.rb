require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email: 'jd@example.com', password: 'password', admin: true)
    sign_in_as(@admin_user)
  end

  test 'create new article' do
    get '/articles/new'
    assert_response :success

    post '/articles',
    params: {article: {title: 'Some article', description: 'some example description', category: ['Music']}} 
    assert_response :redirect

    follow_redirect!
    assert_response :success
    assert_match 'Some article', response.body
    assert_select 'div.alert-success'
  end

  test 'reject invalid submission and get new form' do
    get '/articles/new'
    assert_response :success

    post '/articles',
    params: { article: { title: '', description: '' } }
    
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
