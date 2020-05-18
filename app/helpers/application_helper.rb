module ApplicationHelper

  def flash_key_to_bootstrap_class(key)
    case key
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    end
  end
end
