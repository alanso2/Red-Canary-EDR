require 'etc'
require 'json'

class EndPointDetectionResponse
  LOG_FILE = "activity_log.json".freeze

  def start_process(path, args = nil)
    command_line = "open -na '#{path}'"
    command_line += " --args #{args}" if !args.nil?

    process_id = spawn(command_line)

    activity = {
      process_name: process_name(process_id),
      process_command_line: command_line,
      process_id: process_id
    }

    log_activity(activity)
  end

  private

  def process_name(pid)
    `ps -p #{pid} -o comm=`.strip
  end

  def log_activity(details)
    activity = {
      start_time: Time.now.getutc.to_i,
      username: Etc.getlogin,
      process_name: process_name(Process.pid),
      process_command_line: $0,
      process_id: Process.pid
    }.merge!(details)

    append_to_log_file(activity)
  end

  def append_to_log_file(payload)
    File.open(LOG_FILE, 'a') do |file|
      file.puts(payload.to_json)
    end
  end
end
