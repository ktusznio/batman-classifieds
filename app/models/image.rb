class Image < ActiveRecord::Base
  belongs_to :ad
  has_attached_file :image,
    :styles => { :medium => "480x480>", :thumb => "135x135>" },
    :s3_credentials => {
      :access_key_id => 'AKIAJ3H5U6WTJBQT6WLA',
      :secret_access_key => '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'
    },
    :storage => :s3,
    :bucket => 'classifieds-images-batman',
    :path => 'app/public/system/images/:id/:style/:filename?:updated_at'
  #process_in_background :image

  def urls
    {:medium => image.url(:medium), :thumb => image.url(:thumb)}
  end
end
