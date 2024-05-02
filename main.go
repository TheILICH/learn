package main

import (
    "html/template"
    "net/http"
)

var templates *template.Template

func main() {
    var err error
    templates, err = template.ParseGlob("templates/*.html")
    if err != nil {
        panic(err)
    }

    http.HandleFunc("/", homeHandler)
    http.ListenAndServe(":80", nil)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
    data := map[string]interface{}{
        "Message": "Hello, this is first message!",
    }

    err := templates.ExecuteTemplate(w, "home.html", data)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
}
