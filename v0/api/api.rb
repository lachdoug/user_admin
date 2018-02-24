class V0
  module Api

    module Models; end
    module Helpers; end

    Dir.glob( [ "./v0/api/models/**/*.rb" ] ).each { |file| require file }
    Dir.glob( [ "./v0/api/helpers/**/*.rb" ] ).each { |file| require file }

    module Controllers

      extend Sinatra::Extension

      # Get the module constant from a controller file
      # by infering constant name from filename
      # @return [Constant]
      def self.controller_const_for_file( file )
        const_get(
          file.sub( './v0/api/controllers/', '' ).
          sub( '.rb', '' ).
          split('/').map { |const|
            const.split('_').collect(&:capitalize).join
          }.join('::')
        )
      end

      Dir.glob( [ "./v0/api/controllers/**/*.rb" ] ).each do |file|
        require file
        register controller_const_for_file( file )
      end
      include Models

    end
  end
end
