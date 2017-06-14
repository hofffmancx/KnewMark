class AnwsersController < ApplicationController
	before_action :require_login
	before_action :find_question
	before_action :find_anwser, :only => [:edit, :update, :destroy]

	def new
		@anwser= Anwser.new
	end

	def create
		@anwser = Anwser.new(anwser_params)
		@anwser.question = @question
		@anwser.user = current_user
		@anwser.save
	end

	def edit
	end

	def update
		if @anwser.update(anwser_params)
			@anwser_user = current_user
			# @anwser.update_event!
			redirect_to knowledge_question_path(@question)
		else
			render :edit
		end
	end

	def destroy
		@anwser.destroy
		@anwser_user = current_user
		redirect_to knowledge_question_path(@question)
	end

	private

	def find_question
		@question = Question.find_by_friendly_id!(params[:question_id])
	end

	def find_anwser
		@anwser = Anwser.find_by_friendly_id!(params[:id])
	end

	def anwser_params
		params.require(:anwser).permit(:content)
	end
end
