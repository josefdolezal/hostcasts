package controllers

import javax.inject.{Inject, Singleton}
import play.api.mvc.{AbstractController, ControllerComponents}

@Singleton
class ShowsController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

  def shows = Action {
    Ok(views.html.shows.shows())
  }

  def show(id: Int) = Action {
    Ok(views.html.shows.show())
  }

  def create = Action {
    Ok(views.html.shows.create())
  }

}
