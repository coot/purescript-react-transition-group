module React.ReactTranstionGroup where

import Prelude (id)
import React (ReactClass, ReactElement)
import React.DOM.Props (Props)
import Unsafe.Coerce (unsafeCoerce)

type CSSTransitionGroupProps props =
  { component :: ReactClass props
  , transitionName ::
    { enter :: String
    , enterActive :: String
    , leave :: String
    , leaveActive :: String
    , appear :: String
    , appearActive :: String
    }
  , childFactory :: ReactElement -> ReactElement
  , transitionAppear :: Boolean
  , transitionAppearTimeout :: Int
  , transitionLeave :: Boolean
  , transitionLeaveTimeout :: Int
  , transitionEnter :: Boolean
  , transitionEnterTimeout :: Int
  }

defaultCSSTransitionGroupProps :: CSSTransitionGroupProps Props
defaultCSSTransitionGroupProps =
  { component: unsafeCoerce "span"
  , transitionName:
    { enter: "enter"
    , enterActive: "enter-active"
    , leave: "leave"
    , leaveActive: "leave-active"
    , appear: "appear"
    , appearActive: "appear-active"
    }
  , childFactory: id
  , transitionEnter: true
  , transitionEnterTimeout: 300
  , transitionLeave: true
  , transitionLeaveTimeout: 300
  , transitionAppear: false
  , transitionAppearTimeout: 300
  }

foreign import cssTransitionGroup :: forall props. ReactClass (CSSTransitionGroupProps props)
