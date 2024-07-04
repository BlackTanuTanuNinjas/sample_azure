defmodule SampleAzureTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
    :ok
  end

  test "successfully sended a message" do
    use_cassette "send_message" do
      assert %HTTPoison.Response{} = SampleAzure.send_message("test message")
    end
  end

  test "successfully generated sas token" do
    assert is_binary(SampleAzure.generate_sas_token())
  end
end
