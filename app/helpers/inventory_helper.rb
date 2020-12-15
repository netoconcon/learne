module InventoryHelper
  def inventory_info(version)
    if version.event == "create"
      "Produto criado por #{User.find_by(id: version.whodunnit).email} as #{version.created_at.strftime("%H:%M - %d/%m/%Y")}."
    elsif version.event == "update"
      if version.previous.object.nil?
        "Produto atualizado por #{User.find_by(id: version.whodunnit).email}. Para #{version.object.scan(/quantity: (.+)\n/).first.first if version.object} unidades. Modificado as #{version.object.scan(/updated_at: (.+) Z/).first.first.to_datetime.strftime("%H:%M - %d/%m/%Y")}."
      else
        "Produto atualizado por #{User.find_by(id: version.whodunnit).email}. De unidades #{version.previous.object.scan(/quantity: (.+)\n/).first.first if version.previous && version.previous.object } para #{version.object.scan(/quantity: (.+)\n/).first.first if version.object} unidades. Modificado as #{version.object.scan(/updated_at: (.+) Z/).first.first.to_datetime.strftime("%H:%M - %d/%m/%Y")}. #{ "Obs: #{version.object.scan(/observation: (.+)\n/).first.first}" unless version.object.scan(/observation: (.+)\n/).first.nil? }"
      end
    end
  end

  def originator(current_state)
    "Ultima atualizacao por #{User.find_by(id: current_state.paper_trail.originator).email}. De #{current_state.versions.last.object.scan(/quantity: (.+)\n/).first.first if current_state.versions.last.object} unidades para #{current_state.quantity} unidades. Modificado as #{current_state.updated_at.strftime("%H:%M - %d/%m/%Y")}"

  end
end