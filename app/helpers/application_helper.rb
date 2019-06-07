module ApplicationHelper
  def auth_token
    "<input type='hidden'
      name='authentication_token'
      value='#{ h(form_authentication_token) }'>".html_safe
  end
end
