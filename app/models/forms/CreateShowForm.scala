package models.forms

import play.api.data._
import play.api.data.Forms._

case class CreateShowForm(title: String, description: String)

object CreateShowForm {
  val form: Form[CreateShowForm] = Form(
    mapping(
      "title" -> text,
      "description" -> text
    )(CreateShowForm.apply)(CreateShowForm.unapply)
  )
}
