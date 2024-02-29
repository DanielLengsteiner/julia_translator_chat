module CreateTableMessages

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

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

function down()
  drop_table(:messages)
end

end
