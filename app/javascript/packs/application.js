import "style/application.scss"
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Rails from "rails-ujs"
import Turbolinks from "turbolinks"

const application = Application.start()
const context = require.context("controllers", true, /.(js|ts)$/)
application.load(definitionsFromContext(context))

Rails.start();
Turbolinks.start();
