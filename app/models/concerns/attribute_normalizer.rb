# frozen_string_literal: true

module AttributeNormalizer
  extend ActiveSupport::Concern

  module ClassMethods
    def normalize_attributes(*args, with: [:squish])
      mod = Module.new do
        args.each do |attribute|
          define_method "#{attribute}=" do |value|
            with.each do |m|
              if value.respond_to?(m)
                value = value.send(m)
              elsif Parser.respond_to?(m)
                value = Parser.send(m, value)
              end
            end
            super(value)
          end
        end
      end

      include mod
    end
  end
end
