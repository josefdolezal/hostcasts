package controllers

import javax.inject.{Inject, Singleton}
import play.api.mvc.{AbstractController, ControllerComponents}

@Singleton
class ShowsController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

  def index = Action {
    Ok(views.html.index("index"))
  }

  def show(id: Int) = Action {
    Ok(views.html.index("show"))
  }

  def create = Action {
    Ok(views.html.index("create"))
  }

}
