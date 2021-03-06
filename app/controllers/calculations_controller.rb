# frozen_string_literal: true
# rubocop:disable MethodLength, Style/GuardClause, Metrics/AbcSize
# ! Calculation controller methods
class CalculationsController < ApplicationController
  PER_PAGE = 5

  before_action :authenticate_user!, except: :index

  def index
    @calculation = Calculation.all.page(params[:page]).per(PER_PAGE)
  end

  def create
    base = params[:calculation][:base_currency]
    conversion = params[:calculation][:conversion_currency]

    if base == conversion
      flash['notice'] = "You cannot convert from #{base} to #{conversion}"
      redirect_back(fallback_location: root_path)
    else
      calculation = save_calculation(calculation_params)
      create_calculation(calculation)
    end
  end

  def edit
    @calculation = Calculation.find_by(id: params[:id])
    unless @calculation.user == current_user
      flash['notice'] = 'Unauthorized access'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @calculation = current_user.calculations.find_by(id: params[:id])
    if @calculation.update(calculation_params)
      flash[:notice] = 'Currrency prediction request successfully updated.'
      helpers.get_result(@calculation)
      redirect_to @calculation
    else
      render 'edit'
    end
  end

  def show
    @calculation = Calculation.find_by(id: params[:id])
    @result = Result.find_by(calculation_id: @calculation.id)
    return @top_three = @result.top_three! unless Rails.env.test?
  end

  def destroy
    calculation = Calculation.find(params[:id])
    owns = current_user.id == calculation.user_id
    if calculation.user_id.present? && owns
      success = false
      begin
        success = calculation.remove_calculation!
      rescue
        success = false
      end
      check_success(success)
    else
      flash['error'] = 'You do not have the permission to delete this item'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def calculation_params
    params
      .require(:calculation)
      .permit(:base_currency, :conversion_currency, :amount, :num_of_days)
  end

  def save_calculation(calculation_params)
    calculation = Calculation.new(calculation_params)
    calculation.user_id = current_user.id
    calculation.save_calc!
  end

  def create_calculation(calculation)
    if calculation != false
      helpers.get_result(calculation)
      redirect_to calculation_url(calculation)
    else
      flash['notice'] = 'Something went wrong'
      redirect_back(fallback_location: root_path)
    end
  end

  def check_success(success)
    if success
      flash['notice'] = 'Calculation Prediction successfully deleted'
    else
      flash['error'] = 'Sorry, we encountered an error while deleting'
    end
  end
end
