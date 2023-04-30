class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @contacts = Contact.all
    # @contact = Contact.find(params[:id])
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
