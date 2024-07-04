defmodule SampleAzure do
  @iot_hub_name Application.compile_env(:sample_azure, :iot_hub_name)
  @device_id Application.compile_env(:sample_azure, :device_id)
  @subscription_id Application.compile_env(:sample_azure, :subscription_id)

  @url "https://#{@iot_hub_name}.azure-devices.net/devices/#{@device_id}/messages/events?api-version=2018-06-30"

  @doc """
  IoT hubにメッセージを送信する。
  未ログイン時にはtrueを渡すこと。
  """
  def send_message(message, with_login \\ false) do
    if with_login, do: {_, 0} = System.cmd("az", ["login"])

    payload =
      Poison.encode!(%{
        message: message
      })

    headers = [
      {"Authorization", generate_sas_token()},
      {"Content-Type", "application/json"}
    ]

    HTTPoison.post!(
      @url,
      payload,
      headers
    )
  end

  @doc """
  SASトークンを生成する
  """
  def generate_sas_token() do
    {_, 0} = System.cmd("az", ["account", "set", "--subscription", @subscription_id])
    {result, 0} = System.cmd("az", ["iot", "hub", "generate-sas-token", "-n", @iot_hub_name])
    return_sas_token(result)
  end

  defp return_sas_token(result_string) do
    jason = Poison.decode!(result_string)
    Map.get(jason, "sas")
  end
end
