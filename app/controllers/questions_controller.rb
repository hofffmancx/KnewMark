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
			# @question.update_event!
			redirect_to knowledge_path(@knowledge), notice: "问题已更新。"
		else
			render :edit
		end
	end

	def destroy
		@question.destroy
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
