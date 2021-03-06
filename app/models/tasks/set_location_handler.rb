module Tasks::SetLocationHandler
  def do_set_location_task(task, params)
    batch = Batch.find params[:batch_id]
    location_id = params[:location_id][0].to_i
    if batch.pipeline.group_by_parent?
    groups= task.acts_on_input ? batch.input_group : batch.output_group
    groups.each do |group, requests|
      next unless group.size>0 and (asset_id = group.first) #wells which hasn't been cherry picked for example
      task.set_location(asset_id, location_id)
    end
    else
      raise RuntimeError, "Not implemented yet"
    end
  end
end