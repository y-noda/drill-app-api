class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    hash = JSON.parse(params[:answer])
    key = hash["answer"]["session"]["userid"]
    
    @answer = Answer.find_or_initialize_by(key: key)

    if @answer.new_record?
      if @answer = Answer.create(key: key, answer: hash)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    else
      if @answer.update(key: key, answer: hash)
        render status: 200, json: { id: key }
      else
        render status: 400, json: { id: '失敗' }
      end
    end
  end

  def show 
    @answer = Answer.find_by(key: params[:id])
    if @answer 
      render status: 200, json: { answer: @answer.answer }
    else
      render status: 400, json: { answer: '失敗' }
    end
  end
end
