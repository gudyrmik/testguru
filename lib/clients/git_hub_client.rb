class GitHubClient
  ACCESS_TOKEN = 'e66d8c6cc431331fc2270c70ef221ab47ea632ac'
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
    Octokit::Client.new(access_token: ACCESS_TOKEN)
  end
end