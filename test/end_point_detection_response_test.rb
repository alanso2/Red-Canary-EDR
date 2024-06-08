require 'minitest/autorun'
require_relative '../lib/end_point_detection_response'

class EndPointDetectionResponseTest < Minitest::Test
  def setup
    @endpoint_detection = EndPointDetectionResponse.new
  end

  def test_create_file
    # Test: Create a file
    create_path = "../test_text_files"
    created_file = @endpoint_detection.create_file(create_path, "txt")

    assert(File.exist?(created_file), "File was not created")
  end

  def test_modify_file
    # Test: Modify the file
    edit_content = "Hello, this is now modified v2."
    created_file = "../test_text_files/test_file.txt"
    File.write(created_file, "Initial content")

    @endpoint_detection.modify_file(created_file, edit_content)

    assert_equal(edit_content, File.read(created_file), "File was not modified correctly")
  end

  def test_delete_file
    # Test: Delete the file
    created_file = "../test_text_files/test_file.txt"
    File.write(created_file, 'w')
    @endpoint_detection.delete_file(created_file)

    assert_equal(File.exist?(created_file), false)
  end

  def test_network_transmit_data
    # Test: Network activity
    url = "official-joke-api.appspot.com"
    port = 80
    data = "GET /random_joke HTTP/1.0\r\n\r\n"

    @endpoint_detection.network_transmit_data(url, port, data)
  end
end
