#! /usr/bin/elixir

# this is a simple script to monthly tagging git
# for I always rewrite the history and tags will be missing
# use elixir is, fun and elegant

defmodule GitMonthlyTag do
  def main do
    get_log()
    |> parse_date()
    #|> IO.inspect()
    |> sort_by_m()
    |> Enum.map(&gen_tag_cmd(&1))
    #|> Enum.each(&IO.puts(&1))
    |> Enum.each(&System.shell(&1) |> IO.inspect())
  end

  def get_log do
    {log, 0} =
      System.cmd("git", ["log", "--reverse", "--pretty='%as %h'"])
    log
    |> String.trim()
    |> String.replace(~r/['-]/, "")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&List.to_tuple(&1))
  end

  def parse_date(data) do
    data
    |> Enum.map(fn {date, hash} ->
      {String.to_integer(date), hash} end)
  end

  def sort_by_m(data) do
    psort(data, 19700101, [])
  end

  defp psort([], _, acc), do: acc
  defp psort([{hd, hash} | tl], prev, acc) do
    cond do
      hash==prev ->
        psort(tl(tl), hd, acc)
      Enum.any?(prev..hd, fn x -> rem(x, 100) == 0 end) ->
        psort(tl, hd, [{hd, hash} | acc])
      true ->
        psort(tl, hd, acc)
    end
  end

  def gen_tag_cmd({date_n, hash}) do
    ym = div(date_n, 100)
    y = rem(div(ym, 100), 100)
    m = rem(ym, 100)
    "git tag #{y}.#{m} #{hash}"
  end
end

GitMonthlyTag.main()

