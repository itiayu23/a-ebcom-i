class User::NovelsController < ApplicationController
  def new
    @novel_new = Novel.new
  end
  
  def create
    @novel_new = Novel.new(novel_params)
    @novel_new.user_id = current_user.id
    if @novel_new.save
      
  end

  def show
  end

  def index
  end

  def edit
  end
end
