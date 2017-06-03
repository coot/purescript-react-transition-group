module React.ReactTranstionGroup 
  ( CSSTransitionGroupProps
  , createTransitionReactClass
  , defaultCSSTransitionGroupProps
  , reactClassToComponent
  , tagNameToComponent
  , transitionSpec
  , transitionSpec'
  ) where

import Control.Monad.Eff (Eff)
import Prelude (Unit, const, flip, id, pure, unit)
import React (ComponentDidMount, ComponentDidUpdate, ComponentWillMount, ComponentWillReceiveProps, ComponentWillUnmount, ComponentWillUpdate, GetInitialState, ReactClass, ReactElement, ReactThis, Render, ShouldComponentUpdate, TagName)
import React.DOM.Props (Props)
import Unsafe.Coerce (unsafeCoerce)

foreign import data Component :: Type -> Type

reactClassToComponent :: forall props. ReactClass props -> Component props
reactClassToComponent = unsafeCoerce

tagNameToComponent :: TagName -> Component Props
tagNameToComponent = unsafeCoerce

type CSSTransitionGroupProps props =
  { component :: Component props
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
  { component: tagNameToComponent "span"
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

type ComponentTransitionMethod props state eff
   = ReactThis props state
  -- transition callback
  -> Eff eff Unit
  -> Eff eff Unit

type ReactTransitionSpec props state eff =
  { render :: Render props state eff
  , displayName :: String
  , getInitialState :: GetInitialState props state eff
  , componentWillMount :: ComponentWillMount props state eff
  , componentDidMount :: ComponentDidMount props state eff
  , componentWillReceiveProps :: ComponentWillReceiveProps props state eff
  , shouldComponentUpdate :: ShouldComponentUpdate props state eff
  , componentWillUpdate :: ComponentWillUpdate props state eff
  , componentDidUpdate :: ComponentDidUpdate props state eff
  , componentWillUnmount :: ComponentWillUnmount props state eff
  , componentWillAppear :: ComponentTransitionMethod props state eff
  , componentDidAppear :: ComponentTransitionMethod props state eff
  , componentWillEnter :: ComponentTransitionMethod props state eff
  , componentDidEnter :: ComponentTransitionMethod props state eff
  , componentWillLeave :: ComponentTransitionMethod props state eff
  , componentDidLeave :: ComponentTransitionMethod props state eff
  }

transitionSpec
  :: forall props state eff
   . state
  -> Render props state eff
  -> ReactTransitionSpec props state eff
transitionSpec state = transitionSpec' \_ -> pure state

transitionSpec'
  :: forall props state eff
   . GetInitialState props state eff
  -> Render props state eff
  -> ReactTransitionSpec props state eff
transitionSpec' getInitialState renderFn =
  { render: renderFn
  , displayName: ""
  , getInitialState: getInitialState
  , componentWillMount: \_ -> pure unit
  , componentDidMount: \_ -> pure unit
  , componentWillReceiveProps: \_ _ -> pure unit
  , shouldComponentUpdate: \_ _ _ -> pure true
  , componentWillUpdate: \_ _ _ -> pure unit
  , componentDidUpdate: \_ _ _ -> pure unit
  , componentWillUnmount: \_ -> pure unit
  , componentWillAppear: flip const
  , componentDidAppear: flip const
  , componentWillEnter: flip const
  , componentDidEnter: flip const
  , componentWillLeave: flip const
  , componentDidLeave: flip const
  }

foreign import createTransitionReactClass
  :: forall props state eff
   . ReactTransitionSpec props state eff
  -> ReactClass props
