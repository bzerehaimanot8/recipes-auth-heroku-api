class RecipesController < ApplicationController

  def index
    @recipe_list = Recipe.all
    #lets check if we dont have an empty table
    if @recipe_list.empty?
      render json: {
          'error':'there is no data to show'
      }
    else
      render :json => {
          :response => 'successful',
          :data => @recipe_list
      }
    end

  end

  def create
    # here we are creating an new single recipe object
    @one_recipe = Recipe.new(recipe_params)
    #if we can save the to do object
    if @one_recipe.save
      #then show it to the user
      render :json => {
          :response => 'successfully created recipe list',
          :data => @one_recipe
      }
    else
      #if not show an error message
      render :json => {
          :error => 'cannot save the data'
      }
    end

  end

  def show
    # we try find the record is exist in our table
    # and this will return boolean
    @single_recipe = Recipe.exists?(params[:id])
    # puts @single_recipe
    # if yes, let's display the data
    if @single_recipe
      render :json => {
          :response => 'successful',
          :data => Recipe.find(params[:id])
      }
    else
      # let's handle the error
      render :json => {
          :response => 'record not found',
      }
    end
  end

  def update
    # check if the id is present in our table
    if(@single_recipe_update = Recipe.find_by_id(params[:id])).present?
      #we are passing the todo_params which means title, and created by
      @single_recipe_update.update(recipe_params)
      render :json => {
          :response => 'successfully updated the data',
          :data => @single_recipe_update
      }
    else
      render :json => {
          :response => 'cannot update the selected record'
      }

    end
  end

  def destroy
    if (@recipe_delete = Recipe.find_by_id(params[:id])).present?


      @recipe_delete.destroy
      render :json => {
          :response => 'successfully deleted the data'
      }
    else
      render :json => {
          :response => 'cannot delete the selected record'
      }
    end
  end

  private
  def recipe_params
    params.permit(:name, :ingredients, :directions, :notes, :tags, :category_id)
  end



end
