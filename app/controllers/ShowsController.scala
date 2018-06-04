package controllers

import javax.inject.{Inject, Singleton}
import models.repository.ShowsRepository
import play.api.mvc.{AbstractController, ControllerComponents}
import scala.concurrent.ExecutionContext

@Singleton
class ShowsController @Inject()(cc: ControllerComponents, showsRepo: ShowsRepository)(implicit ec: ExecutionContext) extends AbstractController(cc) {

  def shows = Action.async {
    showsRepo.all.map { shows =>
      Ok(views.html.shows.shows(shows))
    }
  }

  def show(id: Int) = Action {
    Ok(views.html.shows.show())
  }

  def create = Action {
    Ok(views.html.shows.create())
  }

}
