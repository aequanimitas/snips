defmodule Elixr do
  defmodule PatternMatching do
    defmodule Beer do
      def abv(:redhorse) do
          "6.9%"
      end
    
      def abv(:pilsen) do
        "5%" 
      end
    
      def abv(:strongice) do
        "6.3%" 
      end
    
      def abv(:flavored) do
        "3%" 
      end
    
      def abv(:cervezanegra) do
        "3%" 
      end
    
      def abv(:light) do
        "5%" 
      end
    
      def abv(name) do
        "Unknown beer: #{name}" 
      end
    end
  end
end
