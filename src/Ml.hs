module Ml where


data ShoppingList a
  = Empty
  | Item a 
  | Listofitems [ShoppingList a]
  deriving (Show)



instance Functor ShoppingList where
  fmap f Empty    = Empty
  fmap f (Item i) = Item (f i)
  fmap f (Listofitems ls) = Listofitems $ fmap (fmap f) ls


  --fmap f (Listofitems ((Item a):Listofitems [as])) = Listofitems $ (fmap f (Item a)) (fmap f Listofitems [as])


createList :: ShoppingList String
createList = Listofitems [Item "Apricot",Listofitems [Item "Apple",Item "Banana"]]
            

modifyList :: ShoppingList String
modifyList = fmap (++ "Modified") createList








