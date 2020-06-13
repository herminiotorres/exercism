defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons =
      for codon <- rna |> String.codepoints() |> Enum.chunk_every(3),
          do: Enum.join(codon)

    proteins =
      codons
      |> Enum.map(fn codon -> get_protein(codon) end)

    cond do
      Enum.member?(proteins, {:error, "invalid codon"}) -> {:error, "invalid RNA"}
      true -> {:ok, filter_proteins(proteins)}
    end
  end

  defp get_protein(codon) do
    with {:ok, protein} <- of_codon(codon), do: protein
  end

  defp filter_proteins([]), do: []

  defp filter_proteins([head | list]) do
    cond do
      head != "STOP" -> [head | filter_proteins(list)]
      head == "STOP" -> filter_proteins([])
      head == "invalid RNA" -> "invalid RNA"
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    cond do
      Enum.member?(["AUG"], codon) -> {:ok, "Methionine"}
      Enum.member?(["UUU", "UUC"], codon) -> {:ok, "Phenylalanine"}
      Enum.member?(["UUA", "UUG"], codon) -> {:ok, "Leucine"}
      Enum.member?(["UCU", "UCC", "UCA", "UCG"], codon) -> {:ok, "Serine"}
      Enum.member?(["UAU", "UAC"], codon) -> {:ok, "Tyrosine"}
      Enum.member?(["UGU", "UGC"], codon) -> {:ok, "Cysteine"}
      Enum.member?(["UGG"], codon) -> {:ok, "Tryptophan"}
      Enum.member?(["UAA", "UAG", "UGA"], codon) -> {:ok, "STOP"}
      true -> {:error, "invalid codon"}
    end
  end
end
