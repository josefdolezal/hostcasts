package models.repository

import javax.inject.{Inject, Singleton}
import models.Episode
import play.api.db.slick.DatabaseConfigProvider
import slick.jdbc.JdbcProfile

import scala.concurrent.{ExecutionContext, Future}

@Singleton
class EpisodesRepository @Inject()(dbConfigProvider: DatabaseConfigProvider)(implicit ec: ExecutionContext) {
  private val dbConfig = dbConfigProvider.get[JdbcProfile]

  import dbConfig._
  import profile.api._

  private class EpisodesTable(tag: Tag) extends Table[Episode](tag, "episodes") {
    def id = column[Long]("id", O.PrimaryKey, O.AutoInc)

    def title = column[String]("title")

    def description = column[String]("description")

    def * = (id, title, description) <> ((Episode.apply _).tupled, Episode.unapply)
  }

  private val episodes = TableQuery[EpisodesTable]

  def findById(id: Long): Future[Option[Episode]] = db.run(episodes.filter(_.id === id).result.headOption)

  def getByShowId(showId: Long): Future[Seq[Episode]] = all

  def all: Future[Seq[Episode]] = db.run(episodes.result)
}