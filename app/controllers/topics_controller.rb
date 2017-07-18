class TopicsController < ApplicationController
    before_action :set_topic, only: [:edit, :update, :destroy]

    def index
        @topics = Topic.all
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
        # Topic.create(topics_params)
        if @topic.save
            redirect_to topics_path, notice: "トピックを作成しました!"
        else render 'new'
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
