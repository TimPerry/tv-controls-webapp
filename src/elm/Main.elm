module Main exposing (..)

import Html
import Ui.Checkbox
import Ui.Tabs


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { checkbox = Ui.Checkbox.init ()
      , tabs = Ui.Tabs.init ()
      }
    , Cmd.none
    )


type alias Model =
    { checkbox : Ui.Checkbox.Model
    , tabs : Ui.Tabs.Model
    }


type Msg
    = CheckboxMsg Ui.Checkbox.Msg
    | TabsMsg Ui.Tabs.Msg
    | AVRSetPowerState Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckboxMsg msg ->
            let
                ( subModel, subMsg ) =
                    Ui.Checkbox.update msg model.checkbox
            in
                ( { model | checkbox = subModel }, Cmd.map CheckboxMsg subMsg )

        TabsMsg msg ->
            let
                ( subModel, subMsg ) =
                    Ui.Tabs.update msg model.tabs
            in
                ( { model | tabs = subModel }, Cmd.map TabsMsg subMsg )

        AVRSetPowerState state ->
            ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    let
        avrTabContent =
            Html.map CheckboxMsg (Ui.Checkbox.viewToggle model.checkbox)
    in
        Html.div []
            [ (Ui.Tabs.view
                { contents =
                    [ ( "AVR", avrTabContent )
                    ]
                , address = TabsMsg
                }
                model.tabs
              )
            ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Ui.Checkbox.onChange AVRSetPowerState model.checkbox
