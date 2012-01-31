module ApplicationHelper
  # Return a title on a per page basis
  def title
    base_title = "ThisMonth"
    if @title.nil?
      return base_title
    else
      return "#{base_title} | #{@title}"
    end
  end

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :class => 'gravatar',
                        :alt => h(user.name),
                        :gravatar => options)
  end
end
