require 'date'

module TripIt
  module ParamUtil
    def string_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(String)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a String"
          end
        end
      end
    end
  
    def integer_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Integer)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be an Integer"
          end
        end
      end
    end
    
    def float_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Float)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a Float"
          end
        end
      end      
    end
  
    def boolean_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(TrueClass) || val.is_a?(FalseClass)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a Boolean"
          end
        end
      
        define_method "#{name}?" do
          !!instance_variable_get("@#{name}")
        end
      end
    end
    
    def boolean_read_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}?" do
          !!instance_variable_get("@#{name}")
        end
      end
    end
  
    def array_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Array)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be an Array"
          end
        end
      end
    end  
  
    def datetime_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(DateTime)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a DateTime"
          end
        end
      end
    end  
  
    def date_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Date)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a Date"
          end
        end
      end
    end
    
    def time_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Time)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a Time"
          end
        end
      end      
    end
    
    def airportcode_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.match("[A-Z][A-Z][A-Z]").nil?
            raise ArgumentError, "#{name} must be a valid airport code"
          else
            instance_variable_set("@#{name}",val)
          end
        end
      end      
    end
    
    def address_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Address)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be an Address"
          end
        end
      end      
    end
    
    def traveler_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Traveler)
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be a Traveler"
          end
        end
      end      
    end
    
    def traveler_array_param(*names)
      names.each do |name|
        define_method "#{name}" do
          instance_variable_get("@#{name}")
        end
      
        define_method "#{name}=" do |val|
          if val.is_a?(Array) && val.all? { |e| Traveler === e }
            instance_variable_set("@#{name}",val)
          else
            raise ArgumentError, "#{name} must be an Array of Travelers"
          end
        end
      end      
    end
    
    def exceptions(*names)
      names.each do |n|
        # Clean up the name
        n = camelize(n.to_s)

        class_eval %{
          # Define a common Error class if it's
          # not yet defined
          unless const_defined?("Error")
            const_set("Error", Class.new(StandardError) )
          end

          # Define the exception class
          class #{n} < Error; end
        }
      end
    end
    
    def camelize(word)
      word.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
    end
  end 
end