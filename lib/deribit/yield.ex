defmodule Deribit.Yield do
  defp get_json(url) do
    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(url)
    Poison.decode!(body)["result"]
  end

  defp instruments do
    "https://www.deribit.com/api/v2/public/get_instruments?currency=BTC&kind=future"
    |> get_json()
    |> Enum.map(&(Map.take(&1, ["instrument_name", "expiration_timestamp"])))
    |> Enum.filter(&(&1["instrument_name"] != "BTC-PERPETUAL"))
    |> Enum.sort_by(&(&1["expiration_timestamp"]))
  end

  defp ticker(name) do
    "https://www.deribit.com/api/v2/public/ticker?instrument_name=#{name}"
    |> get_json()
    |> Map.take(["index_price", "mark_price"])
  end

  defp price(instrument) do
    Map.merge(instrument, ticker(instrument["instrument_name"]))
  end

  defp yield(instrument) do
    seconds_to_expiry = DateTime.diff(
      DateTime.from_unix!(instrument["expiration_timestamp"], :millisecond),
      DateTime.utc_now())

    yield = (instrument["mark_price"] - instrument["index_price"]) / instrument["index_price"]
    annualised_yield = yield / (seconds_to_expiry / (60 * 60 * 24 * 365))

    Map.put(instrument, "yield", annualised_yield)
  end

  def all do
    instruments()
    |> Enum.map(&price/1)
    |> Enum.map(&yield/1)
  end
end
