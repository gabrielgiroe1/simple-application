module ApplicationHelper
  # Return the full title on a per-page basic
  def full_title(page_title ='')
    base_title = 'Ruby on Rails Tutorial Simple App'
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
