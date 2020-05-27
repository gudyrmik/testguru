class GitHubClient
  # этот класс из скринкаста, на вырост, если захотим разных хттп клиентов сделать
  # в текущей реализации я согласен что он не нужен, но наверное пусть останется...
  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    @http_client.create_gist(params.to_json)
  end

  private

  def setup_http_client
    Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
  end
end