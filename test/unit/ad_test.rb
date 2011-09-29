require 'test_helper'

class AdTest < ActiveSupport::TestCase

  test "allows em, strong, a tags in ad description" do
    description = "Listens to the name <em>TIGER</em>. Ideal for breeding. Somehwat tame, willing to trade for expensive dog or bag o' coffee or videogames."
    
    ad = Ad.new(
           :title => "Cheap Kitten",
           :sale_type => 'fixed',
           :price => 10.00,
           :description => description
         )
    assert ad.save
    assert_equal description, ad.description
  end
  
  test "sanitizes non-em, strong, a tags in ad description" do
    description = "Listens to the name <em>TIGER</em>. Ideal for breeding. Somehwat tame, willing to trade for expensive dog or bag o' coffee or videogames. <p>This will be stripped</p>"
    sanitized_description = "Listens to the name <em>TIGER</em>. Ideal for breeding. Somehwat tame, willing to trade for expensive dog or bag o' coffee or videogames. This will be stripped"
    
    ad = Ad.new(
           :title => "Cheap Kitten",
           :sale_type => 'fixed',
           :price => 10.00,
           :description => description
         )
    assert ad.save
    assert_equal sanitized_description, ad.description
    
    ad.save
  end
  
  test "nullify price if sale_type is not fixed" do
    ad = Ad.new(
           :title => "Cheap Kitten",
           :sale_type => 'free',
           :price => 10.00,
           :description => "cute, very cute"
         )
    assert ad.save
    assert_nil ad.price
  end
  
  test "price must be greater than 0 when price is fixed" do
    ad = Ad.new(
           :title => "Cheap Kitten",
           :sale_type => 'fixed',
           :price => 0,
           :description => "cute, very cute"
         )
    assert !ad.valid?
    assert ad.errors['price']
  end
end
