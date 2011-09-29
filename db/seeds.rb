1.upto(10).each do |n|
  ad = Ad.new(
    :title => "Cheap Kitten #{n}",
    :description => "Listens to the name <em>TIGER</em>. Ideal for breeding. Somehwat tame, willing to trade for expensive dog or bag o' coffee or videogames.",
    :price => 10.00 + n,
    :sale_type => 'fixed'
  )
  ad.activate
end