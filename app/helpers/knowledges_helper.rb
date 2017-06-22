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

  def render_highlight_content(knowledge,query_string)
    excerpt_cont = excerpt(knowledge.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
  #可以高亮，但是逻辑有问题

  def render_activity_count(knowledge)
    sum1 =  knowledge.activities.count
    sum2 = 0
    knowledge.questions.each do |question|
      sum2 += question.activities.count
    end
    sum3 = 0
    knowledge.reviews.each do |review|
      sum3 += review.activities.count
    end
    sum4 = 0
    knowledge.discussions.each do |discussion|
      sum4 += discussion.activities.count
    end
    sum5 = 0
    knowledge.reviews.each do |review|
      review.comments.each do |comment|
        sum5 += comment.activities.count
      end
    end
    sum6 = 0
    knowledge.questions.each do |question|
      question.anwsers.each do |anwser|
        sum6 += anwser.activities.count
      end
    end
     sum1+sum2+sum3+sum4+sum5+sum6
  end



end
