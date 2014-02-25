load File.expand_path('../upload-config/tasks.rake', __FILE__)

module CapistranoUploadConfig
  class Helpers
    class << self

      def get_local_config_name(config, stage)
        path = File.dirname(config)
        extension = File.extname(config)
        filename = File.basename(config, extension)
        extension.sub!(/^\./, '')
        local_file = [filename, stage, extension].join('.')
        local_path = File.join(path, local_file)
      end

    end
  end
end
