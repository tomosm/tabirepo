module TodaysPhotoFilter

  def self.included(base)
    base.class_eval do
      before_filter :todays_photo
    end
  end


  def todays_photo
    file_list = []

    Dir.foreach("app/assets/images/todays") do |file|
      if file != "." && file != ".."
        file_list.push(file)
      end
    end

    @todays_photo = {"path" => "todays/" + file_list[Date.today.to_s.gsub("-", "").to_i % file_list.length].to_s}
    @todays_photo
  end

end
