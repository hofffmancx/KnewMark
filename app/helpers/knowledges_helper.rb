module KnowledgesHelper
  def render_knowledge_status(knowledge)
    case knowledge.status
    when "published"
      content_tag(:span, "已上线", :class => "label label-success")
    when "hidden"
      content_tag(:span, "审核中", :class => "label label-warning")
    when "failed"
      content_tag(:span, "未通过", :class => "label label-danger")
    end
  end
end
