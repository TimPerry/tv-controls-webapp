module View exposing (..)

import Types exposing (..)
import Html
import Html.Attributes
import Ui.Checkbox
import Ui.Tabs
import Ui.Slider


view : Model -> Html.Html Msg
view model =
    let
        avrTabContent =
            Html.div []
                [ Html.h5 [] [ Html.text "Power" ]
                , Html.map CheckboxMsg (Ui.Checkbox.viewToggle model.checkbox)
                , Html.h5 [] [ Html.text "Volume" ]
                , Html.map SliderMsg (Ui.Slider.view model.slider)
                ]
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
