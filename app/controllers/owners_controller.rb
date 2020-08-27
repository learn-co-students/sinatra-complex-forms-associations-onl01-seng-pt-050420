class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all     
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(params[:owner]) #pet belongs_to :owner
    if !params["pet"]["name"].empty? # validation for empty input in the form
      @owner.pets << Pet.create(name: params["pet"]["name"]) #if validation pass. add the newly created pet/name
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
      end
      #######
   
      @owner = Owner.find(params[:id])
      @owner.update(params["owner"])
      if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      redirect "owners/#{@owner.id}"
   
  end
end