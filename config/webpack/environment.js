const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')

environment.loaders.append('typescript', typescript)
environment.loaders.prepend('typescript', typescript)
module.exports = environment
