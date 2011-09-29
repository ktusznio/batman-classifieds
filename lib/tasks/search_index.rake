namespace :search_index do
  
  desc "add all ads to the index"
  task :bootstrap => :environment do
    index = SearchIndex.new
    index.import_all
  end
  
  desc "remove the search index"
  task :flush => :environment do
    index = SearchIndex.new
    index.drop
    index.create
  end
  
end