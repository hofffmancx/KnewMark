class KnowledgeMailer < ApplicationMailer
  def notify_knowledge_passed(knowledge)
    @knowledge       = knowledge
    @user        = knowledge.user

    mail(to: @user.email, subject: "您提交的内容#{knowledge.title}已经上线，请前往查看")
  end

  def notify_knowledge_rejected(knowledge)
    @knowledge       = knowledge
    @user        = knowledge.user

    mail(to: @user.email, subject: "您提交的内容#{knowledge.title}已经被驳回")
  end
end
