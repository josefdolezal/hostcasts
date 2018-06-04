package controllers

import javax.inject.{Inject, Singleton}
import models.forms.CreateShowForm
import models.repository.ShowsRepository
import play.api.mvc.{AbstractController, AnyContent, ControllerComponents, Request}

import scala.concurrent.ExecutionContext

@Singleton
class ShowsController @Inject()(cc: ControllerComponents, showsRepo: ShowsRepository)(implicit ec: ExecutionContext) extends AbstractController(cc) with play.api.i18n.I18nSupport {

  def shows = Action.async {
    showsRepo.all.map { shows =>
      Ok(views.html.shows.shows(shows))
    }
  }

  def show(id: Int) = Action {
    Ok(views.html.shows.show())
  }

  def getCreate = Action { implicit request: Request[AnyContent] =>
    Ok(views.html.shows.create(CreateShowForm.form))
  }

  def postCreate = Action { implicit request =>
    CreateShowForm.form.bindFromRequest.fold(
      _    => BadRequest,
      data => {
        showsRepo.create(data.title, data.description)
        Redirect(routes.ShowsController.shows)
      }
    )
  }
}
