require 'rspec'
require_relative '../checked_attributes'

describe 'CheckedAttributes' do

  describe '#attr_checked' do

    context 'with a single attribute' do
      context 'with a restriction of older than 18' do
        context 'with 8 years' do
          it 'raises a RuntimeError' do
            class Person
              include CheckedAttributes
            end
            @bob = Person.new
            @bob.attr_checked(Person, :age) do |value|
              value >= 18
            end
            expect{@bob.age = 8}.to raise_error(RuntimeError, "Invalid value")
          end
        end
        context 'with 20 years' do
          it 'accepts the value' do
            class Person
              include CheckedAttributes
            end
            @bob = Person.new
            @bob.attr_checked(Person, :age) do |value|
              value >= 18
            end
            @bob.age = 20
            expect(@bob.age).to eq 20
          end
        end
      end

    end

    context 'with multiple attributes' do
      it 'accepts the values' do
        class Person
          include CheckedAttributes
        end
        @bob = Person.new
        @bob.attr_checked(Person, :age, :gender) do |value|
          !value.nil?
        end
        @bob.age = 20
        @bob.gender = "male"
        expect(@bob.age).to eq 20
        expect(@bob.gender).to eq "male"
      end
      it 'enforces the block condition' do
        class Person
          include CheckedAttributes
        end
        @bob = Person.new
        @bob.attr_checked(Person, :age, :gender) do |value|
          !value.nil?
        end
        @bob.age = 20
        expect{@bob.gender = nil}.to raise_error(RuntimeError, "Invalid value")
      end
    end
  end

end

