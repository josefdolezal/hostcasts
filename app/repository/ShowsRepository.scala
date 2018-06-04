package repository

import javax.inject.{Inject, Singleton}

import scala.concurrent.{ExecutionContext, Future}
import play.api.db.slick.DatabaseConfigProvider
import slick.jdbc.JdbcProfile
import models.Show

@Singleton
class ShowsRepository @Inject()(dbConfigProvider: DatabaseConfigProvider)(implicit ec: ExecutionContext) {
  private val dbConfig = dbConfigProvider.get[JdbcProfile]

  import dbConfig._
  import profile.api._

  private class ShowsTable(tag: Tag) extends Table[Show](tag, "shows") {

    def id = column[Long]("id", O.PrimaryKey, O.AutoInc)

    def title = column[String]("title")

    def description = column[String]("description")

    def * = (id, title, description) <> ((Show.apply _).tupled, Show.unapply)
  }

  private val shows = TableQuery[ShowsTable]

  def create(title: String, description: String): Future[Show] = db.run {
    (shows.map(s => (s.title, s.description))
      returning shows.map(_.id)
      into((data, id) => Show(id, data._1, data._2) )
    ) += (title, description)
  }

  def all: Future[Seq[Show]] = db.run {
    shows.result
  }
}
