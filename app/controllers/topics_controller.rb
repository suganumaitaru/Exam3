class TopicsController < ApplicationController

    before_action :authenticate_user!

    before_action :set_topic, only: [:show, :edit, :update, :destroy]

    def index
        @topics = Topic.all
        respond_to do |format|
            format.html
            format.js
        end
    end




    # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
    def show
      @comment = @topic.comments.build
      @comments = @topic.comments
      Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    end

    def new
        if params[:back]
            @topic = Topic.new(topics_params)
        else
            @topic = Topic.new
        end
    end

    def create
        @topic = Topic.new(topics_params)
        @topic.user_id = current_user.id
        if @topic.save
            redirect_to topics_path, notice: "トピックを作成しました!"
            NoticeMailer.sendmail_topic(@topic).deliver
        else
           render 'new'
        end
    end

    def edit
    end

    def update
        @topic.update(topics_params)
        if @topic.save
            redirect_to topics_path
        else render 'edit'
        end
    end

    def destroy
        @topic.destroy
        redirect_to topics_path
    end

    def confirm
        @topic = Topic.new(topics_params)
        render :new if @topic.invalid?
    end

    private
        def topics_params
            params.require(:topic).permit(:title, :content)
        end

    def set_topic
        @topic = Topic.find(params[:id])
    end
end
