module ApplicationHelper
   # Returns the full title on a per-page basis.
   def full_title(page_title = '')
      base_title = "Ruby on Rails Tutorial Sample App"
      if page_title.empty?
         base_title
      else
         "#{page_title} | #{base_title}"
      end
   end
   
   def link_show(page_title = '')
      if page_title == "Home"
         {home: "" ,help: "Help" ,contact: "Contact" ,about: "About"}
      elsif page_title == "Help"
         {home: "Home" ,help: "" ,contact: "Contact" ,about: "About"}
      elsif page_title == "Contact"
          {home: "Home" ,help: "Help" ,contact: "" ,about: "About"}
      elsif page_title == "About"
           {home: "Home" ,help: "Help" ,contact: "Contact" ,about: ""}
      end
   end
end
