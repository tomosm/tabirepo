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
      analytics_visitor = AnalyticsVisitor.new({
        :date => today,
        :deviceregion => DeviceRegion.getValue(request.env["HTTP_USER_AGENT"])
        });

      real_tracking_cookie_key = tracking_cookie_key
      if (cookies[real_tracking_cookie_key]) 
        if (cookies[real_tracking_cookie_key].to_i < Date.today.prev_day.to_time.to_i)
          # repeater
          analytics_visitor.visitorregion = AnalyticsVisitor::VISITOR_REGION_REPEATER
          cookies[real_tracking_cookie_key] = today
          analytics_visitor.save
        end
      else
        # new
        analytics_visitor.visitorregion = AnalyticsVisitor::VISITOR_REGION_NEW
        cookies[real_tracking_cookie_key] = today
        analytics_visitor.save
      end
    end
  end

end
