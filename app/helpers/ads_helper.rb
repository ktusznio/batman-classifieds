module AdsHelper
  def format(text)
    simple_format(auto_link(text))
  end

  def display_price(ad)
    case ad.sale_type
    when 'fixed'
      number_to_currency(ad.price)
    when 'free'
      'free'
    when 'trade'
      'trade/swap'
    end
  end

  def feature_image(ad)
    if ad.images.length > 0
      ad.images.first.image.url(:thumb)
    else
      'http://placekitten.com/g/135/135'
    end
  end
end
