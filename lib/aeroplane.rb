#!/usr/bin/env ruby

require './lib/air_exceptions'

# Represents any aircraft. Starts flying or parked at an airport.
# Knows if flying or not. Can land at airports and take-off from
# them, in both cases working with the airport in question.
class Aeroplane
  attr_reader :airport, :name

  # Looks for optional name and airport - both default to nil. Docks
  # if an airport is passed - using symbol :at, for readability.
  def initialize(options = {})
    @name = options[:name]
    process_airport(options[:at])
  end

  # Is flying if airport is nil and vice versa. Returns boolean.
  def flying?
    !@airport
  end

  # Raise error if landed. Register landing with +airport+ then set
  # @airport to the destination airport.
  def land(airport)
    raise AeroplaneError, "already landed" unless flying?
    airport.process_landing(self)
    do_arrival(airport)
  end

  # Raise error if flying. Register take-off with @airport then
  # set @airport to nil.
  def take_off
    raise AeroplaneError, "already flying" if flying?
    @airport.process_take_off(self)
    do_take_off
  end

  # String containing class name, name attribute if given and
  # location, which is the airport or airborne.
  def to_s
    location = flying? ? "airborne" : "at #{@airport}"
    unless @name.nil?
      "Aeroplane '#{@name}', #{location}"
    else
      "Aeroplane, #{location}"
    end
  end

  private

  # Set airport to given value.
  def do_arrival(airport)
    @airport = airport
  end

  # Set airport to nil.
  def do_take_off
    @airport = nil
  end

  # Dock at airport if not nil and set airport attribute.
  def process_airport(airport)
    dock(airport) unless airport.nil?
    @airport = airport
  end

  # Register docking with +airport+ and set @airport to the 
  # destination airport.
  def dock(airport)
    airport.process_docking(self)
    do_arrival(airport)
  end
end
