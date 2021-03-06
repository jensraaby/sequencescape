# This is effectively pooling: all wells that have come from the same submission will be transferred
# into the same well on the destination plate.
class Transfer::BetweenPlatesBySubmission < Transfer
  extend ::ModelExtensions::Plate::NamedScopeHelpers
  include_plate_named_scope :source
  include_plate_named_scope :destination

  include TransfersToKnownDestination
  include ControlledDestinations

  #--
  # Track back from the specified well to the stock plate well that has been transfered here.  Then
  # find the non-transfer request where the stock well was the source asset, and from there the submission
  # that it came from.  Hence all stock wells that are part of the same submission will be transferred to
  # the same well.
  #++
  def well_to_destination
    {}.tap do |sources_to_target|
      # Group the wells based on the submission their non-transfer request belongs to
      wells_to_stocks = locate_stock_wells_for(source)
      groups = source.wells.with_pool_id.group_by do |well|
        stock_well = wells_to_stocks[well].first
        stock_well and stock_well.requests_as_source.where_has_a_submission.first.try(:submission_id)
      end.delete_if { |k,_| k.nil? }.values

      # Submission group 1 will go into A1, group 2 into B1, group 3 C1, etc.
      Map.walk_plate_in_column_major_order(source.size) do |position, index|
        next unless index < groups.size
        destination_well = destination.wells.located_at(position.description).first or
          raise StandardError, "The destination does not have a well at #{position.description}"
        groups[index].each { |source| sources_to_target[source] = destination_well }
      end
    end
  end
  private :well_to_destination

  def record_transfer(source, destination)
    self.transfers ||= {}
    self.transfers[source.map.description] = destination.map.description
  end
  private :record_transfer
end
