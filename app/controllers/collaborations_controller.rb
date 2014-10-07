class CollaborationsController < ApplicationController
  
def index
  @collaborations = Collaboration.all
end

def new
  @collaboration = Collaboration.new
end

def create
  @collaboration = Collaboration.new(collaboration_params)
  if @collaboration.save
    redirect_to :collaborations
  end
end

private

def collaboration_params
  params.require(:collaboration).permit(:name)
end
  
end
