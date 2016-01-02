require 'test_helper'

class Vdm::BaseTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test 'GET /api/v1/posts returns an empty array of statuses' do
    # Construct the desired output
    output = {'posts' => [], 'count' => Post.count}
    Post.all.each do |post|
      output['posts'].push('id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author)
    end

    get '/api/v1/posts'
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end


  test 'GET /api/v1/posts/:id returns a post by id' do
    post = Post.first
    # Construct the desired output
    output = {'post' => {'id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author}}

    get "/api/v1/posts/#{post.id}"
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end


  test "GET /api/v1/posts?from=#{5.days.ago.to_date} returns posts newer than 5 days ago" do
    posts = Post.filter(:from => 5.days.ago)
    # Construct the desired output
    output = {'posts' => [], 'count' => posts.count}
    posts.each do |post|
      output['posts'].push('id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author)
    end

    get "/api/v1/posts?from=#{5.days.ago.to_date}"
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end


  test "GET /api/v1/posts?from=#{5.days.ago.to_date}&to=#{1.day.ago.to_date} returns posts newer than 5 days ago but older than yesterday" do
    posts = Post.filter(:from => 5.days.ago, :to => 1.day.ago)
    # Construct the desired output
    output = {'posts' => [], 'count' => posts.count}
    posts.each do |post|
      output['posts'].push('id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author)
    end

    get "/api/v1/posts?from=#{5.days.ago.to_date}&to=#{1.day.ago.to_date}"
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end


  test "GET /api/v1/posts?author=Giselle returns posts from Giselle" do
    posts = Post.filter(:author => "Giselle")
    # Construct the desired output
    output = {'posts' => [], 'count' => posts.count}
    posts.each do |post|
      output['posts'].push('id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author)
    end

    get "/api/v1/posts?author=Giselle"
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end


  test "GET /api/v1/posts?from=#{15.days.ago.to_date}&to=#{5.days.ago.to_date}&author=Giselle returns posts from Giselle newer than 15 days ago but older than 5 days ago" do
    posts = Post.filter(:from => 15.days.ago, :to => 5.days.ago, :author => "Giselle")
    # Construct the desired output
    output = {'posts' => [], 'count' => posts.count}
    posts.each do |post|
      output['posts'].push('id' => post.id, 'content' => post.content, 'date' => post.date, 'author' => post.author)
    end

    get "/api/v1/posts?from=#{15.days.ago.to_date}&to=#{5.days.ago.to_date}&author=Giselle"
    assert last_response.ok?
    assert_equal output, JSON.parse(last_response.body)
  end
end