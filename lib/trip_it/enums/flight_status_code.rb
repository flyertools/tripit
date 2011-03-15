module TripIt
  FLIGHT_STATUS_CODE = {
    100 => "Not Monitorable",
    200 => "Not Monitored",
    300 => "Scheduled",
    301 => "On Time",
    302 => "In Flight - On Time",
    303 => "Arrived - On Time",
    400 => "Cancelled",
    401 => "Delayed",
    402 => "In Flight - Late",
    403 => "Arrived - Late",
    404 => "Diverted"
  }
end