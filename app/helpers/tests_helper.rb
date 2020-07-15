module TestsHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def duration_helper(duration)
    if duration.zero?
      t('.duration_unlim') 
    else
      duration
    end
  end
end
