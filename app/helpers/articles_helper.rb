module ArticlesHelper
  def to_value (model) 
    if (model) 
      model.value
    else
      ""
    end
  end

  def htmlspace (value) 
    if (value == "") 
      "&nbsp;"
    else
      value
    end
  end

  def to_color (model) 
    if (model) 
      model.color
    else
      "#000"
    end
  end

  def to_tags_value(model)
    tags = ""

    tags += to_attribute(model.country)
    tags += to_attribute(model.vihicle)
    tags += to_attribute(model.member)
    tags += to_attribute(model.purpose)
    tags += to_attribute(model.budget)
    tags += to_attribute(model.language)
    tags += to_attribute(model.age)

    if (tags.length - 1 === tags.rindex("/"))
      tags.chop!
    end

    tags
  end

  def join_planning?(plannings, target_planning)
    plannings.each do |planning|
      if planning.id === target_planning.id
        return true
      end
    end
  end

  private 
  def to_attribute (model)
    raw_value = to_value(model)
    if raw_value != ""
      raw_value + "/"
    else
      raw_value
    end 
  end
end
