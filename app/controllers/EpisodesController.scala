package controllers

import javax.inject.{Inject, Singleton}
import play.api.mvc.{AbstractController, ControllerComponents}

@Singleton
class EpisodesController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {
  def episode(showId: Int, episodeId: Int) = Action {
    Ok(views.html.episodes.episode())
  }

  def create(episodeId: Int) = Action {
    Ok(views.html.episodes.create())
  }
}
