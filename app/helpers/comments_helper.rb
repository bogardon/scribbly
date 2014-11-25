module CommentsHelper
  def comment_row_html(c)
    "<div class='row'>
      <div class='small-6 small-centered columns'>
        <div class ='row'>
          <div class='small-2 columns'>
            #{image_tag(c.user.avatar.url)}
          </div>
          <div class='small-10 columns'>
            #{c.body}
          </div>
        </div>
      </div>
    </div>".html_safe
  end
end
