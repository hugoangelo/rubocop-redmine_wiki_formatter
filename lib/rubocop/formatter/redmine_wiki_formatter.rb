module RuboCop
  module Formatter
    # A Redmine wiki formatter that displays only files with offenses.
    class RedmineWikiFormatter < BaseFormatter
      include PathUtil, TextUtil

      def started(_target_files)
        @files = []
        @total_offense_file_count = 0
        @total_offense_count = 0
        @total_correction_count = 0
        output.printf("h1. RuboCop (version %s) Inspection Report\r\n\r\n", RuboCop::Version::STRING)
      end

      def file_finished(file, offenses)
        @files << file
        return if offenses.empty?
        @total_offense_file_count += 1
        count_stats(offenses)
        report_file(file, offenses)
      end

      def finished(inspected_files)
        output.printf("h2. Summary\r\n\r\n")
        output.printf("* Generated on %s\r\n", DateTime.now)
        output.printf("* %s inspected, %s detected in %s\r\n", 
          pluralize(@files.count, 'file'), 
          pluralize(@total_offense_count, 'offense', no_for_zero: true),
          pluralize(@total_offense_file_count, 'file'))
      end

      def report_file(file, offenses)
        output.puts("h2. #{smart_path(file)} - #{pluralize(offenses.count, 'offense')}\r\n\r\n")

        offenses.each do |o|
          output.printf("h3. Line %d, Column %d\r\n\r\n%s\r\n", o.line, o.real_column, message(o))
          output.printf("<pre><code>%s</code></pre>\r\n\r\n", o.location.source_line)
        end
        output.printf("\r\n")
      end

      private

      def count_stats(offenses)
        @total_offense_count += offenses.count
        @total_correction_count += offenses.count(&:corrected?)
      end

      def smart_path(path)
        # Ideally, we calculate this relative to the project root.
        base_dir = Dir.pwd

        if path.start_with? base_dir
          relative_path(path, base_dir)
        else
          path
        end
      end

      def message(offense)
        message = offense.corrected? ? '[Corrected] ' : ''
        message << offense.message
      end
    end
  end
end
