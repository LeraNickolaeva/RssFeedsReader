$ ->
  $('#entry_search').typeahead
    name: "entry"
    remote: "/entries/autocomplete?query=%QUERY"