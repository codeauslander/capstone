require 'wikipedia'
class InformationsController < ApplicationController


  def index
    # @media_wiki = Unirest.get("https://en.wikipedia.org/w/api.php?action=query&titles=Alzheimer's_disease&prop=revisions&rvprop=content&format=json&formatversion=2").body
    # render json: @media_wiki
    # # require 'wikipedia'
    page = Wikipedia.find( 'Getting Things Done' )
    p "*"*50
    p page
    p "*"*50
    
  end
end
