module ArticleLoggerFilter
  
  def self.included(base)
    base.class_eval do
      before_filter :view, :only => [:show]
    end
  end

  def view
    tracking_cookie_key = "TABI_REPO_ARTICLE"

    begin
      article = Article.find(params[:id])
      # 記事と同じユーザー、あるいは管理者はカウントしない
      if (current_user && (current_user.id == article.user_id || current_user.admin?))
        return;
      end

      today = Date.today.to_time.to_i
      last_article_id = last_view(tracking_cookie_key + "_PRE", article.id)

      reader = Reader.new({
        :article_id => article.id,
        :date => today,
        :deviceregion => DeviceRegion.getValue(request.env["HTTP_USER_AGENT"])
        });
      reader.last_article_id = last_article_id unless !last_article_id

      real_tracking_cookie_key = tracking_cookie_key + article.id.to_s
      if (cookies[real_tracking_cookie_key]) 
        if (cookies[real_tracking_cookie_key].to_i < Date.today.prev_day.to_time.to_i)
          # repeater
          reader.visitorregion = Visitor::VISITOR_REGION_REPEATER
          cookies[real_tracking_cookie_key] = today
          reader.save
        end
      else
        # new
        reader.visitorregion = Visitor::VISITOR_REGION_NEW
        cookies[real_tracking_cookie_key] = today
        reader.save
      end
    end
  end

  def last_view(real_tracking_cookie_key, article_id)
    last_article_id = cookies[real_tracking_cookie_key]
    cookies[real_tracking_cookie_key] = article_id
    last_article_id
  end

end
