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

    # Convert object to (crude) XML for create (API does not seem to accept JSON)
    def to_xml
      self.class.name == "TripIt::TpDateTime" ? xmlstr = "<DateTime>" : xmlstr = "<#{self.class.name.split("::").last}>"
      self.respond_to?("sequence") ? arr = self.sequence : arr = self.instance_variables
      arr.each do |key|
        next if key == "@client" # Skip the OAuth client
        value = self.instance_variable_get(key)
        next if value.nil?
        if value.is_a?(Array)
          next if value.empty?
          # We have an array of objects. First get the type of class
          objectType = value.first.class.name.split("::").last
          # Now get all of the objects' to_xml values    
          xmlArr = value.map { |mem| mem.to_xml }
          xmlstr << "<#{camelize(key[1..-1])}>#{xmlArr}</#{camelize(key[1..-1])}>"
        elsif value.class.name.split("::").first == "TripIt"
          # If it's a single one of our objects, call its to_xml method
          xmlstr << value.to_xml
        elsif key=~/date_/
          xmlstr << TripIt::TpDateTime.new(value).to_xml
        else
          xmlstr << "<#{key[1..-1]}>#{value}</#{key[1..-1]}>"
        end
      end
      self.class.name == "TripIt::TpDateTime" ? xmlstr << "</DateTime>" : xmlstr << "</#{self.class.name.split("::").last}>"
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
        elsif key=~/date_/
          hash[camelize(key[1..-1]).to_sym] = TripIt::TpDateTime.new(value).to_hash
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
    
    def camelize(word)
      word.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
    end
  end  
end