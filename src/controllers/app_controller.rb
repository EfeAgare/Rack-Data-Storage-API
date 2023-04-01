class AppController
  attr_accessor :params, :url_params

  def params 
    @params ||= {}
  end

  def not_found
    [404, { 'Content-Type' => 'application/json' }, ["Object Not Found"]]
  end

  def render(content, status = 200, headers = {})
    [status.to_s, headers, [content]]
  end 
end
