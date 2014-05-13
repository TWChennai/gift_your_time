class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.save!
    redirect_to event_path(comment.event)
  rescue
    render text: "Error creating comment"
  end

  def destroy
    comment = Comment.find(params[:id])
    event_id = comment.event_id
    if comment.user_id == current_user.id
      comment.destroy
      redirect_to event_path(event_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :event_id)
  end
end