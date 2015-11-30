require 'test_helper'

class CreateCoursesControllerTest < ActionController::TestCase
  setup do
    @create_course = create_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_course" do
    assert_difference('CreateCourse.count') do
      post :create, create_course: {  }
    end

    assert_redirected_to create_course_path(assigns(:create_course))
  end

  test "should show create_course" do
    get :show, id: @create_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_course
    assert_response :success
  end

  test "should update create_course" do
    patch :update, id: @create_course, create_course: {  }
    assert_redirected_to create_course_path(assigns(:create_course))
  end

  test "should destroy create_course" do
    assert_difference('CreateCourse.count', -1) do
      delete :destroy, id: @create_course
    end

    assert_redirected_to create_courses_path
  end
end
