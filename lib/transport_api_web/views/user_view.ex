defmodule TransportApiWeb.UserView do
  use TransportApiWeb, :view
  alias TransportApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      password_hash: user.password_hash,
      cell: user.cell
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("shownew.json", %{user: user}) do
    %{data: render_one(user, UserView, "signedup.json")}
  end


  def render("signedup.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      password_hash: user.password_hash,
      cell: user.cell
    }
  end


  def render("signedin.json", %{user: user}) do
    %{

      email: user.email
    }
  end







end
