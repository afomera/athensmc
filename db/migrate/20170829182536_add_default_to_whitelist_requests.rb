class AddDefaultToWhitelistRequests < ActiveRecord::Migration[5.1]
  def change
    change_column :whitelist_requests, :status, :string, default: "pending"
  end
end
