class CommentsController < ApplicationController
    # コメントを保存、投稿するためのアクションです。
    def create
        # topicをパラメータの値から探し出し,topicに紐づくcommentsとしてbuildします。
        @comment = current_user.comments.build(comment_params)
        @topic = @comment.topic
        # クライアント要求に応じてフォーマットを変更
        respond_to do |format|
            if @comment.save
                format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
                format.js { render :index }
            else
                format.html { render :new }
            end
        end
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to topic_path(@comment.topic.id), notice: 'コメントが修正されました'
        else
            render 'edit'
        end
    end


    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました。' }
            format.js { render :index }
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    private
    # ストロングパラメーター
    def comment_params
        params.require(:comment).permit(:topic_id, :content)
    end
end
