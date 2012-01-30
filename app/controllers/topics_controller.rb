class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    @title = "Topic: #{@topic.name}"
  end
end
