module TripIt
  class Base
    extend TripIt::ParamUtil

    def chkAndPopulate(iVar, objType, prop)
      return if prop.nil?
      if prop.is_a?(Array)
        prop.each do |value|
          iVar << objType.new(value)
        end
      else
        iVar << objType.new(prop)
      end
    end
    
    def chkObjAndPopulate(client, iVar, objType, prop)
      return if prop.nil?
      if prop.is_a?(Array)
        prop.each do |value|
          iVar << objType.new(client, value["id"], value)
        end
      else
        iVar << objType.new(client, prop["id"], prop)
      end
    end
    
    # Convert a TripIt DateTime Object to a Ruby DateTime Object
    def convertDT(tpitDT)
      return nil if tpitDT.nil?
      date = tpitDT["date"]
      time = tpitDT["time"]
      offset = tpitDT["utc_offset"]
      if time.nil?
        # Just return a date
        Date.parse(tpitDT["date"])
      else
        DateTime.parse(tpitDT["date"] + "T" + tpitDT["time"] + tpitDT["utc_offset"])
      end
    end

    def to_json
      { self.class.name.split("::").last => self.to_hash.to_json }
    end
    
    def to_hash
      hash = {}
      self.instance_variables.each do |key|
        next if key == "@client"
        value = self.instance_variable_get(key)
        if value.is_a?(Array)
          # We have an array of objects. First get the type of class
          objectType = value.first.class.name.split("::").last
          # Now get all of the objects' to_hash values
          hashArr = value.map {|mem| mem.to_hash}
          hash[camelize(key[1..-1]).to_sym] = { objectType => hashArr }
        elsif value.class.name.split("::").first == "TripIt"
          # If it's a single one of our objects, call its to_hash method
          hash[camelize(key[1..-1]).to_sym] = value.to_hash
        else
          hash[key[1..-1].to_sym] = value
        end
      end
      hash      
    end
    
    def Boolean(string)
      return true if string == true || string =~ /^true$/i
      return false if string == false || string.nil? || string =~ /^false$/i
      raise ArgumentError.new("Invalid value for Boolean: \"#{string}\"")
    end
  end  
end