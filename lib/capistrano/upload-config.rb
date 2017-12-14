load File.expand_path('../tasks/upload-config.rake', __FILE__)

module CapistranoUploadConfig
  class Helpers
    class << self

      def get_local_config_name(config, stage)
        path = File.dirname(config)
        extension = File.extname(config)
        filename = File.basename(config, extension)
        extension.sub!(/^\./, '')
        local_file = [filename, stage].join('.')
        local_file = [local_file, extension].join('.') unless extension.empty?
        local_path = File.join(path, local_file)
      end

    end
  end
end
