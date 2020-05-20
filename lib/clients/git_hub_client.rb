class GitHubClient

  ROOT_ENDPOINT = 'https://api.github.com'
  #ACCESS_TOKEN2 = '3c644ef6ddc8036c4aae97d9698d1b9b900afd3b'

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    @http_client.create_gist(params.to_json)
  end

  def get_all_gists
    @http_client.gists(@http_client.user[:login])
  end

  def get_email
    user = @http_client.user
    user[:email] || user[:login]
  end

  def get_question(gist)
    url = gist[:files][:"test-guru-question.txt"][:raw_url]
    @http_client.get(url).split("\n").first
  end

  private

  def setup_http_client
    Octokit::Client.new(access_token: ENV['ACCESS_TOKEN2'])
  end
end