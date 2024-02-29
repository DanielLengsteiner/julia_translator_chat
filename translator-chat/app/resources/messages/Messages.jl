module Messages

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Message

@kwdef mutable struct Message <: AbstractModel
  id::DbId = DbId()
  lang::String = ""
  content::String = ""
end

end
