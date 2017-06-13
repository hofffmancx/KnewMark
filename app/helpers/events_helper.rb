module EventsHelper
  def render_created_at(create_at)
    create_at.strftime("%Y年%-m月%d日%H:%M")
  end

  def render_creator_name(event)
    link_to event.creator.username, "#"
  end

  def render_event_action(event)
     if event.eventable.class == Knowledge
      link_to event.eventable.title, knowledge_path(event.eventable)
     elsif event.eventable.class == Review
      link_to event.eventable.title, review_path(event.eventable)
     elsif event.eventable.class == Question
      link_to event.eventable.title, knowledge_question_path(event.eventable.knowledge, event.eventable)
     elsif event.eventable.class == Anwser
      link_to event.eventable.content, knowledge_question_path(event.eventable.question.knowledge, event.eventable.question)
     elsif event.eventable.class == Discussion
      link_to event.eventable.content, knowledge_discussions_path
     elsif event.eventable.class == Comment
      link_to event.eventable.content, review_path(event.eventable.review)
     end
  end
end
