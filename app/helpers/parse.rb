require 'nokogiri'
require 'rest-client'
require 'open-uri'

module Parse
    
    class Movie
        def self.movie
            @movie_title=Array.new
            doc = Nokogiri::HTML(open("https://movie.naver.com/#"))
            doc.css('div.detail a').each do |location|      #div 에서 a데려와라
                @movie_title << "https://movie.naver.com"+location.attr("href")
            end
            
            @movie_title.sample.to_s
        end
    end
    
    class Animal
        def self.cat
            #@text=["cheese","mango","nabi"].sample
            @url="http://thecatapi.com/api/images/get?format=xml&type=jpg"
            @cat_xml =RestClient.get(@url)
            @cat_doc  = Nokogiri::XML(@cat_xml)
            cat_url = @cat_doc.xpath("//url").text  #url불러와라
        end
    end
end