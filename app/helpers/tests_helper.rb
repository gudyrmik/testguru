module TestsHelper
  def current_year
    Time.new.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end 
end
