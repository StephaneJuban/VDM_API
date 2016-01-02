class PageController < ApplicationController

  # This is our homepage
  def index
    @url_all    = "#{request.base_url}/api/v1/posts"
    @url_author = "#{request.base_url}/api/v1/posts?author=Anonyme"
    @url_date   = "#{request.base_url}/api/v1/posts?from=#{1.week.ago.to_date}"
    @url_full   = "#{request.base_url}/api/v1/posts?author=Anonyme&from=#{2.weeks.ago.to_date}&to=#{1.day.ago.to_date}"
  end

  # Get the 200 last posts from VDM
  def vdm
    # This is not a best practice to call a rake task inside the controller
    # This is just to demonstrate the behavior of the task
    %x[rake vdm:get_posts NB_OF_VDM_TO_GET=200]
  end

end
