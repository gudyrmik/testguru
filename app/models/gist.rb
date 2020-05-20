class Gist < ApplicationRecord

  def self.all_gists
    GitHubClient.new.get_all_gists
  end

  def self.question(gist)
    GitHubClient.new.get_question(gist)
  end

  def self.gist_question_path(question_from_gist)
    Question.find_by(body: question_from_gist)
  end

  def self.email
    GitHubClient.new.get_email
  end

end