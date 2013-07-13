class AddPreReaderIdToReaders < ActiveRecord::Migration
  def change
    add_column :readers, :pre_reader_id, :integer
  end
end
