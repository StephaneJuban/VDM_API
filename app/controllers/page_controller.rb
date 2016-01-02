class PageController < ApplicationController

  # This is our homepage
  def index
  end

  # Get the 200 last posts from VDM
  def vdm
    # This is not a best practice to call a rake task inside the controller
    # This is just to demonstrate the behavior of the task
    %x[rake vdm:get_posts NB_OF_VDM_TO_GET=200]
  end

end
