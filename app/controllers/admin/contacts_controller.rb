class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @contact = Contact.find(params[:id])
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
