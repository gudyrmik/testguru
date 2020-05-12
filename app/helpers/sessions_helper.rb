module SessionsHelper

  def show_flash(key)
    content_tag :p, flash[key], class: "flash #{key}"
  end

end