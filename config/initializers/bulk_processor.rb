module Paperclip

  class Bulk < Processor

    def make
      current_format = File.extname(@file.path)
      basename = File.basename(@file.path, current_format)
      format = options[:format]

      dst = Tempfile.new([basename, format ? ".#{format}" : ''])
      dst.binmode

      queue = @attachment.instance_variable_get(:@paperclip_bulk_processor_queue) || {}
      queue[@file.path] ||= []
      queue[@file.path] << {
          destination: dst,
          destination_path: dst.path,
          file: @file,
          file_path: @file.path,
          file_original: @file.original_filename,
          options: @options,
      }
      @attachment.instance_variable_set(:@paperclip_bulk_processor_queue, queue)

      BulkQueueItem.new(dst)
    end
  end

end