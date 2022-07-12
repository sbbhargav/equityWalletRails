module ApplicationHelper

  def back_link(path)
    link_to 'back', path, class: 'btn btn-secondary'
  end
  def delete_link(path,style_class)
    link_to 'delete', path,data: {
      turbo_method: :delete,
      turbo_confirm: "Are you sure?"
    }, class: style_class
  end

  def show_link(path,style_class)
    link_to 'show', path, class: style_class
  end

  def edit_link(path,style_class)
    link_to 'edit', path, class: style_class
  end

  def check_errors(user_model,attribute)
    user_model.errors.include?(attribute)
  end

  def check_valid(user_mod,attrib,invalid)
    render 'shared/alerts',user_model: user_mod,attribute: attrib if invalid
  end

  def login_helper(style)
    if logged_in? 
      (link_to 'dashboard', dashboard_path, class: "#{style} header-space") +
      (link_to 'stocks summary', summary_path, class: "#{style} header-space") +
      (link_to 'Amount summary', amount_path, class: "#{style} header-space") +
      (link_to 'Total  stocks', total_stocks_path, class: "#{style} header-space") +
      (link_to 'Total  Amount', total_amount_path, class: "#{style} header-space")
    else
      (link_to 'Register', sign_up_path, class: "#{style} header-space") +
      (link_to 'Login', login_path, class: "#{style} header-space") 
    end

  end

  def login_name
    if logged_in?
      content_tag(:div,current_user.username)
    end
  end


end
