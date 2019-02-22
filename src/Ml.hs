module Ml where

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

createList :: [ShoppingList String]
createList = [Item "Apple", Item "Banana"]

modifyList :: [ShoppingList String]
modifyList = fmap (\(Item x) -> Item $x ++ "Functor") createList

modifyListApp :: Maybe (ShoppingList String)
modifyListApp =
  Just (\(Item x) -> Item $ (x ++ "Applicative")) <*> Just (Item "Apple")

modifyListAppL :: [ShoppingList String]
modifyListAppL =
  [\(Item x) -> Item $ (x ++ "Applicative")] <*> [Item "Apple", Item "Banana"]

justify (Just x) = Just x
