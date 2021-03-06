name := "sbt-example"

organization := "com.example"

version := "1.0.0-SNAPSHOT"

scalacOptions += "-target:jvm-1.7"

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "2.2.4" % "test",
  "com.novocode" % "junit-interface" % "0.11" % "test->default"
)
