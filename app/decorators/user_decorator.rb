class UserDecorator < Draper::Decorator
  delegate_all

  def nickname
    "#{object.nickname} "
  end

end
