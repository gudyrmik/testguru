class GistQuestionService

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client || GitHubClient.new # а разве не коряво что дефолтный клиент совпадает с тем который мы тут присваиваем?
  end

  def call
    @result = @client.create_gist(gist_params)
  end

  def success?
    @result.nil? || result.empty?
  end

  private

  def default_client
    GitHubClient.new
  end

  def gist_params
    {
      description: "A question about #{@test.title} from TestGuru",
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end