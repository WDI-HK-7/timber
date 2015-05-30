require "open-uri" 

namespace :scrape do 
  desc "Scrapping products on Fancy"
  task :fancy_products => :environment do
    
    url = "http://fancy.com"
    parsed_data = Nokogiri::HTML(open(url))
    OneLine(parsed_data)
    
    next_page  = parsed_data.css('.btn-more').attribute('ts').value
    url = "http://fancy.com/?feed=featured&next=#{next_page}"
  
    while (true) do
      parsed_data = Nokogiri::HTML(open(url))
      OneLine(parsed_data)
      puts next_page  = parsed_data.css('.btn-more').attribute('ts').value
      url = "http://fancy.com/?feed=featured&next=#{next_page}"
    end  
  end
end

def OneLine(parsed_data)
  photo = parsed_data.css('.stream li img')
  name  = parsed_data.css('.stream li figcaption .thing-url')
  price = parsed_data.css('.stream li .price')

  new_product = ScrapeProduct.new

  name.each_with_index do |item, index|
    new_product.photo = photo[index]['src']    unless photo[index].nil?
    new_product.name  = name[index].text.strip unless name[index].nil?
    new_product.price = price[index].text      unless price[index].nil?
  
    if new_product.save
      puts "#{new_product.name}saved in db"
    else
      puts "#{new_product.name}not saved in db"
    end
  end
end