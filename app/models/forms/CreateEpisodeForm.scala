package models.forms

import play.api.data._
import play.api.data.Forms._

case class CreateEpisodeForm(title: String, description: String)

object CreateEpisodeForm {
  val form: Form[CreateEpisodeForm] = Form(
    mapping(
    "title" -> text,
    "description" -> text
    )(CreateEpisodeForm.apply)(CreateEpisodeForm.unapply)
  )
}
