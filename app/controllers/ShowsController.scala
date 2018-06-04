package controllers

import javax.inject.{Inject, Singleton}
import models.forms.CreateShowForm
import models.repository.{EpisodesRepository, ShowsRepository}
import play.api.mvc.{AbstractController, AnyContent, ControllerComponents, Request}

import scala.concurrent.ExecutionContext

@Singleton
class ShowsController @Inject()(cc: ControllerComponents, showsRepo: ShowsRepository, episodesRepo: EpisodesRepository)(implicit ec: ExecutionContext) extends AbstractController(cc) with play.api.i18n.I18nSupport {

  def shows = Action.async {
    showsRepo.all.map { shows =>
      Ok(views.html.shows.shows(shows))
    }
  }

  def show(id: Long) = Action.async {
    val data = for {
      show <- showsRepo.findById(id)
      episodes <- episodesRepo.getByShowId(id)
    } yield (show, episodes)

    data.map {
      case (show, episodes) =>
        show match {
          case Some(s) => Ok(views.html.shows.show(s, episodes))
          case None    => NotFound
        }
    }
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
