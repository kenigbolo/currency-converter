require 'rails_helper'
require 'spec_helper'
require "selenium-webdriver"

describe 'home/index.html.erb' do
  before do
    controller.singleton_class.class_eval do
      protected
        def user_signed_in?
          true
        end
        def current_user
          FactoryGirl.build(:user)
        end
        helper_method :user_signed_in?
        helper_method :current_user
    end
  end

  it 'checks for proper content' do
    render
    expect(response.body).to match /Meya Currency Predictor/m
  end
end
