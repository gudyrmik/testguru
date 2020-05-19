module ApplicationHelper

  def flash_key_to_bootstrap_class(type)
    { notice: 'alert-info', alert: 'alert-info' }[type.to_sym]
  end
end
