package controllers

import javax.inject.{Inject, Singleton}
import models.repository.{EpisodesRepository, ShowsRepository}
import play.api.mvc.{AbstractController, ControllerComponents}

import scala.concurrent.ExecutionContext

@Singleton
class ShowsAPIController @Inject()(cc: ControllerComponents, showsRepo: ShowsRepository, episodesRepo: EpisodesRepository)(implicit ec: ExecutionContext) extends AbstractController(cc) with play.api.i18n.I18nSupport {
  def show(showId: Long) = Action.async {
    val data = for {
      show <- showsRepo.findById(showId)
      episodes <- episodesRepo.getByShowId(showId)
    } yield (show, episodes)

    data.map {
      case (show, episodes) =>
        show match {
          case Some(s) => Ok(views.xml.api.shows.show(s, episodes))
          case None    => NotFound
        }
    }
  }
}