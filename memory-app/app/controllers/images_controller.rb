class ImagesController < ApplicationController
  
def index
  @images = Image.all 
  render 'index.json.jbuilder'
end
def create
  @image = Image.create(
      image_url:params[:image_url]
    )
  render 'show.json.jbuilder'
end
def show
  @image = Image.find(params[:id])
  render 'show.json.jbuilder'
end
def update
  @image = Image.find(params[:id])
  @image.image_url = params[:image_url] || @image.image_url
  @image.name = params[:name] || @image.name
  @image.save
  render 'show.json.jbuilder'
end
def destroy
  @image = Image.find(params[:id])
  @image.destroy
  render json:{message:"Image ##{@image.id} succesfully destroyed."}
end
  
end
