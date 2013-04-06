module VisitorLoggerFilter

  def self.included(base)
    base.class_eval do
      before_filter :visitor
    end
  end


  def visitor
    tracking_cookie_key = "TABI_REPO_VISITOR"

    begin
      # 管理者はカウントしない
      if (current_user && current_user.admin?)
        return;
      end

      today = Date.today.to_time.to_i
      visitor = Visitor.new({
        :date => today,
        :deviceregion => DeviceRegion.getValue(request.env["HTTP_USER_AGENT"])
        });

      real_tracking_cookie_key = tracking_cookie_key
      if (cookies[real_tracking_cookie_key]) 
        if (cookies[real_tracking_cookie_key].to_i < Date.today.prev_day.to_time.to_i)
          # repeater
          visitor.visitorregion = Visitor::VISITOR_REGION_REPEATER
          cookies[real_tracking_cookie_key] = today
          visitor.save
        end
      else
        # new
        visitor.visitorregion = Visitor::VISITOR_REGION_NEW
        cookies[real_tracking_cookie_key] = today
        visitor.save
      end
    end
  end

end
