class GroupsController < ApplicationController
  before_filter :authenticate, :only => [:create, :new]

  def show
    @group = Group.find(params[:id])
    @weeks = @group.weeks

    @week = @weeks.find_by_week_number(1)

    @posts = @week.posts
    @title = "#{@group.name}"
  end

  def create
    @group = Group.new(params[:group])

    @topic_ids = params[:topics].nil? ? [] : params[:topics][:id]

    if @group.save
      flash[:success] = "Group #{@group.name} successfully created!"

      @topic_ids.each do |id|
        topic = Topic.find(id)
        @group.topic_add!(topic)
      end

      [1,2,3,4].each do |n|
        @group.weeks.create!( :week_number => n )
      end

      # make the creator an admin automatically
      affiliation = current_user.group_join!(@group)
      affiliation.toggle!(:admin)
      affiliation.save!
      
      redirect_to group_path(@group)

    else
      @title = "New group"
      @errors = @group.errors.full_messages
      render 'new'
    end

  end

  def new
    @title = "New group"
    @group = Group.new
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to root_path
  end

  def index
    @topics = Topic.all :order => "name ASC"
    @search_topics = params[:topics].nil? ? [] : params[:topics]
    logger.debug params[:topics]
    @groups = Group.search(params[:search], params[:topics] )
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  def edit
  end

  def update
  end

end
