require 'etc'
require 'json'
require 'securerandom'
require 'fileutils'
require 'socket'
require 'rbconfig'
require 'open3'

class EndPointDetectionResponse
  LOG_FILE = "activity_log.json".freeze

  #Support for OS & Linux
  def start_process(path, args = nil)
    # current_operating_system = RbConfig::CONFIG["host_os"]
    command_line = "#{path}"
    command_line += " #{args}" if args

    output, status = Open3.capture2e(command_line)

    # if current_operating_system.include? "darwin"
    #   command_line = "open -na '#{path}'"
    #   command_line += " --args #{args}" if args
    # elsif current_operating_system.include? "linux"
    #   command_line = path
    #   command_line += " #{args}" if args
    # end

    # process_id = spawn(command_line)
    process_id = status.pid

    activity = {
      process_name: process_name(process_id),
      process_command_line: command_line,
      process_id: process_id
    }

    log_activity(activity)
    output
  end

  def create_file(file_path, file_type)
    FileUtils.mkdir_p(file_path) unless File.directory?(file_path)

    random_file_name = "random_#{SecureRandom.uuid}" + ".#{file_type}"
    full_file_path = File.join(file_path, random_file_name)

    # File.new(full_file_path, 'w')
    File.write(full_file_path, 'with content')

    activity = {
      full_path: full_file_path,
      activity_descriptor: "create"
    }

    log_activity(activity)
    full_file_path
  end

  def modify_file(file_path, content)
    File.write(file_path, content)

    activity = {
      full_path: file_path,
      activity_descriptor: "modification"
    }

    log_activity(activity)
  end

  def delete_file(file_path)
    File.delete(file_path)

    activity = {
      full_path: file_path,
      activity_descriptor: "delete"
    }

    log_activity(activity)
  end

  def network_transmit_data(destination, port, data)
    socket = UDPSocket.new
    socket.connect(destination, port)
    socket.write(data)
    destination = "#{destination}:#{port}"
    source = "#{socket.local_address.ip_address}:#{socket.local_address.ip_port}"
    socket.close

    activity = {
      source_address_port: source,
      destination_address_port: destination,
      data_size: data.bytesize,
      protocol: 'UDP'
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
