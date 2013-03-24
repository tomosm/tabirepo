# encoding: utf-8

class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      redirect_to contact_new_path, notice: '送信しました'
    else
      render action: 'new'
    end
  end
end
