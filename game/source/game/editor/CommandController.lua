local CommandController = {}

CommandController.commands = {}

function CommandController.run(text)
    local args = string.split(text, " ")
    local command = args[1]
    table.remove(args, 1)

    if CommandController.commands[command] then
        CommandController.commands[command](unpack(args))
    end
end

return CommandController
