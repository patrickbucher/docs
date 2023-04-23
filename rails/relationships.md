# Relationships

| Relationship | Example                   | Left                | Right                |
|--------------|---------------------------|---------------------|----------------------|
| one-to-one   | one user has one address  | User (`has_one`)    | Address (nothing)    |
| one-to-many  | one author has many books | Author (`has_many`) | Book (`belongs_to`)  |
| many-to-many | orders with many Products | Order (`has_many`)  | Product (`has_many`) |

## One-to-many

Author and Books (an author has `n` books, with cascading deletion):

```ruby
class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  belongs_to :author
end
```

Create a new book for an author:

```ruby
@book = @author.books.create(published_at: Time.now)
```

Delete an author with all its books:

```ruby
@author.destroy
```

## Many-to-many

Order and Product (an order consists of `n` products, a product can be part of
multiple orders). The relation is an Item:

```ruby
class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
end

class Item < ApplicationRecord
  belongs_to :order
  belongs_to :product
end

class Product < ApplicationRecord
  has_many :items
  has_many :products, through: :items
end
```
