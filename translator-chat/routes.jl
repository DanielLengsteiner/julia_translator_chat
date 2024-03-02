using Genie.Router, Genie.Requests, Genie.Renderer.Json
import Genie.Renderer.Json: json
using GenieFramework
using SearchLight, SearchLightSQLite
using JSON
using HTTP
using TranslatorChat.Messages

SearchLight.Configuration.load() |> SearchLight.connect

route("/") do
  serve_static_file("welcome.html")
end

route("/messages", method = GET) do
  df = SearchLight.query("SELECT * FROM messages")

  sprev = ""
  for i in range(1, size(df, 1))
    sprev = sprev * "{\"lang\" : \"$(df[i,2])\", \"content\" : \"$(df[i,3])\"}"
    if i < size(df, 1)
      sprev = sprev * ","
    end
  end
  JSON.parse("[$(sprev)]") |> json
end

mutable struct Lang
  lang::String
end

l = Lang("")

route("chat/:language") do 
  model = @init
  @show model

  l.lang = params(:language)

  page(model, formui()) |> html
end

@genietools

# reactive code
@app begin
    @in send = false
    @in message = ""
    @in data = ""
    #@in lang = ""
    @out chat = ""

    @onchange message begin
        data = "soos " * message
    end

    @onbutton send begin
      SearchLight.save(Message(lang = l.lang, content = message))
    end
end

function formui()
  cell([
      textfield("Enter your message", :message),
      btn("Send", @click(:send))
  ])
end
