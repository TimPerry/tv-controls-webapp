module Mutations exposing (..)

import GraphQL.Request.Builder as GraphQL
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import GraphQL.Client.Http as GraphQLClient
import Types exposing (..)
import Task exposing (Task)


-- Common


sendMutationRequest : GraphQL.Request GraphQL.Mutation a -> Task GraphQLClient.Error a
sendMutationRequest request =
    GraphQLClient.sendMutation "http://api.test.sl4u.co.uk/" request



-- AVR


avrMutation : GraphQL.Document GraphQL.Mutation String { vars | state : Bool, volume : Int }
avrMutation =
    let
        stateVar =
            Var.required "state" .state Var.bool

        volumeVar =
            Var.required "volume" .volume Var.int
    in
        GraphQL.mutationDocument <|
            GraphQL.extract
                (GraphQL.field "AVR"
                    [ ( "state", Arg.variable stateVar )
                    , ( "volume", Arg.variable volumeVar )
                    ]
                    GraphQL.string
                )


avrRequest : AVR -> GraphQL.Request GraphQL.Mutation String
avrRequest avr =
    avrMutation
        |> GraphQL.request { state = avr.state, volume = avr.volume }


sendAVRMutation : AVR -> Cmd Msg
sendAVRMutation avr =
    sendMutationRequest (avrRequest avr)
        |> Task.attempt ReceiveAVRMutationResponse
