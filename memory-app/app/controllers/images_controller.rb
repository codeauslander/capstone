class ImagesController < ApplicationController
  
def index
  @images = Image.all 
  render json:@images.as_json
end
def create
  @image = Image.create(
      image_url:params[:image_url]
    )
  render json:@image.as_json
end
def show
  @image = Image.find(params[:id])
  render json:@image.as_json
end
def update
  @image = Image.find(params[:id])
  @image.image_url = params[:image_url] || @image.image_url
  @image.save
  render json:@image.as_json
end
def destroy
  @image = Image.find(params[:id])
  @image.destroy
  render json:{message:"Image ##{@image.id} succesfully destroyed."}
end
  
end
