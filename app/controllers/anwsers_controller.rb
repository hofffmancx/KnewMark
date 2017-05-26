class AnwsersController < ApplicationController
	before_action :require_login
	before_action :find_knowledge_and_question
	before_action :find_anwser, :only => [:edit, :update, :destroy]

	def new
		@anwser= Anwser.new
	end

	def create
		@anwser = Anwser.new(anwser_params)
		@anwser.question = @question
		@anwser.user = current_user

		if @anwser.save
			redirect_to knowledge_question_path(@knowledge, @question)
		else
			render :new
		end
	end

	def edit		
	end

	def update
		if @anwser.update(anwser_params)
			redirect_to knowledge_question_path(@question)
		else
			render :edit
		end
	end

	def destroy
		@anwser.destroy
		redirect_to knowledge_question_path(@question)
	end

	private

	def find_knowledge_and_question
		@knowledge = Knowledge.find(params[:knowledge_id])
		@question = Question.find(params[:question_id])
	end

	def find_anwser
		@anwser = Anwser.find(params[:id])
	end

	def anwser_params
		params.require(:anwser).permit(:content)
	end
end
