class TagsController < ApplicationController
  # before_action :authenticate_user, only: [:index]

  def index
    @tags = Tag.all
    render 'index.json.jbuilder'
  end
  def create
    @tag = Tag.new(
        name:params[:name]
      )
    @tag.add_images(params[:image_ids]) if (params[:image_ids] && params[:image_ids] != "")
    @tag.save
    render 'show.json.jbuilder'
  end
  def show
    @tag = Tag.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @tag = Tag.find(params[:id])
    @tag.name = params[:name] || @tag.name
    @tag.add_images(params[:image_ids]) if params[:image_ids]
    @tag.save
    render 'show.json.jbuilder'
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    render json:{message:"Tag ##{@tag.id} succesfully destroy."}
  end
end
