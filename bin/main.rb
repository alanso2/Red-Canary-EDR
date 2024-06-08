require_relative '../lib/end_point_detection_response'

# Start of script
# Initialization of framework
endpoint_detection = EndPointDetectionResponse.new

# Starting/executing a process
application_path = "/Users/alanso/Desktop/Google Chrome.app"
start_process = endpoint_detection.start_process(application_path, "--incognito 'https://www.yahoo.com'")

#Create file
create_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files"
create_file = endpoint_detection.create_file(create_path, "txt")

#Modify file
edit_path = "/Users/alanso/Desktop/Projects/Red-Canary-EDR/test_text_files/random_3a2de320-c39b-49e4-b91d-2934b3227b4c.txt"
edit_content = "Hello this is now modified again"
modify_file = endpoint_detection.modify_file(edit_path, edit_content)

#Delete file
endpoint_detection.delete_file(create_file)

#Data transmission
url = "https://official-joke-api.appspot.com"
data = "this is another test data should be different this time"
network_transmit_data = endpoint_detection.network_transmit_data(url, 443, data)
