class ChangeFieldsOnBookmarks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :bookmarks, :cookbook, index: true, foreign_key: true
    add_reference :bookmarks, :user, index: true, foreign_key: true
  end
end
