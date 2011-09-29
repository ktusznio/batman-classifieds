require 'test_helper'

class AdsControllerTest < ActionController::TestCase
  test "create a new ad" do
    user = users(:cody)

    login_as(user)
    
    assert_difference 'user.ads.count', +1 do
      post :create, :ad => {
        :title => "Happy kittens",
        :description => "I love kittens, you should too.",
        :sale_type => "fixed",
        :price => 10.00
      }
    end

    ad = assigns(:ad)
    assert ad.active?
    assert_response :redirect
    assert_redirected_to ads_url
  end
end
