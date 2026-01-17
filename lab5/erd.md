```Mermaid
---
config:
  layout: elk
  look: handDrawn
---
erDiagram
    USER ||--o| BUYER : "is a"
    USER ||--o| SELLER : "is a"
    USER ||--o| ADMINISTRATOR : "is a"
    
    SETTLEMENT ||--|{ ADDRESS : "contains"
    
    USER ||--o{ ADDRESS : "has"

    SELLER ||--o{ PRODUCT : "owns"
    CATEGORY ||--o{ PRODUCT : "categorizes"
    CATEGORY |o--o{ CATEGORY : "parent of"
    
    PRODUCT ||--o{ PRODUCT_PRICE_HISTORY : "tracks history"
    
    BUYER ||--o{ ORDER : "places"
    ORDER ||--|{ ORDER_ITEM : "contains"
    PRODUCT ||--o{ ORDER_ITEM : "included in"
    
    ORDER ||--o{ PAYMENT : "paid via"
    ORDER ||--|| SHIPMENT : "ships via"

    BUYER ||--o{ REVIEW : "writes"
    PRODUCT ||--o{ REVIEW : "receives"


    USER {
        int id PK
        string email UK
        string password_hash
        datetime created_at
        datetime deleted_at
    }

    BUYER {
        int id PK
        int user_id FK
        string first_name
        string last_name
        string phone
    }

    SELLER {
        int id PK
        int user_id FK
        string store_name UK
        string tax_id UK
        string iban
        boolean is_verified
    }

    ADMINISTRATOR {
        int id PK
        int user_id FK
        string full_name
        string access_level
    }

    SETTLEMENT {
        int id PK
        string country
        string city
        string region
    }

    ADDRESS {
        int id PK
        int user_id FK
        int settlement_id FK
        string street
        string building
        string apartment
        string zip_code
        boolean is_default
    }

    CATEGORY {
        int id PK
        int parent_id FK
        string name
    }

    PRODUCT {
        int id PK
        int seller_id FK
        int category_id FK
        string name
        text description
        decimal price
        int stock_quantity
        string sku UK
        boolean is_active
        int version
    }

    PRODUCT_PRICE_HISTORY {
        int id PK
        int product_id FK
        decimal price
        datetime changed_at
    }

    ORDER {
        int id PK
        int buyer_id FK
        decimal total_amount
        string status
        datetime created_at
    }

    ORDER_ITEM {
        int id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal price_at_purchase
    }

    PAYMENT {
        int id PK
        int order_id FK
        decimal amount
        string status
    }

    SHIPMENT {
        int id PK
        int order_id FK
        string country_snapshot
        string city_snapshot
        string street_snapshot
        string building_snapshot
        string apartment_snapshot
        string zip_code_snapshot
        string tracking_number
        string status
    }

    REVIEW {
        int id PK
        int product_id FK
        int buyer_id FK
        int rating
        text comment
    }
```