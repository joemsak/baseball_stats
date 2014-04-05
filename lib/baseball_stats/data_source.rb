module BaseballStats
  class DataSource
    class << self
      attr_accessor :raw_data, :name_key

      def set_raw_data(filepath)
        raw_data = read_clean_data(filepath)
      end

      def set_name_key(filepath)
        name_key = read_clean_data(filepath)
      end

      private
      def read_clean_data(filepath)
        data_source = File.open(filepath, 'r').read
        clean_data_source(data_source)
      end

      def clean_data_source(data)
        data.gsub("\r", "\n").gsub("\n\n", "\n").gsub(',,', ',0,')
      end
    end
  end
end
