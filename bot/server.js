process.env.PORT              = process.env.PORT              || 8000
process.env.HOST              = process.env.HOST              || "https://localhost"
process.env.NODE_ENV          = process.env.NODE_ENV          || "dev"
process.env.FRAMEWORK_ROOT    = process.env.FRAMEWORK_ROOT    || "D:/home/site/viseo-bot-framework"
process.env.BOT_ROOT          = process.env.BOT_ROOT          || "D:/home/site/wwwroot"
process.env.CONFIG_PATH       = process.env.CONFIG_PATH       || (process.env.BOT_ROOT+"/conf/config.js")
process.env.CREDENTIAL_SECRET = process.env.CREDENTIAL_SECRET || "your secret here"

process.argv.push("-s")
process.argv.push(process.env.FRAMEWORK_ROOT +"/conf/node-red-config.js")

require(process.env.FRAMEWORK_ROOT+'/node_modules/node-red/red.js')