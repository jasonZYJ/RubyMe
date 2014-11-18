class ChangeDelayedJobsHandler < ActiveRecord::Migration
  def up
    if postgresql?
      change_column :delayed_jobs, :handler, :text, :limit => 2**24 - 1
    end
  end

  def down
    if postgresql?
      change_column :delayed_jobs, :handler, :text, :limit => 2**16 - 1
    end
  end

  def postgresql?
    ActiveRecord::Base.connection.adapter_name =~ /postgresql/i
  end
end
