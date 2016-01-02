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
    page = 0

    # First of all empty the database
    Post.delete_all
    # The number of records
    count = 0

    while count < NB_OF_VDM_TO_GET do
      html = Nokogiri::HTML(open("http://www.viedemerde.fr/?page=#{page}"))

      html.css('.post.article').each do |article|
        # Get the content of the VDM
        content = article.css('p').first.text

        # Get the infos splitted (e.g. "Le jj/mm/yyyy à hh:mm - category - par author")
        infos   = article.css('.date .right_part p')[1].text.split(' - ')
        date    = infos.first
        author  = infos.last.match(/par (\S+)/i)[1]

        if count < NB_OF_VDM_TO_GET
          Post.create(:content => content, :date => date, :author => author)
          count += 1
        else
          break
        end

      end

      page += 1
    end

  end

end
