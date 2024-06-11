#!/usr/bin/env ruby

require_relative '../lib/end_point_detection_response'

def main
  endpoint_detection = EndPointDetectionResponse.new

  case ARGV[0]
  when "start_process"
    path = ARGV[1]
    args = ARGV[2..-1].join(' ')
    puts endpoint_detection.start_process(path, args)
  when "create_file"
    file_path = ARGV[1]
    file_type = ARGV[2]
    puts endpoint_detection.create_file(file_path, file_type)
  when "modify_file"
    file_path = ARGV[1]
    content = ARGV[2..-1]
    endpoint_detection.modify_file(file_path, content)
  when "delete_file"
    file_path = ARGV[1]
    puts endpoint_detection.delete_file(file_path)
  when "network_transmit_data"
    destination = ARGV[1]
    port = ARGV[2].to_i
    data = ARGV[3..-1].join(" ")
    endpoint_detection.network_transmit_data(destination, port, data)
  else
    puts "Unknown command"
  end
end

if __FILE__ == $PROGRAM_NAME
  main
end
