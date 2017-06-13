class AddEventsForExistedActions < ActiveRecord::Migration[5.0]
  def change
    Review.all.each do |r|
      EventService.new(r.knowledge, r, r.user, "发表了评测", r.knowledge).generate_event
    end
    Discussion.all.each do |d|
      EventService.new(d.knowledge, d, d.user, "发起了讨论", d.knowledge).generate_event
    end
    Question.all.each do |q|
      EventService.new(q.knowledge, q, q.user, "提出了问题", q.knowledge).generate_event
    end

    User.all.each do |u|
      u.like_knowledge_ids do |id|
        @knowledge = Knowledge.find(id)
        EventService.new(@knowledge, @knowledge, u, "喜欢了知识", @knowledge).generate_event
      end
      u.want_knowledge_ids do |id|
        @knowledge = Knowledge.find(id)
        EventService.new(@knowledge, @knowledge, u, "想学知识", @knowledge).generate_event
      end
      u.have_knowledge_ids do |id|
        @knowledge = Knowledge.find(id)
        EventService.new(@knowledge, @knowledge, u, "学过知识", @knowledge).generate_event
      end
      u.follow_knowledge_ids do |id|
        @knowledge = Knowledge.find(id)
        EventService.new(@knowledge, @knowledge, u, "关注了知识", @knowledge).generate_event
      end
    end

  end
end
