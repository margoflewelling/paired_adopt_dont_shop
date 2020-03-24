class ShowpetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:id])
  end
end
