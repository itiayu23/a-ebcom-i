class User::HomesController < ApplicationController
  def top
     @q_pict = PictTag.ransack(params[:q])
     if params[:latest]
      @picts = Pict.where(privacy: "1").latest.page(params[:page])
     elsif params[:old]
      @picts = Pict.old.where(privacy: "1").page(params[:page])
     else
      @picts = Pict.where(privacy: "1").page(params[:page])
     end
     
      @q = Tag.ransack(params[:q])
      if params[:latest]
      @novels = Novel.latest.where(privacy: "1").page(params[:page])
      elsif params[:old]
      @novels = Novel.old.where(privacy: "1").page(params[:page])
      else
      @novels = Novel.where(privacy: "1").page(params[:page])
      end
     
  end

  def about
  end

  def warning
  end

end
