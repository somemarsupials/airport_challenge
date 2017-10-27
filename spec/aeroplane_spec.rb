#!/usr/bin/env ruby

require 'aeroplane'

describe Aeroplane do
  describe "creates with" do
    context "airport" do
      it { is_expected.to respond_to :airport }

      it "is nil by default" do
        expect(subject.airport).to be_nil
      end

      it "is object when passed" do
        subject = described_class.new(:airport)
        expect(subject.airport).to eq :airport
      end
    end
  end
end
