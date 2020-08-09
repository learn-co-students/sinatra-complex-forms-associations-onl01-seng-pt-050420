class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:pet].nil?
      @owner = Owner.find_by(id: params[:pet][:owner_id])
      @pet = Pet.create(name: params[:pet_name], owner: @owner)
    else
      @pet = Pet.create(name: params[:pet_name])
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
   
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######
 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    else
      @owner = Owner.find_by(id: params[:pet][:owner_id])
      @pet.update(owner: @owner)
    end
    redirect "pets/#{@pet.id}"
  end
end