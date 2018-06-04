package controllers

import javax.inject.{Inject, Singleton}
import models.forms.{CreateEpisodeForm}
import models.repository.{EpisodesRepository, ShowsRepository}
import play.api.mvc.{AbstractController, ControllerComponents}

import scala.concurrent.ExecutionContext

@Singleton
class EpisodesController @Inject()(cc: ControllerComponents, showsRepo: ShowsRepository, episodesRepo: EpisodesRepository)(implicit ec: ExecutionContext) extends AbstractController(cc) with play.api.i18n.I18nSupport {
  def episode(showId: Long, episodeId: Long) = Action.async {
    episodesRepo.findById(episodeId).map { episode =>
      episode match {
        case Some(e) => Ok(views.html.episodes.episode(e))
        case None    => NotFound
      }
    }
  }

  def getCreate(showId: Long) = Action.async { implicit request =>
    showsRepo.findById(showId).map { show =>
      show match {
        case Some(s) => Ok(views.html.episodes.create(s, CreateEpisodeForm.form))
        case None    => NotFound
      }
    }
  }

  def postCreate(showId: Long) = Action.async { implicit request =>
    showsRepo.findById(showId).map { show =>
      show match {
        case Some(s) =>
          CreateEpisodeForm.form.bindFromRequest.fold(
            _ => BadRequest,
            data => {
              episodesRepo.create(data.title, data.description)
              Redirect(routes.ShowsController.show(showId))
            }
          )
        case None    => NotFound
      }

    }
  }
}
