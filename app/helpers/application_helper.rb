module ApplicationHelper
  def time_ago(model)
    if model.created_at.present?
      timeago_tag model.created_at, :nojs => true, :limit => 10.days.ago, :lang => :"zh-CN"
    elsif model.updated_at.present?
      timeago_tag model.updated_at, :nojs => true, :limit => 10.days.ago, :lang => :"zh-CN"
    end
  end
end
