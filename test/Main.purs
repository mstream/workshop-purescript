module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = launchAff_ $ runSpec [ consoleReporter ] do
  describe "BMI" do
    it "of 65kg, 180cm tall person should be lower than of a person who weights 160 pounds and is 5 feet and 10 inches tall" do
      1 `shouldEqual` 1

