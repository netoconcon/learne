import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpacker-helpers"

const application = Application.start()
const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context))