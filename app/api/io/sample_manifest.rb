class ::Io::SampleManifest < ::Core::Io::Base
  # This module adds the behaviour we require from the SampleManifest module.
  module ApiIoSupport
    def self.included(base)
      base.class_eval do
        named_scope :include_samples, { :include => :samples }
      end
    end

    def io_samples
      core_behaviour.io_samples.map(&:as_json)
    end
  end

  class SampleMapper
    def initialize(sample, container)
      @sample, @container = sample, container
    end

    def as_json(options = nil)
      {
        :container        => @container,
        :sanger_sample_id => @sample.sanger_sample_id
      }
    end
  end

  set_model_for_input(::SampleManifest)
  set_json_root(:sample_manifest)
  set_eager_loading { |model| model.include_samples }
  
  define_attribute_and_json_mapping(%Q{
       last_errors  => last_errors
             state  => state
          supplier <=  supplier
             count <=  count

        io_samples <=> samples
  })
end