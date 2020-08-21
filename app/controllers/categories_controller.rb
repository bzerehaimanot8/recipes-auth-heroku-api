class CategoriesController < ApplicationController

  def index
    @category_list = Category.all
    #lets check if we dont have an empty table
    if @category_list.empty?
      render json: {
          'error':'there is no data to show'
      }
    else
      render :json => {
          :response => 'successful',
          :data => @category_list
      }
    end

  end

  def create
    # here we are creating an new single to do object
    @one_category = Category.new(category_params)
    #if we can save the to do object
    if @one_category.save
      #then show it to the user
      render :json => {
          :response => 'successfully created category list',
          :data => @one_category
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
    @single_category = Category.exists?(params[:id])
    # puts @single_todo
    # if yes, let's display the data
    if @single_category
      render :json => {
          :response => 'successful',
          :data => Category.find(params[:id])
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
    if(@single_category_update = Category.find_by_id(params[:id])).present?
      #we are passing the todo_params which means title, and created by
      @single_category_update.update(category_params)
      render :json => {
          :response => 'successfully updated the data',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'cannot update the selected record'
      }

    end
  end

  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?


      @category_delete.destroy
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
  def category_params
    params.permit(:title, :description, :created_by)
  end



end
