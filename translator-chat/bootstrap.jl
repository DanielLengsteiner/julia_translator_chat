(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using TranslatorChat
const UserApp = TranslatorChat
TranslatorChat.main()
