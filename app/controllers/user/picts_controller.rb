class User::PictsController < ApplicationController
  def new
  end

  def show
    current_user.read_counts.create(pict_id: @pi.id)
  end

  def index
  end

  def edit
  end
end
