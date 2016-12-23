# symmetrical-octo-parakeet

## Intro

Inspectionary app made with [Phoenix framework](http://www.phoenixframework.org/), use as a playground to experiment
[Elixir](http://elixir-lang.org), RabbitMQ and [GraphQL](http://graphql.org/).


Has a series of endpoint at `/admin` that are viewable on the browser (standard phoenix scaffolding) plus an api
endpoint at `/admn/graphql` that accepts query and replies `json`

Following the set of enpoints:

```
[shipperizer@arbalester admin]$ mix phoenix.routes
user_path  GET     /admin/users            Admin.UserController :index
user_path  GET     /admin/users/:id/edit   Admin.UserController :edit
user_path  GET     /admin/users/new        Admin.UserController :new
user_path  GET     /admin/users/:id        Admin.UserController :show
user_path  POST    /admin/users            Admin.UserController :create
user_path  PATCH   /admin/users/:id        Admin.UserController :update
           PUT     /admin/users/:id        Admin.UserController :update
user_path  DELETE  /admin/users/:id        Admin.UserController :delete
video_path  GET     /admin/videos           Admin.VideoController :index
video_path  GET     /admin/videos/:id/edit  Admin.VideoController :edit
video_path  GET     /admin/videos/new       Admin.VideoController :new
video_path  GET     /admin/videos/:id       Admin.VideoController :show
video_path  POST    /admin/videos           Admin.VideoController :create
video_path  PATCH   /admin/videos/:id       Admin.VideoController :update
           PUT     /admin/videos/:id       Admin.VideoController :update
video_path  DELETE  /admin/videos/:id       Admin.VideoController :delete
           *       /api/graphql            Absinthe.Plug [schema: Admin.Schema]
```

## Up and running

To spin up:

* use the `docker-compose` file in the root folder, it's gonna create a rabbitmq container and a postgres server
* step into the `admin` folder and follow [these steps](http://www.phoenixframework.org/docs/up-and-running)
** most likely you won't need all of it but just:
```
[shipperizer@arbalester admin]$ mix deps.get && mix deps.compile # grab dependencies and compile
[shipperizer@arbalester admin]$ npm install # install frontend which should be really required
[shipperizer@arbalester admin]$ make setup # setup the db with the ecto migrations
```
* run it with `mix phoenix.server`

## Tests

Still lacking on those as I'm going thru that phoenix tutorial right now


## RabbitMQ

At every request made on the `html` api the app pushes a json message to the rabbitMQ server, nothing more than that

## GraphQL api

To poll the api make a GET (POST is still a wip) request to the server:

```
http://<phoenix-app>/api/graphql?query={users{id,name,videos{name,views,description}}}

{
   "data":{
      "users":[
         {
            "videos":[

            ],
            "name":"Joe",
            "id":"1"
         },
         {
            "videos":[
               {
                  "views":1,
                  "name":"Joe's house",
                  "description":"Nice "
               }
            ],
            "name":"matt",
            "id":"2"
         }
      ]
   }
}
```
