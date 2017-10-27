#!/usr/bin/env ruby

class Aeroplane
  attr_reader :airport

  def initialize(airport = nil)
    @airport = airport
  end

  def flying?
    !@airport
  end
end
