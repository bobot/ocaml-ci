module type View = sig
  module Client = Ocaml_ci_api.Client
  module Build_status = Build_status

  val prefix : string

  val cancel_success_message : 
    Client.job_info list -> [> `Div | `Ul ] Tyxml_html.elt

  val cancel_fail_message : 
    int -> [> Html_types.div ] Tyxml_html.elt

  val rebuild_success_message : 
    Client.job_info list -> [> `Div | `Ul ] Tyxml_html.elt

  val rebuild_fail_message : 
    int -> [> Html_types.div ] Tyxml_html.elt

  val return_link :
    org:string ->
    repo:string ->
    hash:string ->
    [> [> Html_types.txt ] Html_types.a ] Tyxml_html.elt

  val list_orgs : orgs:string list -> string

  val list_repos : org:string -> repos:Client.Org.repo_info list -> string

  val list_refs :
    org:string ->
    repo:string ->
    refs:(string * Build_status.t) Client.Ref_map.t ->
    string

  val list_steps :
    org:string ->
    repo:string ->
    refs:string list ->
    hash:string ->
    jobs:Client.job_info list ->
    ?success_msg:
      ([< Html_types.div_content_fun > `Div `Ol `P `PCDATA `Ul ] as 'a)
      Tyxml_html.elt ->
    ?fail_msg:'a Tyxml_html.elt ->
    ?return_link:'a Tyxml_html.elt ->
    ?flash_messages:(string * string) list ->
    csrf_token:string ->
    unit ->
    string

  val show_step :
    org:string ->
    repo:string ->
    refs:string list ->
    hash:string ->
    jobs:Client.job_info list ->
    variant:Client.variant ->
    job:Current_rpc.Job.t ->
    status:Current_rpc.Job.status ->
    csrf_token:string ->
    ?flash_messages:(string * string) list ->
    string * int64 ->
    Dream.response Lwt.t
end