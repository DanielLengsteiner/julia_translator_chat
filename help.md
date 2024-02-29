# Help

Required Packages:

```julia
using Genie
using SearchLight, SearchLightSQLite
```

In the folder of the Julia-app, generate database support:

```julia
Genie.Generator.db_support()
```

In `db/connection.yml` add following code to configure connection:

```yml
env: ENV["GENIE_ENV"]

dev:
  adapter: SQLite
  database: db/books.sqlite
  config:
```

Load up the connection:
```julia
SearchLight.Configuration.load()
SearchLight.Configuration.load() |> SearchLight.connect
```

Initialize `SearchLight`-DB:

```julia
SearchLight.Migrations.init()
```

Add the resource:

```julia
SearchLight.Generator.newresource("message")
```

Edit migration-file to fit the resource:

```julia
# in db/migrations/*.create_table_messages.jl
function up()
    create_table(:messages) do
      [
        pk()
        column(:lang, :string)
        column(:content, :string)
      ]
    end
  
    add_index(:messages, :lang)
end
```

Ready up the migration table:

```julia
SearchLight.Migrations.last_up()
```

Defining the model:

```julia
# in app/resources/messages/views/Messages.jl
@kwdef mutable struct Message <: AbstractModel
    id::DbId = DbId()
    lang::String = ""
    content::String = ""
end
```

Using the model:

```julia
using Messages
m = Message(lang = "en", content = "Hello there!")
save(m)
```
