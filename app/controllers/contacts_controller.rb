class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    case params[:group]
    when "agents"
      @contacts = Contact.agent.order("name")
    when "clients"
      @contacts = Contact.client.order("name")
    when "lenders"
      @contacts = Contact.lender.order("name")
    when "vendors"
      @contacts = Contact.vendor.order("name")
    else
      @contacts = Contact.all.order("name")
    end
    @contacts = @contacts.where("LOWER(name) like ?", "%#{params[:search].downcase}%") if params[:search]
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    logger.debug "here"
    respond_to do |format|
      format.js
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @group = params[:group]
    respond_to do |format|
      if @contact.save
        @contact.create_activity key: 'contact.created', owner: current_user
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        @contact.create_activity key: 'contact.updated', owner: current_user, parameters: {changes: @contact.versions.last.changeset }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find_by(uid: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:contact_type, :transaction_type, :status, :name, :email, :phone, :company, :street, :city, :state, :postal_code, :service, :dot_loop_id, :notes)
    end
end
