#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/end_point_detection_response'
require 'fileutils'

class EndPointDetectionResponseTest < Minitest::Test
  def setup
    @endpoint_detection = EndPointDetectionResponse.new
    @test_dir = File.expand_path("../test_text_files", __FILE__)
    FileUtils.mkdir_p(@test_dir)
  end

  def teardown
    FileUtils.rm_rf(@test_dir)
  end

  def test_start_process
    # Test: Start a process
    test_script_path = File.expand_path("../test_script.rb", __FILE__)
    path = "test_script.rb"
    args = "arg1 arg2 arg3"

    output = @endpoint_detection.start_process(test_script_path, args)
    assert_equal(output, "Hello this is used to text for executable file\n")
  end

  def test_create_file
    # Test: Create a file
    created_file = @endpoint_detection.create_file(@test_dir, "txt")

    assert(File.exist?(created_file), "File was not created")
  end

  def test_modify_file
    # Test: Modify the file
    edit_content = "Hello, this is now modified v2."
    created_file = File.join(@test_dir, "test_file.txt")
    File.write(created_file, "Initial content")

    @endpoint_detection.modify_file(created_file, edit_content)

    assert_equal(edit_content, File.read(created_file), "File was not modified correctly")
  end

  def test_delete_file
    # Test: Delete the file
    # created_file = "../test_text_files/test_file.txt"
    created_file = File.join(@test_dir, "test_file.txt")
    File.write(created_file, 'w')
    @endpoint_detection.delete_file(created_file)

    assert_equal(File.exist?(created_file), false)
  end
end
