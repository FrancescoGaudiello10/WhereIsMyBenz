require 'rails_helper'
require 'omniauth'
require 'omniauth-facebook'

RSpec.describe StaticPagesController, type: :controller do
  it 'should get home' do
    get :home
    assert_response :success
  end
end
