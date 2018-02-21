class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json:@tags.as_json
  end
  def create
    @tag = Tag.create(
        name:params[:name]
      )
    render json:@tag.as_json
  end
  def show
    @tag = Tag.find(params[:id])
    render json:@tag.as_json
  end
  def update
    @tag = Tag.find(params[:id])
    @tag.name = params[:name] || @tag.name
    @tag.save
    render json:@tag.as_json
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    render json:{message:"Tag ##{@tag.id} succesfully destroy."}
  end
end
