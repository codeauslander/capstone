require 'wikipedia'
class InformationsController < ApplicationController
  def index
    search = params[:search] || 'Getting Things Done'
    @page = Wikipedia.find(search)
    p @page.title
    render 'index.json.jbuilder'
  end
end
