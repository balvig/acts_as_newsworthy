require File.dirname(__FILE__) + '/spec_helper'

describe ActsAsNewsworthy do
  it "should generate method has_new_additions?" do
    Post.acts_as_newsworthy
    Post.should respond_to(:has_new_additions?)
  end

  describe "default settings" do
    before(:all) do
      Post.acts_as_newsworthy
    end
    
    it "should return true if a post has been created within the last 14 days" do
      post = Post.create(:created_at => Date.today)
      Post.should have_new_additions
      post.should be_new
    end

    it "should return false if no posts have been created within the last 14 days" do
      post = Post.create(:created_at => 15.days.ago)
      Post.should_not have_new_additions
      post.should_not be_new
    end
  end
  
  describe "custom settings" do
    before(:all) do
      Post.acts_as_newsworthy :days => 28, :field => :published_at
    end
    
    it "should return true if a post has been published within the last 28 days" do
      post = Post.create(:published_at => Date.today)
      Post.should have_new_additions
      post.should be_new
    end

    it "should return false if no posts have been published within the last 28 days" do
      post = Post.create(:published_at => 29.days.ago)
      Post.should_not have_new_additions
      post.should_not be_new
    end
  end
  
end