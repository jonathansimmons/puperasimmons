require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { city: @contact.city, company: @contact.company, email: @contact.email, loop_id: @contact.loop_id, name: @contact.name, phone: @contact.phone, postal_code: @contact.postal_code, service: @contact.service, state: @contact.state, status: @contact.status, street: @contact.street, transaction_type: @contact.transaction_type, type: @contact.type }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, contact: { city: @contact.city, company: @contact.company, email: @contact.email, loop_id: @contact.loop_id, name: @contact.name, phone: @contact.phone, postal_code: @contact.postal_code, service: @contact.service, state: @contact.state, status: @contact.status, street: @contact.street, transaction_type: @contact.transaction_type, type: @contact.type }
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
