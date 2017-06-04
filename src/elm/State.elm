module State exposing (..)

import Types exposing (..)
import Ui.Tabs
import Ui.Checkbox
import Mutations exposing (sendAVRMutation)


init : ( Model, Cmd Msg )
init =
    ( { checkbox = Ui.Checkbox.init ()
      , tabs = Ui.Tabs.init ()
      , avr = { state = True, volume = 55 }
      }
    , Cmd.none
    )


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
            ( model, sendAVRMutation model.avr )

        ReceiveAVRMutationResponse response ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Ui.Checkbox.onChange AVRSetPowerState model.checkbox
