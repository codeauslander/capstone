class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render 'index.json.jbuilder'
  end
  def create
    @tag = Tag.create(
        name:params[:name]
      )
    render 'show.json.jbuilder'
  end
  def show
    @tag = Tag.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @tag = Tag.find(params[:id])
    @tag.name = params[:name] || @tag.name
    @tag.save
    render 'show.json.jbuilder'
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    render json:{message:"Tag ##{@tag.id} succesfully destroy."}
  end
end
