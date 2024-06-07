require_relative 'end_point_detection_response'

# Start of script
endpoint_detection = EndPointDetectionResponse.new
application_path = "/Users/alanso/Desktop/Google Chrome.app"
# endpoint_detection.start_process(application_path, "--incognito 'https://www.yahoo.com'")
create_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files"
endpoint_detection.create_file(create_path, "txt")
