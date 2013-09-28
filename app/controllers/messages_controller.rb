class MessagesController < ApplicationController
  include ActionView::Helpers::DateHelper
  def create
    @task = Task.find(params[:task_id])
    @message = @task.messages.build(params[:message])
    @message.save!

    PrivatePub.publish_to(
        chat_task_path(@task),
        sender: @message.sender.name,
        message: @message.content,
        time_ago: distance_of_time_in_words_to_now(@message.created_at)
    )
    render json: {success: true}
  end
end