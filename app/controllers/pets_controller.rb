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
    # if !params["owner"]["name"].empty?
    #   @owner = Owner.create(name: params["owner"]["name"])
    #   @pet = Pet.create(name: params["pet"]["name"])
    #   @pet.owner_id = @owner.id
    #   @pet.save
    #   @pet
    # else
    #   @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"][0])
    # end
    # binding.pry
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @owner = Owner.find_by(name: params["pet"]["owner_id"])
      @pet.owner_id = @owner.id
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end