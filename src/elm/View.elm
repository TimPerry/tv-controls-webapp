module View exposing (..)

import Types exposing (..)
import Html
import Html.Attributes
import Ui.Checkbox
import Ui.Tabs


view : Model -> Html.Html Msg
view model =
    let
        avrTabContent =
            Html.map CheckboxMsg (Ui.Checkbox.viewToggle model.checkbox)
    in
        Html.div [ Html.Attributes.style [ ( "padding", "2rem" ) ] ]
            [ (Ui.Tabs.view
                { contents =
                    [ ( "AVR", avrTabContent )
                    ]
                , address = TabsMsg
                }
                model.tabs
              )
            ]
