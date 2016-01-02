require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save post without content, date or author" do
    post = Post.new
    assert !post.save, "Saved the post without content, date or author"
  end


  test "should return only post with Anonyme as author" do
    post = Post.filter(:author => "Anonyme")
    assert_equal post.count, 2, "Didn't return the right posts"
  end


  test "should return only post newer than 2 days ago" do
    post = Post.filter(:from => 2.days.ago)
    assert_equal post.count, 1, "Didn't return the right posts"
  end


  test "should return only post older than 5 days ago" do
    post = Post.filter(:to => 5.days.ago)
    assert_equal post.count, 1, "Didn't return the right posts"
  end


  test "should return only post newer than 5 days ago from Giselle" do
    post = Post.filter(:author => "Giselle", :from => 5.days.ago)
    assert_equal post.count, 1, "Didn't return the right posts"
  end


  test "should get the API" do
    post = Post.filter(:author => "Giselle", :from => 5.days.ago)
    assert_equal post.count, 1, "Didn't return the right posts"
  end
end
