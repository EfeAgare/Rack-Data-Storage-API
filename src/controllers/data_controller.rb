require 'digest'

require_relative '../data/registry'
require_relative './app_controller'

class DataController < AppController

  def upload
    repository = params[:repository]
    object_data = url_params.map{|k,v| "#{k}#{v}"}.join('&')
    object_id = Digest::SHA256.hexdigest(Time.now.to_i.to_s + repository.to_s + object_data.to_s)
    object_size = object_data.size

    unless DataRegistry.exists?(repository, object_id)
      data = DataRegistry.add(repository, object_id, object_size, object_data)
      render(data.to_json, 201, { 'Content-Type' => 'application/json' })
    else
      [200, {}, ['']]
    end
  end

  def download
    repository = params[:repository]
    object_id = params[:object_id]

    if DataRegistry.exists?(repository, object_id)
      object = DataRegistry.find(repository, object_id)
      render(object[:data], 200, {  'Content-Type' => 'application/json' })
    else
      not_found
    end
  end

  def delete
    repository = params[:repository]
    object_id = params[:object_id]

    if DataRegistry.exists?(repository, object_id)
      DataRegistry.delete(repository, object_id)
      [200, {}, ['']]
    else
      not_found
    end
  end
end
