class QuestionsController < ApplicationController
	before_action :require_login, except: [:index, :show]
	before_action :find_knowledge
	before_action :find_question, :except => [:index, :new, :create]

	def index
    @questions = @knowledge.questions.includes(:user)
  end

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params)
		@question.user = current_user
		@question.knowledge = @knowledge

		if @question.save
			@question.create_activity :create, owner: current_user,:params => {:knowledge_id => @question.knowledge.friendly_id}
			Notification.create(notify_type: 'create_question', target: @question, second_target: @question.knowledge, actor: current_user, user: @question.knowledge.user)

			redirect_to knowledge_path(@knowledge), notice: "问题已发布。"
		else
			render :new
		end
	end

	def edit
	end

	def show
		@anwser = Anwser.new
	end

	def update
		if @question.update(question_params)
			@question.user = current_user
			@question.create_activity :update, owner: current_user,:params => {:knowledge_id => @question.knowledge.friendly_id}

			# @question.update_event!
			redirect_to knowledge_path(@knowledge), notice: "问题已更新。"
		else
			render :edit
		end
	end

	def destroy
		@question.destroy
		@question.create_activity :destroy, owner: current_user,:params => {:knowledge_id => @question.knowledge.friendly_id}

		redirect_to knowledge_path(@knowledge), alert: "问题已删除"
	end

	private

	def question_params
		params.require(:question).permit(:title, :description)
	end

	def find_knowledge
		@knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
	end

	def find_question
		@question = Question.find_by_friendly_id!(params[:id])
	end
end
