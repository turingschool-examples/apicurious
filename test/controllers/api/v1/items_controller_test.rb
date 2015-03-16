require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json

    items      = JSON.parse(response.body)
    first_item = items.first

    assert_response :success
    assert_equal 'Cat',            first_item['name']
    assert_equal 'This is a cat.', first_item['description']
  end

  test '#show' do
    get :show, format: :json, id: '1'

    item = JSON.parse(response.body)

    assert_response :success
    assert_equal 'Cat',            item['name']
    assert_equal 'This is a cat.', item['description']
  end

  test '#create' do
    assert_difference('Item.count', 1) do
      post :create, format: :json, item: { name: 'Cow', description: 'This is a cow.' }
    end

    item = JSON.parse(response.body)

    assert_response :success
    assert_equal 'Cow',            item['name']
    assert_equal 'This is a cow.', item['description']
  end

  test '#update' do
    put :update, format: :json, id: '1', item: { name: 'Cow', description: 'This is a cow.' }

    item = Item.find(1)

    assert_response :success
    assert_equal 'Cow',            item.name
    assert_equal 'This is a cow.', item.description
  end

  test '#destroy' do
    assert_difference('Item.count', -1) do
      delete :destroy, format: :json, id: '1'
    end

    assert_response :success
  end
end
