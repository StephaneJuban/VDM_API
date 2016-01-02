class PageController < ApplicationController

  # This is our homepage
  def index
  end

  # Get the 200 last posts from VDM
  def vdm
    # Require Nokogiri and Open URI to scrap the webpage
    require 'nokogiri'
    require 'open-uri'

    # The current page to fetch
    page    = 0
    # The array of VDM
    @vdm = Array.new

    while @vdm.length < NB_OF_VDM_TO_GET do
      @page = Nokogiri::HTML(open("http://www.viedemerde.fr/?page=#{page}"))
      @page.css('.post.article').each do |article|
        @vdm.length < NB_OF_VDM_TO_GET ? @vdm << article : break
      end
    end
  end

end
