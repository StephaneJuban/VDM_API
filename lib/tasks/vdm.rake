# Require Nokogiri and Open URI to scrap the webpage
require 'nokogiri'
require 'open-uri'


namespace :vdm do
  desc "Get the last X posts from VDM"
  task :get_posts => :environment do
    # The current page to fetch
    page = 0

    # First of all empty the database
    Post.delete_all
    # Reset the ID of the database
    ActiveRecord::Base.connection.reset_pk_sequence!(Post)
    # The number of records
    count = 0

    while count < ENV["NB_OF_VDM_TO_GET"].to_i do
      html = Nokogiri::HTML(open("http://www.viedemerde.fr/?page=#{page}"))

      html.css('.post.article').each do |article|
        # Get the content of the VDM
        content = article.css('p').first.text

        # Get the infos splitted (e.g. "Le jj/mm/yyyy à hh:mm - category - par author")
        infos   = article.css('.date .right_part p')[1].text.split(' - ')
        date    = infos.first
        author  = infos.last.match(/par (\S+)/i)[1]

        if count < ENV["NB_OF_VDM_TO_GET"].to_i
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