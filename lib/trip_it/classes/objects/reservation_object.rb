module TripIt
  class ReservationObject < BaseObject
    string_param :booking_rate, :booking_site_conf_num, :booking_site_name, :booking_site_url, :record_locator, :supplier_conf_num, :booking_site_name, \
                 :booking_site_phone, :booking_site_url, :record_locator, :supplier_conf_num, :supplier_contact, :supplier_email_address, \
                 :supplier_name, :supplier_phone, :supplier_url, :notes, :restrictions, :total_cost
                 
    datetime_param :cancellation_date_time
    
    date_param :booking_date
    
    boolean_param :is_purchased
    
    def populate(info)
      super(info)
      @booking_rate           = info["booking_rate"]
      @booking_site_conf_num  = info["booking_site_conf_num"]
      @booking_site_name      = info["booking_site_name"]
      @booking_site_phone     = info["booking_site_phone"]
      @booking_site_url       = info["booking_site_url"]
      @record_locator         = info["record_locator"]
      @supplier_conf_num      = info["supplier_conf_num"]
      @supplier_contact       = info["supplier_contact"]
      @supplier_email_address = info["supplier_email_address"]
      @supplier_name          = info["supplier_name"]
      @supplier_phone         = info["supplier_phone"]
      @supplier_url           = info["supplier_url"]
      @notes                  = info["notes"]
      @restrictions           = info["restrictions"]
      @total_cost             = info["total_cost"]
      @cancellation_date_time = convertDT(info["CancellationDateTime"])
      @booking_date           = info["booking_date"]
      @is_purchased           = Boolean(info["is_purchased"])
    end
    
    def sequence
      arr = super
      arr + ["@cancellation_date_time", "@booking_date", "@booking_rate", "@booking_site_conf_num", "@booking_site_name",
        "@booking_site_phone", "@booking_site_url", "@record_locator", "@supplier_conf_num", "@supplier_contact",
        "@supplier_email_address", "@supplier_name", "@supplier_phone", "@supplier_url", "@is_purchased", "@notes",
        "@restrictions", "@total_cost" ]
    end
  end
end