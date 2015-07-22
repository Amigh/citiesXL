require 'test_helper'

class MedalsControllerTest < ActionController::TestCase
  setup do
    @medal = medals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medal" do
    assert_difference('Medal.count') do
      post :create, medal: { description: @medal.description, image: @medal.image, name: @medal.name, score: @medal.score }
    end

    assert_redirected_to medal_path(assigns(:medal))
  end

  test "should show medal" do
    get :show, id: @medal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medal
    assert_response :success
  end

  test "should update medal" do
    patch :update, id: @medal, medal: { description: @medal.description, image: @medal.image, name: @medal.name, score: @medal.score }
    assert_redirected_to medal_path(assigns(:medal))
  end

  test "should destroy medal" do
    assert_difference('Medal.count', -1) do
      delete :destroy, id: @medal
    end

    assert_redirected_to medals_path
  end
end
