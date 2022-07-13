package compras

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        get "/"(controller: "login", view:"/login")
        post "/login/saludo"(controller: "login", action:"/saludo")
        "500"(view:'/error')
        "404"(view:'/notFound')

    }
}
