# encoding: utf-8

class ContactController < ApplicationController
  before_filter :check_admin_user, :except => [:new, :create]

  def index
    @contacts = Contact.page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      Message.contact(@contact).deliver
      redirect_to contact_new_path, notice: '送信しました'
    else
      render action: 'new'
    end
  end
end
