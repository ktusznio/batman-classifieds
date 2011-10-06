class LocalesController < ApplicationController
  def show
    render :json => numberize_hash_keys(YAML.load(File.read(File.join(Rails.root, 'config', 'locales', params[:id]) + ".yml")))
  end

  private
  def numberize_hash_keys(hash)
    if hash.is_a?(Hash)
      hash.inject({}) do |acc, (k, v)|
        if v.is_a?(String)
          acc[numberize_key(k)] = v
        else
          acc[k] = numberize_hash_keys(v)
        end
        acc
      end
    else
      hash
    end
  end

  def numberize_key(key)
    case key
      when 'one'
        1
      when 'two'
        2
      when 'three'
        3
      when 'four'
        4
      else
        key
    end
  end
end
