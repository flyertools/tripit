module TripIt
  class TripShare < Base
    integer_param :trip_id
    boolean_param :is_traveler, :is_read_only, :is_sent_with_details
  end
end