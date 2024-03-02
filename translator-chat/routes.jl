using Genie.Router
using SearchLight, SearchLightSQLite
using JSON
import Genie.Renderer.Json: json

SearchLight.Configuration.load() |> SearchLight.connect

route("/") do
  serve_static_file("welcome.html")
end

route("/chat") do
  df = SearchLight.query("SELECT * FROM messages")

  sprev = ""
  for i in range(1, size(df, 1))
    sprev = sprev * "{\"lang\" : \"$(df[i,2])\", \"content\" : \"$(df[i,3])\"}"
    if i < size(df, 1)
      sprev = sprev * ","
    end
  end
  s = "[$(sprev)]" 
  JSON.parse(s) |> json
end