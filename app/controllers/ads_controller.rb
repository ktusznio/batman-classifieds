class AdsController < ApplicationController
  respond_to :json
  def index
    query = Ad.scoped

    query = case params[:filter]
    when 'free', 'trade'
      query.active.where(:sale_type => params[:filter])
    when 'closed'
      query.closed
    else
      query.active
    end

    @ads = query.includes(:images).order('id DESC')
    respond_with @ads
  end

  def new
    @ad = Ad.new
    respond_with @ad
  end

  def create
    @ad = current_user.ads.new(params[:ad])
    @ad.activate
    respond_with @ad
  end

  def show
    @ad = Ad.find(params[:id])
    @other_ads = @ad.user.ads.where(['id <> ?', @ad.id]).order('id DESC').limit(3)
    respond_with @ad
  end

  def update
    @ad = Ad.find(params[:id])
    @ad.update_attributes(params[:ad])
    respond_with @ad
  end

  def close
    @ad = Ad.find(params[:id])
    @ad.close
    respond_with @ad
  end

  def search
    index = SearchIndex.new
    results = index.search(params[:q])
    @ads = Ad.active.where(['id IN (?)', results.ids]).page(params[:page]).per_page(6).includes(:images).order('id DESC')
    respond_with @ads
  end
end
