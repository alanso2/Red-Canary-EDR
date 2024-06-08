require_relative 'end_point_detection_response'

# Start of script
endpoint_detection = EndPointDetectionResponse.new
application_path = "/Users/alanso/Desktop/Google Chrome.app"
# endpoint_detection.start_process(application_path, "--incognito 'https://www.yahoo.com'")
# create_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files"
# endpoint_detection.create_file(create_path, "txt")
# edit_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files/random_3a2de320-c39b-49e4-b91d-2934b3227b4c.txt"
# edit_content = "Hello this is now modified again"
# endpoint_detection.modify_file(edit_path, edit_content)
delete_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files/random_4d605183.txt"
endpoint_detection.delete_file(delete_path)
