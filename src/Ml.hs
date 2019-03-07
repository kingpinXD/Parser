module Ml where

import Control.Monad.Writer

data ShoppingList a
  = Empty
  | Item a
 -- | Listofitems [ShoppingList a]


  deriving (Show)

instance Functor ShoppingList where
  fmap f Empty    = Empty
  fmap f (Item i) = Item (f i)
  --fmap f (Listofitems ls) = Listofitems $ fmap (fmap f) ls



instance Applicative ShoppingList where
  pure x = Empty
  f <*> Empty = Empty
  Item f <*> Item a = Item $ f a
  --Item f <*> Listofitems a = Listofitems $ (f <*>) <*> a


  --fmap f (Listofitems ((Item a):Listofitems [as])) = Listofitems $ (fmap f (Item a)) (fmap f Listofitems [as])



instance Monad ShoppingList where
  return x = Empty
  Empty >>= f = Empty
  Item a >>= f = f a

createList :: [ShoppingList String]
createList = [Item "Apple", Item "Banana"]

modifyList :: [ShoppingList String]
modifyList = fmap (\(Item x) -> Item $x ++ "Functor") createList

modifyListApp :: ShoppingList String
modifyListApp = Item (\x -> x ++ "Applicative") <*> Item "Apple"

modifyListDoubleApp :: [ShoppingList String]
modifyListDoubleApp = [\x ->  Item (\y -> y ++ "Doubleapplicative")<*> x] <*> [Item "Apple", Item "Banana"]
  --[(\x -> x)] <*> [Item "Apple", Item "Banana"]


modifyListMon :: ShoppingList String
modifyListMon =  (Item "Apricot" >>= (\x -> Item x)) >>= (\x -> Item "Banana")


logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
    a <- logNumber 3
    b <- logNumber 5
    return (a*b)

--multiWith :: Writer [String] Int
--multiWith = 3 >>= (\x -> writer (x, ["Got number: " ++ show x])) 


 
justify (Just x) = Just x

