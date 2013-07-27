module ApplicationHelper
  def noimage_tag(size, keys = {})
    width = 480
    height = 480
    if size == :small
      width = 360
      height = 360
    elsif size == :thumb
      width = 135
      height = 135
    end
    clazz = keys.fetch(:class, "")
    if (clazz != "") 
      image_tag "common/noimage.jpg", :width => width, :height => height, :class => clazz
    else
      image_tag "common/noimage.jpg", :width => width, :height => height
    end
  end
end
