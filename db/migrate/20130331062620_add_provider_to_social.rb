class AddProviderToSocial < ActiveRecord::Migration
  def change
    add_column :socials, :provider, :string
  end
end
